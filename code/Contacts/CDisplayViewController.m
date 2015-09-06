//
//  CDisplayViewController.m
//  Contacts
//
//  Created by ranjit on 27/08/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CDisplayViewController.h"
#import "CEditViewController.h"
//#import "CActivityViewController.h"
#import "CServerInterface.h"
#import "CServer.h"

#import "CProductTableViewCell.h"


@interface CDisplayViewController ()

@property (nonatomic)NSArray *dataSource;

@property (nonatomic) UITableView *tableView;

@property (nonatomic) UILabel *nameLabel;
//@property (nonatomic) UILabel *emailLabel;
@property (nonatomic) UILabel *mobileLabel;
//@property (nonatomic) UILabel *streetLabel;
//@property (nonatomic) UILabel *districtLabel;
//@property (nonatomic) UIButton *shareBtn;
@property (nonatomic) UILabel *searchedItem;

@property (nonatomic)UINavigationController *navigation;

@property (nonatomic)id<CServerInterface>server;

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *containerView;

@end

@interface CDisplayViewController()<pop,UITableViewDataSource,UITableViewDelegate>

@end

@implementation CDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.server = [CServer defaultParser];
    self.title = @"Profile";
    [self.view removeConstraints:self.view.constraints];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.dataSource = self.vendorModel.products;

    [self addConstraints];
}

#pragma mark - Private methods

- (void)edit {
    CEditViewController *editVC = [CEditViewController new];
//    [editVC setContact:self.contact];
    editVC.delegate = self;
    self.navigation = [[UINavigationController alloc]initWithRootViewController:editVC];
    editVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    [self presentViewController:self.navigation animated:NO completion:nil];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:self.navigation completion:nil];
}

- (void)addConstraints {

    self.scrollView = [UIScrollView new];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:self.scrollView];

    self.containerView = [UIView new];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView addSubview:self.containerView];

    self.nameLabel = [UILabel new];
    self.nameLabel.text = self.vendorModel.username;
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.nameLabel.layer.borderColor = [UIColor brownColor].CGColor;
    self.nameLabel.layer.borderWidth = 4.0;
    [self.nameLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.nameLabel];
    
    

//    self.emailLabel = [UILabel new];
//    self.emailLabel.text = self.contact.email;
//    [self.emailLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    self.emailLabel.layer.borderColor = [UIColor brownColor].CGColor;
//    self.emailLabel.layer.borderWidth = 4.0;
//    [self.emailLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
//    self.emailLabel.textAlignment = NSTextAlignmentCenter;
//    [self.containerView addSubview:self.emailLabel];

    self.mobileLabel = [UILabel new];
    self.mobileLabel.text = self.vendorModel.phone;
    [self.mobileLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.mobileLabel.layer.borderColor = [UIColor brownColor].CGColor;
    self.mobileLabel.layer.borderWidth = 4.0;
    [self.mobileLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.mobileLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.mobileLabel];

//    self.streetLabel = [UILabel new];
//    self.streetLabel.text = self.contact.street;
//    [self.streetLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    self.streetLabel.layer.borderColor = [UIColor brownColor].CGColor;
//    self.streetLabel.layer.borderWidth = 4.0;
//    [self.streetLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
//    self.streetLabel.textAlignment = NSTextAlignmentCenter;
//    [self.containerView addSubview:self.streetLabel];

//    self.districtLabel = [UILabel new];
//    self.districtLabel.text = self.contact.district;
//    [self.districtLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    self.districtLabel.layer.borderColor = [UIColor brownColor].CGColor;
//    self.districtLabel.layer.borderWidth = 4.0;
//    [self.districtLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
//    self.districtLabel.textAlignment = NSTextAlignmentCenter;
//    [self.containerView addSubview:self.districtLabel];

//    self.shareBtn = [UIButton new];
//    [self.shareBtn setTitle:@"share" forState:UIControlStateNormal];
//    [self.shareBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.shareBtn setBackgroundColor:[UIColor brownColor]];
//    [self.shareBtn.layer setCornerRadius:6];
//    [self.shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    [self.containerView addSubview:self.shareBtn];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setScrollEnabled:NO];
    [self.containerView addSubview:self.tableView];
    
    


    NSDictionary *views = NSDictionaryOfVariableBindings(_scrollView,
                                                         _containerView,
                                                         _nameLabel,
                                                         _mobileLabel,
                                                         _tableView
                                                         );

    NSArray *constraints = [NSArray array];


    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_scrollView]-0-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollView]-0-|" options:0 metrics:nil views:views]];

    NSString *verticalConsForContainerView = [NSString stringWithFormat:@"V:|-0-[_containerView(%f)]-|",self.view.bounds.size.height];
    NSString *horizontalConsForContainerView = [NSString stringWithFormat:@"H:|-0-[_containerView(%f)]-|",self.view.bounds.size.width];

    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConsForContainerView options:0 metrics:nil views:views]];
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalConsForContainerView options:0 metrics:nil views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_nameLabel(50)]-40-[_mobileLabel(50)]-[_tableView]-|" options:0 metrics:nil views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_nameLabel]-|" options:0 metrics:nil views:views]];

    //[self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailLabel]-|" options:0 metrics:nil views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_mobileLabel]-|" options:0 metrics:nil views:views]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tableView]-|" options:0 metrics:nil views:views]];

    //[self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_streetLabel]-|" options:0 metrics:nil views:views]];

   // [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_districtLabel]-|" options:0 metrics:nil views:views]];

    //[self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_shareBtn]-|" options:0 metrics:nil views:views]];

    [self.view addConstraints:constraints];
}

- (void)popout {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)share {
//    [self.server saveShareContactArray:@[self.contact.rollNumber] :^(BOOL result, NSError *error) {
//        [self.server findSharedContactObjectId:self.contact.rollNumber :^(NSString *objectId, NSError *error) {
//            [self passToActivityViewController:objectId];
//        }];
//    }];
}

- (void)passToActivityViewController:(NSString *)shareRowObjectId {
    NSString *finalString = [@"Contacts:" stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"//multipleContacts/",shareRowObjectId]];
    NSURL *customURL = [[NSURL alloc] initWithString:finalString];
//    CActivityViewController *activityVC = [[CActivityViewController alloc] initWithURL:customURL];
//    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[activityVC] applicationActivities:nil];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //iPhone, present activity view controller as is
//        [self presentViewController:activityViewController animated:YES completion:nil];
    }
}

// @override this method for hiding Tabbar when this viewcontroller
-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Products";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    CProductTableViewCell *productTableViewCell =(CProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (productTableViewCell == nil) {
        productTableViewCell = [[CProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *productDict = [self.dataSource objectAtIndex:indexPath.row];
    productTableViewCell.name.text = productDict[@"name"];
    productTableViewCell.price.text = [NSString stringWithFormat:@"%@.00 Rupees",productDict[@"price"]];
    if([productDict[@"availablity"] isEqualToString:@"YES"]) {
        productTableViewCell.availablity.text = @" Yeah, Its Available";
        productTableViewCell.availablity.layer.borderColor = [UIColor greenColor].CGColor;
        productTableViewCell.availablity.layer.borderWidth = 3.0;
    }
    else {
        productTableViewCell.availablity.text = @" Un Available";
        productTableViewCell.availablity.layer.borderColor = [UIColor redColor].CGColor;
        productTableViewCell.availablity.layer.borderWidth = 3.0;
    }
    return productTableViewCell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *productDict = [self.dataSource objectAtIndex:indexPath.row];
//    if([productDict[@"availablity"] isEqualToString:@"YES"]) {
//        cell.backgroundColor = [UIColor blueColor];
//    } else {
//        cell.backgroundColor = [UIColor whiteColor];
//    }
//}


@end
