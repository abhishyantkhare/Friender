//
//  FriendViewController.h
//  Friender
//
//  Created by Abhishyant Khare on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>



@interface FriendViewController : UIViewController

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) NSMutableArray *peopleArray;
@property(nonatomic) NSInteger position;
@property (nonatomic, strong) PFGeoPoint *userLocation;
@property (nonatomic, strong) UIImage* OtherPic;


@end
