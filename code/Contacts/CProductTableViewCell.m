//
//  CProductTableViewCell.m
//  Contacts
//
//  Created by Abid MAC-Mini on 06/09/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CProductTableViewCell.h"

@implementation CProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
//[{"availablity":"YES","name":"Horlics","price":"100"},{"availablity":"YES","name":"Rexona","price":"40"}]


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
//        self.name = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
        self.name = [UILabel new];
        self.name.textColor = [UIColor blackColor];
//        [self.name setBackgroundColor:[UIColor blueColor]];
        self.name.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        [self.name setTranslatesAutoresizingMaskIntoConstraints:NO];
//        self.name.layer.borderColor = [UIColor greenColor].CGColor;
//        self.name.layer.borderWidth = 3.0;
        [self addSubview:self.name];
        
        self.price = [UILabel new];
        self.price.textColor = [UIColor blackColor];
        self.price.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        [self.price setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:self.price];
        
        self.availablity = [UILabel new];
        self.availablity.textColor = [UIColor blackColor];
        self.availablity.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        [self.availablity setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:self.availablity];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_name,_price,_availablity);
        
        NSArray *constraints = [NSArray array];
        
        constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_name(50)]-[_price(50)]-[_availablity(50)]" options:0 metrics:nil views:views]];
        constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_name]-|" options:0 metrics:nil views:views]];
        constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_price]-|" options:0 metrics:nil views:views]];
        constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_availablity]-|" options:0 metrics:nil views:views]];
        
        [self addConstraints:constraints];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
