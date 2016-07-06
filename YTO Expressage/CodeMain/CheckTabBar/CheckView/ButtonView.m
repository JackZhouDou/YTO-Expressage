//
//  ButtonView.m
//  YTO Expressage
//
//  Created by dlios on 15-7-15.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backButon = [UIButton buttonWithType:UIButtonTypeSystem];
        self.backButon.frame = CGRectMake(0, 0,50, 50);
        self.backButon.backgroundColor = [UIColor whiteColor];
        self.backButon.layer.cornerRadius = 13;
        [self addSubview:self.backButon];
        self.title1 = [[UILabel alloc]initWithFrame:CGRectMake(0,51, 60, 23)];
        self.title1.font = [UIFont boldSystemFontOfSize:15];
//        self.title1.textColor = [UIColor colorWithRed:90.0 / 255 green:145.0 / 255 blue:220.0 / 255 alpha:1];
        self.title1.textColor = [UIColor whiteColor];
        [self addSubview:self.title1];
        self.title1.textAlignment = NSTextAlignmentCenter;
        
        
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
