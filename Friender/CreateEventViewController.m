//
//  CreateEventViewController.m
//  Friender
//
//  Created by Adrian McClure on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "CreateEventViewController.h"
#import <Parse/Parse.h>

@interface CreateEventViewController () {
    NSDate *myDate;
}

@end

@implementation CreateEventViewController
@synthesize dateLabel,nameLabel,locationLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myDate = [NSDate date];
    dateLabel.text = [self convertWithDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (IBAction)datePickerPicked:(id)sender {
    myDate = self.datePicker.date;
    dateLabel.text = [self convertWithDate:myDate];
}

-(NSString*)convertWithDate:(NSDate*)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}
- (IBAction)createEventPressed:(id)sender {
    PFObject *event = [PFObject objectWithClassName:@"Event"];
    event[@"date"] = myDate;
    event[@"name"] = nameLabel.text;
    event[@"location"] = locationLabel.text;
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            [self showAlert:@"Event saved successfully!" title:@"Success!"];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            // There was a problem, check error.description
            [self showAlert:@"Error saving event!" title:@"Oh noes!"];
        }
    }];
}

- (void)showAlert:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}
@end