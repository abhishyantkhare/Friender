//
//  FBLoginViewController.m
//  Friender
//
//  Created by Andrew Morgan on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "FBLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface FBLoginViewController ()

@end

@implementation FBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Check if user is logged in
    
    if ([PFUser currentUser]) {
        [self segueToMainContent];
    } else {
        self.navigationController.navigationBar.hidden = YES;
    }
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

-(void)segueToMainContent {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}

- (IBAction)loginWithFacebookButton:(id)sender {
    
    NSArray *publishPermissions = @[];
    NSArray *readPermissions = @[@"public_profile"];
    
    [PFFacebookUtils logInInBackgroundWithPublishPermissions:publishPermissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
            [self showAlert:@"You cancelled the Facebook login!" title:@"Oh noes!"];
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            [self segueToMainContent];
        } else {
            NSLog(@"User logged in through Facebook!");
            [self segueToMainContent];
        }
    }];
    
    [PFFacebookUtils linkUserInBackground:[PFUser currentUser] withReadPermissions:readPermissions block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"User now has read and publish permissions!");
            [self segueToMainContent];
        }
    }];
}

- (void)showAlert:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}
@end
