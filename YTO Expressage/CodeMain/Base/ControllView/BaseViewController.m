//
//  BaseViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseView.h"
@interface BaseViewController ()
@property (nonatomic, strong) UIView *animation;
@property (nonatomic, strong) UIImageView *image;
//@property (nonatomic, strong) BaseView *base;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)animationAddView {
    
    self.animation = [[UIView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.animation];
    
    
    self.animation.backgroundColor = [UIColor whiteColor];
    self.animation.alpha = 0.9;
    
    
 self.image =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 3 , 70, 70)];
    self.image.center = CGPointMake(self.view.bounds.size.width / 2 , self.view.bounds.size.height / 3 + 35);
    
//    self.base = [[BaseView alloc]initWithFrame:CGRectMake(20, self.view.bounds.size.height / 2, self.view.bounds.size.width / 2 + 40, 25)];
    
//    [self.animation addSubview:self.base];
    
    self.image.layer.cornerRadius = 35;
    
    self.image.image = [UIImage imageNamed:@"zdd"];
    
    self.image.clipsToBounds = YES;
    
    [self.animation addSubview:self.image];
    
    [self imageAnimation];
 
    
    
    
    
    
}

- (void)imageAnimation {
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.image.frame = CGRectMake(self.view.bounds.size.width / 2 , self.view.bounds.size.height / 2, 70, 70);
        self.image.center = CGPointMake(self.view.bounds.size.width / 2 , self.view.bounds.size.height / 2  + 35);
//        [UIView setAnimationRepeatCount:NSIntegerMax];
        
//         self.base.bit2.backgroundColor = [UIColor brownColor];
        
        
    } completion:^(BOOL finished) {
        
        
//         self.base.bit1.backgroundColor = [UIColor brownColor];
        [self backView];
   
    
    }];
    
    
}
- (void)backView {
    
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.image.frame = CGRectMake(self.view.bounds.size.width / 2 , self.view.bounds.size.height / 3 , 70, 70);
        self.image.center = CGPointMake(self.view.bounds.size.width / 2 , self.view.bounds.size.height / 3 + 35);
//        self.base.bit.backgroundColor = [UIColor brownColor];
        
       
        
    } completion:^(BOOL finished) {
        
        
//        self.base.bit1.backgroundColor = [UIColor whiteColor];
        
//        self.base.bit2.backgroundColor = [UIColor whiteColor];
//        self.base.bit.backgroundColor = [UIColor whiteColor];
        
        
         [self imageAnimation];
        
    }];
    
    
    
}


- (void)removeLoadView {
    
    [self.animation removeFromSuperview];
    
    
    
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
