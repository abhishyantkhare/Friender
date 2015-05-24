//
//  CollectionViewController.m
//  Friender
//
//  Created by Adrian McClure on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"

@interface CollectionViewController (){
 NSArray *eventPhotos;
}


@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";



- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize recipe image array
    eventPhotos = [NSArray arrayWithObjects:@"event.png",@"event.png",@"event.png",@"event.png",@"event.png",@"event.png",@"event.png",@"event.png",
                   nil];
}
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
  //  [self.collectionView registerClass:[UICollectionViewCell class] //forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.


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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    //return 50;
     return [eventPhotos count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImage *cellBackground = [UIImage imageNamed:[eventPhotos objectAtIndex:indexPath.row]];
    UIImage *textShadowImage = [UIImage imageNamed:@"shadow.png"];
    
    UIGraphicsBeginImageContext(cellBackground.size);
    [cellBackground drawInRect:CGRectMake(0, 0, cellBackground.size.width, cellBackground.size.height)];
    [textShadowImage drawInRect:CGRectMake(cellBackground.size.width - textShadowImage.size.width,cellBackground.size.height - textShadowImage.size.height, textShadowImage.size.width, textShadowImage.size.height)];
    cell.backgroundImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.nameLabel.text = @" Dick Meeting";
    cell.descriptionLabel.text = @" Come take a shit with the best of the rest of the best!";
    
    return cell;
}


//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   // CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
 //   // Configure the cell
 //   cell.textLabel.text = [NSString stringWithFormat:@"%li", (long)indexPath.row + 1];
   // return cell;
//}



#pragma mark <UICollectionViewDelegate>
//Tapped cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tapped %ld cell! It had %@ image!", (long)indexPath.row, [eventPhotos objectAtIndex:indexPath.row]);
    [self performSegueWithIdentifier:@"expandEvent" sender:self];
}
//Deselected cell (lifted finger)
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}
//Unhiglted item (released)
-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
//Highlighted items (touched)
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
