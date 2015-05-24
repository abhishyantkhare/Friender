//
//  ProfileViewController.m
//  Friender
//
//  Created by Andrew Morgan on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "ProfileViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize profileImageView, userNameLabel, attendedAmountLabel, plannedAmountLabel, friendsAmountLabel,interestOneImage,interestTwoImage,interestThreeImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    profileImageView = [self convertImageViewToCircle:profileImageView];
    interestOneImage = [self convertImageViewToCircle:interestOneImage];
    interestTwoImage = [self convertImageViewToCircle:interestTwoImage];
    interestThreeImage = [self convertImageViewToCircle:interestThreeImage];
    userNameLabel.text = @"Hulio Jaures";//[PFUser currentUser][@"name"];
    attendedAmountLabel.text = [NSString stringWithFormat:@"%d", 24];
    plannedAmountLabel.text = [NSString stringWithFormat:@"%d", 2];
    friendsAmountLabel.text = [NSString stringWithFormat:@"%d", 250];
}

-(UIImageView*)convertImageViewToCircle:(UIImageView*) imageViewToCirculize {
    imageViewToCirculize.layer.cornerRadius = imageViewToCirculize.frame.size.width / 2;
    imageViewToCirculize.layer.masksToBounds = YES;
    return imageViewToCirculize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
