//
//  FBLoginViewController.m
//  Friender
//
//  Created by Andrew Morgan on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "FBLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FBLoginViewController ()

@end

@implementation FBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Set up Facebook login button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    loginButton.frame = CGRectOffset(loginButton.frame, 0, 50);
    [self.view addSubview:loginButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
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

@end
