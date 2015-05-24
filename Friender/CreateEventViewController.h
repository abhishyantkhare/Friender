//
//  CreateEventViewController.h
//  Friender
//
//  Created by Adrian McClure on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventViewController : UIViewController
@property IBOutlet UIDatePicker* datePicker;
- (IBAction)datePickerPicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *dateLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameLabel;
@property (strong, nonatomic) IBOutlet UITextField *locationLabel;
- (IBAction)createEventPressed:(id)sender;

@end