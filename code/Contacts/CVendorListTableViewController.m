//
//  CVendorListTableViewController.m
//  Contacts
//
//  Created by Abid MAC-Mini on 05/09/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CVendorListTableViewController.h"
#import "CServer.h"
#import "CServerInterface.h"
#import "CLocal.h"
#import "CLocalInterface.h"
#import "CEditViewController.h"
#import "CDisplayViewController.h"
#import "CConstants.h"
#import "UIAlertView+ZPBlockAdditions.h"
#import "NSMutableDictionary+Additions.h"

#import "MBProgressHUD.h"

#import "CServerUserInterface.h"
#import "CServerUser.h"
#import "CDisplayViewController.h"

#import "CVendorModel.h"
#import "NSString+Additions.h"

@interface CVendorListTableViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic)UIRefreshControl *refreshControl;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic)NSMutableArray *filteredResult; // this holds filtered data source

@property (nonatomic,strong)NSMutableArray *receivedContacts;

@property (nonatomic)id<CServerUserInterface> serverUser;
@property (nonatomic)id<CServerInterface> server;

@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic) UISearchDisplayController *searchDisplayVC;

@end

@implementation CVendorListTableViewController
@synthesize refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverUser = [CServerUser defaultUser];
    self.server = [CServer defaultParser];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"Vendors";
    
    [self pr_viewDidLoad];
    [self fetchNearByVendors];
    [self.searchDisplayVC setSearchResultsDelegate:self];
    [self.searchDisplayVC setDelegate:self];
}

- (void)pr_viewDidLoad {
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact)];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(fetchNearByVendors) forControlEvents:UIControlEventValueChanged];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    /*the search bar widht must be > 1, the height must be at least 44
     (the real size of the search bar)*/
    
    self.searchDisplayVC = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    /*contents controller is the UITableViewController, this let you to reuse
     the same TableViewController Delegate method used for the main table.*/
    
    self.searchDisplayVC.delegate = self;
    self.searchDisplayVC.searchResultsDataSource = self;
    //set the delegate = self. Previously declared in ViewController.h
    
    self.tableView.tableHeaderView = self.searchBar; //this line add the searchBar
    //on the top of tableView.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   // [self fetchNearByVendors];
}

- (void)pr_pullDownToRefreshSelector {
    [self fetchNearByVendors];
}

- (void)fetchNearByVendors {
    if([self.serverUser hasCurrentUser]) {
        // pass the user current location
        NSDictionary *currentUserLocation = @{kServerLatitude:@(17.4505),kServerLongtitude:@(78.38568)};
        [self.serverUser fetchNearByVendors:currentUserLocation :^(NSArray *vendors, NSError *error) {
            [self.refreshControl endRefreshing];
            self.dataSource =nil;
            self.dataSource = vendors;
            [self.tableView reloadData];
        }];
    }
    else {
        [self.refreshControl endRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == [[self searchDisplayController] searchResultsTableView])
    {
        return [self.filteredResult count];
    }
    else
    {
        return [self.dataSource count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    CVendorModel *vendor;
    if(tableView == [[self searchDisplayController] searchResultsTableView]) {
        vendor = [self.filteredResult objectAtIndex:indexPath.row];
    }
    else {
        vendor = [self.dataSource objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = vendor.username;
    cell.detailTextLabel.text = vendor.distance;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CVendorModel *vendor;
    CDisplayViewController *displayVC = [CDisplayViewController new];
    if(tableView == [[self searchDisplayController] searchResultsTableView]) {
        vendor = [self.filteredResult objectAtIndex:indexPath.row];
        [displayVC setItsFromFiltered:YES];
    }
    else {
        vendor = [self.dataSource objectAtIndex:indexPath.row];
    }
    [displayVC setVendorModel:[self.dataSource objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:displayVC animated:YES];
}

-(void) filterForSearchText:(NSString *) text scope:(NSString *) scope
{
    NSMutableArray *filteredArray = [NSMutableArray new];
    for(CVendorModel *vendor in self.dataSource) {
        NSArray *items = vendor.products;
        for(NSDictionary *dict in items) {
            NSString *productName = dict[@"name"];
//            NSString *avail = dict[@"availablity"];
//            && ([avail isEqualToString:@"YES"]
            if([productName containsString:[text lowercaseString]]) {
                [filteredArray addObject:vendor];
            }
        }
    }
    
    
//    NSArray *items = self.dataSource
    [self.filteredResult removeAllObjects]; // clearing filter array
//    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",text]; // Creating filter condition
//    self.filteredResult = [NSMutableArray arrayWithArray:[self.dataSource filteredArrayUsingPredicate:filterPredicate]]; // filtering result
    self.filteredResult = [NSMutableArray arrayWithArray:filteredArray];
    
}

-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterForSearchText:searchString scope:[[[[self searchDisplayController] searchBar] scopeButtonTitles] objectAtIndex:[[[self searchDisplayController] searchBar] selectedScopeButtonIndex] ]];
    
    return YES;
}

-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}

@end
