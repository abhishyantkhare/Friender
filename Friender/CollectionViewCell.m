//
//  CollectionViewCell.m
//  Friender
//
//  Created by Adrian McClure on 5/23/15.
//  Copyright (c) 2015 CoDevelopers LLC. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(void)awakeFromNib{
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView= bgView;
    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"event copy"] ];
 
}


@end
