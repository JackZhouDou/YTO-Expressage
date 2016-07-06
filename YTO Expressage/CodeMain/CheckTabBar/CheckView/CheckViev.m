//
//  CheckViev.m
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "CheckViev.h"

@implementation CheckViev

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
        self.backView.layer.cornerRadius = frame.size.height / 2;
        self.backView.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.backView];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width * 0.7, frame.size.height * 0.7)];
        view.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        
        [self.backView addSubview:view];
        
        [UIView transitionWithView:view duration:0.8 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            view.frame = CGRectMake(0, 0, frame.size.height * 0.4, frame.size.height * 0.4);
            view.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
            
            
            
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                
             
                
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width * 0.7, frame.size.height * 0.7)];
                view.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
                
                
            }
            
            
            
            
        }];
        
        
        
        
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
