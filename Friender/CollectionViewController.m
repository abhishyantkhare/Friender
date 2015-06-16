//
//  CollectionViewController.m
//  Friender
//
//  Created by Adrian McClure on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import <Parse/Parse.h>

@interface CollectionViewController (){
    NSMutableArray *eventArray;
    NSMutableArray *imageArray;
}


@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadButtonPressed:nil];
    eventArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc] init];
}

- (IBAction)reloadButtonPressed:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query setLimit:100];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %ld events.", objects.count);
            // Do something with the found objects
            for (PFObject* eventObject in objects) {
                [eventArray addObject:eventObject];
            }
            [self.collectionView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Got count of %lu", [eventArray count]);
    return [eventArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Adding a cell");
    static NSString *identifier = @"Cell";
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // Set bg image
    PFFile *imageFile = [eventArray objectAtIndex:indexPath.row][@"image"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.backgroundImageView.image = [UIImage imageWithData:imageData];  // Here is your image. Put it in a UIImageView or whatever
        }
    }];
    /*
    UIImage *backgroundImage = cell.backgroundImageView.image;
    UIImage *watermarkImage = [UIImage imageNamed:@"text_shadow.png"];
    
    UIGraphicsBeginImageContext(backgroundImage.size);
    [backgroundImage drawInRect:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)];
    [watermarkImage drawInRect:CGRectMake(backgroundImage.size.width - watermarkImage.size.width, backgroundImage.size.height - watermarkImage.size.height, watermarkImage.size.width, watermarkImage.size.height)];
    cell.backgroundImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    */
    
    cell.eventName.layer.shadowOpacity = 1.0;
    cell.eventName.layer.shadowRadius = 0.0;
    cell.eventName.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.eventName.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    
    cell.eventLocation.layer.shadowOpacity = 1.0;
    cell.eventLocation.layer.shadowRadius = 0.0;
    cell.eventLocation.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.eventLocation.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    
    // Set name
    cell.eventName.text = [eventArray objectAtIndex:indexPath.row][@"name"];
    cell.eventLocation.text = [eventArray objectAtIndex:indexPath.row][@"location"];
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>
//Tapped cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tapped %ld cell! It had %@ image!", (long)indexPath.row, [eventArray objectAtIndex:indexPath.row]);
    [self performSegueWithIdentifier:@"expandEvent" sender:self];
}

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */
@end
