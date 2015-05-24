//
//  ProfileViewController.h
//  Friender
//
//  Created by Andrew Morgan on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *attendedAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *plannedAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *friendsAmountLabel;

@property (strong, nonatomic) IBOutlet UIImageView *interestOneImage;
@property (strong, nonatomic) IBOutlet UIImageView *interestTwoImage;
@property (strong, nonatomic) IBOutlet UIImageView *interestThreeImage;
@property (strong, nonatomic) IBOutlet UILabel *InterestOneLabel;
@property (strong, nonatomic) IBOutlet UILabel *InterestTwoLabel;
@property (strong, nonatomic) IBOutlet UILabel *InterestThreeLabel;

@end
