//
//  FriendViewController.m
//  Friender
//
//  Created by Abhishyant Khare on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "FriendViewController.h"
#import "ProfileViewController.h"


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
    left = CGPointMake(-200,viewFrame.size.height/2);
    center = CGPointMake(viewFrame.size.width/2, viewFrame.size.height/2);
    right = CGPointMake(viewFrame.size.width+200, viewFrame.size.height/2);
    
    
    self.peopleArray = [[NSMutableArray alloc] init];
    [self initPeopleArray];
    _position = 1;
    self.view.backgroundColor = [UIColor colorWithRed:.183f green:.183f blue:.183f alpha:.9f];
    
    int pos = (int)self.position;
    UILabel* addLabel = [self.peopleArray objectAtIndex:pos+1];
    CGRect placeFrame = CGRectMake(right.x, self.view.frame.size.height/2.0f, addLabel.frame.size.width, addLabel.frame.size.height);
    [addLabel setFrame:placeFrame];
    addLabel.center = center;
    [self.view addSubview:addLabel];
    UILabel* centerLabel = [self.peopleArray objectAtIndex:pos];
    CGRect centerFrame = CGRectMake(center.x-25, self.view.frame.size.height/2.0f, centerLabel.frame.size.width, centerLabel.frame.size.height);
    [centerLabel setFrame:centerFrame];
    centerLabel.center = right;
    [self.view addSubview:centerLabel];
    UILabel* leftLabel = [self.peopleArray objectAtIndex:pos-1];
    CGRect leftFrame = CGRectMake(left.x, self.view.frame.size.height/2.0f, leftLabel.frame.size.width, leftLabel.frame.size.height);
    [leftLabel setFrame:leftFrame];
    leftLabel.center = left;
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
    if(endPoint.x<beginPoint.x-10)
        [self updatePersonLeft];
    else if (endPoint.x>beginPoint.x+10)
        [self updatePersonRight];
}
-(void) updatePersonLeft{
    if((int)self.position<self.peopleArray.count-1){
        int pos = (int)self.position;
        UILabel* centerLabel = [self.peopleArray objectAtIndex:pos];
        CGRect leftFrame = CGRectMake(left.x, left.y, centerLabel.frame.size.width, centerLabel.frame.size.height);
        [UIView animateWithDuration:.5 animations:^{centerLabel.center = left;}];
        UILabel* rightLabel = [self.peopleArray objectAtIndex:pos+1];
        CGRect centerFrame = CGRectMake(center.x-25, center.y, rightLabel.frame.size.width, rightLabel.frame.size.height);
        [UIView animateWithDuration:.5 animations:^{rightLabel.center=center;}];
        if(!(int)self.position==0){
            UILabel* leftLabel = [self.peopleArray objectAtIndex:pos-1];
            [leftLabel removeFromSuperview];}
        if(pos <self.peopleArray.count-2){
            UILabel* addLabel = [self.peopleArray objectAtIndex:pos+2];
            CGRect placeFrame = CGRectMake(right.x, self.view.frame.size.height/2.0f, addLabel.frame.size.width, addLabel.frame.size.height);
            
            [addLabel setFrame:placeFrame];
            addLabel.center = right;
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
        [UIView animateWithDuration:.5 animations:^{centerLabel.center = right;}];
        if(pos!=self.peopleArray.count-1){
            UILabel* rightLabel = [self.peopleArray objectAtIndex:pos+1];
            [rightLabel removeFromSuperview];
        }
        UILabel* leftLabel = [self.peopleArray objectAtIndex:pos-1];
        CGRect centerFrame = CGRectMake(center.x-25, center.y, leftLabel.frame.size.width, leftLabel.frame.size.height);
        [UIView animateWithDuration:.5 animations:^{leftLabel.center=center;}];
        
        if((int)self.position>1){
            UILabel* addLabel = [self.peopleArray objectAtIndex:pos-2];
            CGRect placeFrame = CGRectMake(left.x, self.view.frame.size.height/2.0f, addLabel.frame.size.width, addLabel.frame.size.height);
            [addLabel setFrame:placeFrame];
            addLabel.center = left;
            [self.view addSubview:addLabel];
            
            
        }
        pos--;
        
        self.position = (NSInteger) pos;
        NSLog(@"%d",(int) self.position);
        
        
    }
    
}

-(void) initPeopleArray{
    
    
    for(int i = 0; i < 5; i++){
        
        CGRect cardFrame = CGRectMake(90.0f, 150.0f, 300.0f, 466.0f);
        UIView *card = [[UIView alloc] initWithFrame:cardFrame];
        card.backgroundColor = [UIColor colorWithRed:.7255f green:.7255f blue:.7255f alpha:1.0f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(cardTapped:)];
        tap.numberOfTapsRequired = 1;
        [card addGestureRecognizer:tap];
        card.layer.borderColor = [UIColor grayColor].CGColor;
        card.layer.borderWidth = 2.0f;
        UIImageView *cardPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainPic.jpg"]];
        [card addSubview:cardPic];
        CGRect cardPicFrame = CGRectMake(0, 0, cardPic.superview.frame.size.width, .45f*cardPic.superview.frame.size.height);
        float cardWidth =  cardPic.superview.frame.size.width;
        float cardHeight = cardPic.superview.frame.size.height;
        [cardPic setFrame:cardPicFrame];
        UILabel* info = [[UILabel alloc] init];
        [card addSubview:info];
        info.font = [UIFont systemFontOfSize:24];
        info.textColor = [UIColor whiteColor];
        info.text = @"Abhishyant Khare, 17";
        CGRect nameFrame = CGRectMake(.03f*cardWidth, .35f*cardHeight, cardWidth, .3f*cardHeight);
        [info setFrame:nameFrame];
        UILabel* cityInfo = [[UILabel alloc] init];
        [card addSubview:cityInfo];
        cityInfo.font = [UIFont systemFontOfSize:24];
        cityInfo.textColor = [UIColor whiteColor];
        cityInfo.text = @"Dublin, CA";
        CGRect cityFrame = CGRectMake(.03*cardWidth, .40f*cardHeight, cardWidth, .3f*cardHeight);
        [cityInfo setFrame:cityFrame];
        for(int i = 0; i < 3; i++){
            UIImageView *interest = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yajun.png"]];
            CGRect interestFrame = CGRectMake(.1*cardWidth + i*95, .6*cardHeight, .17*cardWidth, .2*cardHeight);
            [interest setFrame:interestFrame];
            [card addSubview:interest];
            CGRect interestNameRect = CGRectMake(.1*cardWidth+i*95, .8*cardHeight, .2*cardWidth, .1*cardHeight);
            UILabel *interestName = [[UILabel alloc] initWithFrame:interestNameRect];
            interestName.numberOfLines = 2;
            interestName.textColor = [UIColor whiteColor];
            interestName.text = [NSString stringWithFormat:@"Interest%d",i];
            [card addSubview:interestName];
            
        }
        [self.peopleArray addObject:card];
    }
}

-(void)cardTapped:(UITapGestureRecognizer *) recognizer{
    [self performSegueWithIdentifier:@"bigProfile" sender:self.view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"bigProfile"]) {
        
        ProfileViewController *destViewController = segue.destinationViewController;
        //destViewController.profileImageView.image
        destViewController.userNameLabel.text = @"Your Friend";
        destViewController.attendedAmountLabel.text = @"16";
        destViewController.plannedAmountLabel.text = @"7";
        destViewController.friendsAmountLabel.text = @"29";
        destViewController.InterestOneLabel.text = @"Int 1";
        destViewController.InterestTwoLabel.text = @"Int 2";
        destViewController.InterestThreeLabel.text = @"Int  3";
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
