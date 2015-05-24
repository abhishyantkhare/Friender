//
//  FriendViewController.m
//  Friender
//
//  Created by Abhishyant Khare on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "FriendViewController.h"


@interface FriendViewController () {
    CGPoint left;
    CGPoint center;
    CGPoint right;
    CGPoint beginPoint;
    CGPoint endPoint;
}




@end



@implementation FriendViewController


@synthesize imageView = _imageView;
@synthesize peopleArray = _peopleArray;
@synthesize position = _position;



- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect viewFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    left = CGPointMake(-100,viewFrame.size.height/2);
    center = CGPointMake(viewFrame.size.width/2, viewFrame.size.height/2);
    right = CGPointMake(viewFrame.size.width+100, viewFrame.size.height/2);
    
    self.peopleArray = [[NSMutableArray alloc] init];
    [self initPeopleArray];
    _position = 1;
    

    int pos = (int)self.position;
    UILabel* addLabel = [self.peopleArray objectAtIndex:pos+1];
    CGRect placeFrame = CGRectMake(right.x, self.view.frame.size.height/2.0f, addLabel.frame.size.width, addLabel.frame.size.height);
    [addLabel setFrame:placeFrame];
    [self.view addSubview:addLabel];
    UILabel* centerLabel = [self.peopleArray objectAtIndex:pos];
    CGRect centerFrame = CGRectMake(center.x-25, self.view.frame.size.height/2.0f, centerLabel.frame.size.width, centerLabel.frame.size.height);
    [centerLabel setFrame:centerFrame];
    [self.view addSubview:centerLabel];
    UILabel* leftLabel = [self.peopleArray objectAtIndex:pos-1];
    CGRect leftFrame = CGRectMake(left.x, self.view.frame.size.height/2.0f, leftLabel.frame.size.width, leftLabel.frame.size.height);
    [leftLabel setFrame:leftFrame];
    [self.view addSubview:leftLabel];
    
    
    
    
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void) addCard:(UILabel*) label atPosition:(int) pos{
    CGRect placeFrame = CGRectMake(((pos+1)*self.view.frame.size.width/2.0f)-(label.frame.size.width/2.0f), self.view.frame.size.height/2.0f, label.frame.size.width, label.frame.size.height);
    [label setFrame:placeFrame];
    [self.view addSubview:label];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    beginPoint = [touch locationInView:self.view];
    
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    endPoint = [touch locationInView:self.view];
    if(endPoint.x<beginPoint.x)
        [self updatePersonLeft];
    else if (endPoint.x>beginPoint.x)
        [self updatePersonRight];
}
-(void) updatePersonLeft{
    if((int)self.position<self.peopleArray.count-1){
        int pos = (int)self.position;
        UILabel* centerLabel = [self.peopleArray objectAtIndex:pos];
        CGRect leftFrame = CGRectMake(left.x, left.y, centerLabel.frame.size.width, centerLabel.frame.size.height);
        [UIView animateWithDuration:.5 animations:^{centerLabel.frame = leftFrame;}];
       UILabel* rightLabel = [self.peopleArray objectAtIndex:pos+1];
        CGRect centerFrame = CGRectMake(center.x-25, center.y, rightLabel.frame.size.width, rightLabel.frame.size.height);
        [UIView animateWithDuration:.5 animations:^{rightLabel.frame=centerFrame;}];
        if(!(int)self.position==0){
        UILabel* leftLabel = [self.peopleArray objectAtIndex:pos-1];
            [leftLabel removeFromSuperview];}
        if(pos <self.peopleArray.count-2){
        UILabel* addLabel = [self.peopleArray objectAtIndex:pos+2];
        CGRect placeFrame = CGRectMake(right.x, self.view.frame.size.height/2.0f, addLabel.frame.size.width, addLabel.frame.size.height);
        [addLabel setFrame:placeFrame];
        [self.view addSubview:addLabel];
            
        }
        
        pos++;
        self.position = (NSInteger) pos;
        NSLog(@"%d",(int) self.position);
    }
}
-(void) updatePersonRight{
    if((int)self.position>0){
        int pos = (int)self.position;
        UILabel* centerLabel = [self.peopleArray objectAtIndex:pos];
        CGRect rightFrame = CGRectMake(right.x, right.y, centerLabel.frame.size.width, centerLabel.frame.size.height);
        [UIView animateWithDuration:.5 animations:^{centerLabel.frame = rightFrame;}];
        if(pos!=self.peopleArray.count-1){
        UILabel* rightLabel = [self.peopleArray objectAtIndex:pos+1];
        [rightLabel removeFromSuperview];
        }
        UILabel* leftLabel = [self.peopleArray objectAtIndex:pos-1];
        CGRect centerFrame = CGRectMake(center.x-25, center.y, leftLabel.frame.size.width, leftLabel.frame.size.height);
        [UIView animateWithDuration:.5 animations:^{leftLabel.frame=centerFrame;}];
        
        if((int)self.position>1){
            UILabel* addLabel = [self.peopleArray objectAtIndex:pos-2];
        CGRect placeFrame = CGRectMake(left.x, self.view.frame.size.height/2.0f, addLabel.frame.size.width, addLabel.frame.size.height);
        [addLabel setFrame:placeFrame];
        [self.view addSubview:addLabel];
            
           
        }
        pos--;
        
        self.position = (NSInteger) pos;
        NSLog(@"%d",(int) self.position);
      
        
    }
    
}

-(void) initPeopleArray{
    for(int i = 0; i < 5; i++){
        CGRect labelFrame = CGRectMake(0.0f,0.0f, 100.0f, 50.0f);
        NSString *content = [NSString stringWithFormat:@"String %d",i];
        UILabel* label = [[UILabel alloc] initWithFrame:labelFrame];
        label.text = content;
        [self.peopleArray addObject:label];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
