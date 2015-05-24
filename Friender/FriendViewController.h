//
//  FriendViewController.h
//  Friender
//
//  Created by Abhishyant Khare on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendProfileController.h"


@interface FriendViewController : UIViewController

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) NSMutableArray *peopleArray;
@property(nonatomic) NSInteger position;


@end
