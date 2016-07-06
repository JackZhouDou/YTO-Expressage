//
//  UserView.m
//  YTO Expressage
//
//  Created by dlios on 15-7-16.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "UserView.h"

@implementation UserView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.back];
        //        self.back.backgroundColor = [UIColor whiteColor];
        //        CGFloat w = frame.size.width / 10;
        //
        //        CGFloat h = frame.size.height / 10;
        //
        NSLog(@"%f", frame.origin.y);
        
        self.myTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, frame.size.width * 0.6, frame.size.height)];
        //        self.myTitle.backgroundColor = [UIColor redColor];
        
        self.myTitle.font = [UIFont boldSystemFontOfSize:17];
        //        self.myTitle.center = CGPointMake(5 + 2.75 * w, h / 2);
        [self.back addSubview:self.myTitle];
        
        
        self.button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        
        
        self.button1.frame = CGRectMake(frame.size.width * 0.7,0,frame.size.width * 0.2, frame.size.width * 0.1);
        self.button1.center = CGPointMake(0.85 * frame.size.width , frame.size.height * 0.5);
        [self.back addSubview:self.button1];
        //        self.button1.layer.cornerRadius = 3;
        //        self.button1.backgroundColor = [UIColor colorWithRed:45.0 / 255 green:86.0 / 255 blue:240.0 / 255 alpha:1];
        
        
        
        
        
        
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
