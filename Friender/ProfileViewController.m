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
    PFUser* currentUser = [PFUser currentUser];
    
    // Do any additional setup after loading the view.
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            currentUser[@"FBName"] = name;
            [currentUser saveInBackground];
            userNameLabel.text = name;
            NSString *location = userData[@"location"][@"name"];
            NSString *gender = userData[@"gender"];
            NSString *birthday = userData[@"birthday"];
            NSString *relationship = userData[@"relationship_status"];
            
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
            
            // Run network request asynchronously
            [NSURLConnection sendAsynchronousRequest:urlRequest
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:
             ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                 if (connectionError == nil && data != nil) {
                     [profileImageView setImage:[UIImage imageWithData:data]];
                     NSData *imageData = UIImagePNGRepresentation([UIImage imageWithData:data]);
                     PFFile *file = [PFFile fileWithData:imageData];
                     currentUser[@"ProfilePic"] = file;
                     [currentUser saveInBackground];
                     // Set the image in the imageView
                     // ...
                 }
             }];
            
            
            // Now add the data to the UI elements
            // ...
        }
        // handle response
    }];
    profileImageView = [self convertImageViewToCircle:profileImageView];
    interestOneImage = [self convertImageViewToCircle:interestOneImage];
    interestTwoImage = [self convertImageViewToCircle:interestTwoImage];
    interestThreeImage = [self convertImageViewToCircle:interestThreeImage];
    
    if ([attendedAmountLabel.text isEqualToString:@"##"]) {
        attendedAmountLabel.text = @"0";
    }
    if ([plannedAmountLabel.text isEqualToString:@"##"]) {
        plannedAmountLabel.text = @"0";
    }
    if ([friendsAmountLabel.text isEqualToString:@"##"]) {
        friendsAmountLabel.text = @"0";
    }
    self.navigationController.title = userNameLabel.text;
    
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
