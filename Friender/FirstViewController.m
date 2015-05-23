//
//  FirstViewController.m
//  Friender
//
//  Created by Andrew Morgan on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "FirstViewController.h"
#import <Parse/Parse.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
