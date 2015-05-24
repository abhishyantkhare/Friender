//
//  CreateEventViewController.m
//  Friender
//
//  Created by Adrian McClure on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "CreateEventViewController.h"
#import <Parse/Parse.h>
#import <CommonCrypto/CommonDigest.h>

@interface CreateEventViewController () {
    NSDate *myDate;
    UIImage *chosenImage;
}

@end

@implementation CreateEventViewController
@synthesize dateLabel,nameLabel,locationLabel,uploadedImageView;

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
    event[@"image"] = [self convertForUploadWithImage:chosenImage];
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

-(PFFile*)convertForUploadWithImage:(UIImage*)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    NSString *filename = [self convertIntoMD5:[NSString stringWithFormat:@"%@.jpg",nameLabel.text]];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    return imageFile;
}

- (NSString *)convertIntoMD5:(NSString *) string{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    return  resultString;
}

#pragma mark Photo Picker Delegate Methods

- (void)takePhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    chosenImage = info[UIImagePickerControllerEditedImage];
    uploadedImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark Alert View Delegate Methods

- (IBAction)choosePhotoPressed:(id)sender {
    
    
    [self showMultiChoiceAlert:@"Please choose a photo picking method." title:@"Upload Photo"];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        if (buttonIndex == 0) {
            // Select Photo
            [self selectPhoto];
        } else {
            // Take Photo
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:@"Device has no camera"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles: nil];
                
                [myAlertView show];
                
            } else {
                [self takePhoto];
            }
            
        }
    }
}

- (void)showMultiChoiceAlert:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"Choose Photo",@"Take Photo",nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

- (void)showAlert:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}
@end
