//
//  YSerViceViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//
//#import "NetworkHandler.h"
#import "YSerViceViewController.h"
#import "WebViewAddViewController.h"
#define Screen_Width self.view.bounds.size.width / 10
#define Screen_Height self.view.bounds.size.height / 10
@interface YSerViceViewController ()
@property (nonatomic, strong) UIButton *serVice;
@property (nonatomic, strong) UIButton *search;
@property (nonatomic, strong) UIButton *shope;
@property (nonatomic, strong) UIButton *cunston;
@property (nonatomic, strong) UIButton *pack;
@property (nonatomic, assign) BOOL key;
@property (nonatomic, strong) UIImageView *backe;
@property (nonatomic, copy) void(^block)(NSString *user);

@end

@implementation YSerViceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(userDeluat) name:@"change" object:nil];
    
    UIBarButtonItem *baclk = [[UIBarButtonItem alloc]init];
    baclk.title = @"返回";
    self.navigationItem.backBarButtonItem = baclk;

    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width * 4, 0.6 * Screen_Height)];
    void (^block)(NSString *user) = ^(NSString *user) {
        
        if ([user isEqualToString:@"chaince"]) {
           title.text = @"圆通服务";
        } else {
            
            title.text = @"YTO Service";
            
        }
    };
    self.block = block;
    
   
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textColor = [UIColor whiteColor];
    
//    title.backgroundColor = [UIColor whiteColor];
//    title.layer.cornerRadius = 0.3 * Screen_Height;
    
    self.navigationItem.titleView = title;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
    self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];
    
    self.key = YES;
    [self stupView];
    [self userDeluat];
    
    // Do any additional setup after loading the view.
}

- (void)userDeluat {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (user) {
        self.block([user objectForKey:@"languge"]);
        
    }
    
}
/*
 **创建一个视图
 **
 */
- (void)stupView {
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"biaozhi"] forBarMetrics:UIBarMetricsDefault];
    self.backe = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.backe.clipsToBounds = YES;
    self.backe.image = [UIImage imageNamed:@"backe"];
    
    [self.view addSubview:self.backe];
    self.backe.userInteractionEnabled = YES;
    
   
    
//    查询价格
    
    self.search = [UIButton buttonWithType:UIButtonTypeSystem];
    self.search.frame = CGRectMake(0, 0, 0.3 * Screen_Width, 0.3 * Screen_Width);
    self.search.center = CGPointMake(Screen_Width * 5, Screen_Height * 5);
    self.search.backgroundColor = [UIColor whiteColor];
    self.search.layer.cornerRadius =0.15 * Screen_Width;
    self.search.hidden = YES;
    [self.search setBackgroundImage:[UIImage imageNamed:@"jisuan"] forState:UIControlStateNormal];
    [self.view addSubview:self.search];
    
    
    
    
//    客服
    self.cunston = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cunston.frame = CGRectMake(0, 0, 0.3 * Screen_Width, 0.3 * Screen_Width);
    self.cunston.center = CGPointMake(Screen_Width * 5, Screen_Height * 5);
    [self.cunston setBackgroundImage:[UIImage imageNamed:@"tousu"] forState:UIControlStateNormal];
    
    self.cunston.hidden = YES;
    self.cunston.layer.cornerRadius = 0.15 * Screen_Width;
    [self.view addSubview:self.cunston];
    [self.cunston addTarget:self action:@selector(searchAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cunston.backgroundColor = [UIColor whiteColor];
    
    
    
    
//    网购
    self.shope = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shope.frame = CGRectMake(0, 0, 0.3 * Screen_Width, 0.3 * Screen_Width);
    self.shope.backgroundColor = [UIColor whiteColor];
    self.shope.layer.cornerRadius = 0.15 * Screen_Width;
    self.shope.center = CGPointMake(Screen_Width * 5, Screen_Height * 5);
    self.shope.hidden = YES;
    [self.shope addTarget:self action:@selector(searchAdd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shope];
    [self.shope setBackgroundImage:[UIImage imageNamed:@"shouji"] forState:UIControlStateNormal];
//    包裹
    
    self.pack = [UIButton buttonWithType:UIButtonTypeSystem];
    self.pack.frame = CGRectMake(0, 0, 0.3 * Screen_Width, 0.3 * Screen_Width);
    self.pack.center = CGPointMake(Screen_Width * 5, Screen_Height * 5);
    self.pack.layer.cornerRadius = 0.15 * Screen_Width;
    self.pack.backgroundColor = [UIColor whiteColor];
    self.pack.hidden = YES;
    [self.pack addTarget:self action:@selector(searchAdd:) forControlEvents:UIControlEventTouchUpInside];
    self.pack.clipsToBounds = YES;
    [self.pack setBackgroundImage:[UIImage imageNamed:@"tishi"] forState:UIControlStateNormal];
    [self.view addSubview:self.pack];
    
    
    //    服务总按钮
    self.serVice = [UIButton buttonWithType:UIButtonTypeSystem];
    self.serVice.frame = CGRectMake(0, 0, Screen_Width * 3, Screen_Width * 3);
    self.serVice.center =  CGPointMake(Screen_Width * 5, Screen_Height * 5);
//    self.serVice.hidden = YES;
    [self.search addTarget:self action:@selector(searchAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.serVice];
    self.serVice.layer.cornerRadius = 1.5 * Screen_Width;
    [self.serVice setImage:[UIImage imageNamed:@"myzdd"] forState:UIControlStateNormal];
    self.serVice.backgroundColor = [UIColor whiteColor];
    [self.serVice addTarget:self action:@selector(serViceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}



- (void)serViceButtonAction:(UIButton *)action {
    if (self.key) {
        
        self.key = NO;
        self.cunston.hidden = NO;
        self.shope.hidden = NO;
        self.search.hidden = NO;
        self.pack.hidden = NO;
        [UIView animateKeyframesWithDuration:0.6 delay:0.1 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
            
            
            self.search.frame = CGRectMake(0, 0, 2 * Screen_Width, 2 * Screen_Width);
            self.search.center = CGPointMake(2.855 * Screen_Width, 5 * Screen_Height - 2.145 * Screen_Width);
            self.search.layer.cornerRadius = Screen_Width;
            
            self.cunston.frame = CGRectMake(0, 0, Screen_Width * 2, Screen_Width * 2);
            self.cunston.center = CGPointMake(7.145 * Screen_Width, 5 * Screen_Height - 2.145 * Screen_Width);
            self.cunston.layer.cornerRadius = Screen_Width;
            
             self.shope.frame = CGRectMake(0, 0, Screen_Width * 2, Screen_Width * 2);
            self.shope.layer.cornerRadius = Screen_Width ;
            self.shope.center = CGPointMake(2.855 * Screen_Width, Screen_Height * 5 + 2.145 * Screen_Width);
            
            self.pack.frame = CGRectMake(0, 0, Screen_Width * 2, Screen_Width * 2);
            self.pack.center = CGPointMake(Screen_Width * 7.145, Screen_Height * 5 + 2.145 * Screen_Width);
            self.pack.layer.cornerRadius = Screen_Width;
            
            
            
            
        } completion:^(BOOL finished) {
            
            
            
        }];
        
        
        
    } else {
        
        
        self.key = YES;
        
        [UIView animateKeyframesWithDuration:0.5 delay:0.1 options:  UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
            
            
            self.search.layer.cornerRadius = 0.15 * Screen_Width;
            self.search.frame = CGRectMake(0, 0, 0.3 * Screen_Width, 0.3 * Screen_Width);
           
            
            
            self.search.center = CGPointMake(Screen_Width * 5, Screen_Height * 5);
            
            
            self.cunston.layer.cornerRadius = 0.15 * Screen_Width;
            self.cunston.frame = CGRectMake(0, 0, 0.3 * Screen_Width, 0.3 * Screen_Width);
            self.cunston.center = CGPointMake(Screen_Width * 5, Screen_Height * 5);
            
            
            self.shope.layer.cornerRadius = 0.15 * Screen_Width;
            self.shope.frame = CGRectMake(0, 0, 0.3 * Screen_Width, 0.3 * Screen_Width);
                       self.shope.center = CGPointMake(Screen_Width * 5, Screen_Height * 5);
           
            
            
            
            self.pack.layer.cornerRadius = 0.15 * Screen_Width;
            self.pack.frame = CGRectMake(0, 0, 0.3 * Screen_Width, 0.3 * Screen_Width);
            self.pack.center = CGPointMake(Screen_Width * 5, Screen_Height * 5);
            
            
            
            
            
        } completion:^(BOOL finished) {
            
           self.search.hidden = YES;
            self.cunston.hidden = YES;
             self.shope.hidden = YES;
              self.pack.hidden = YES;
            
        }];
        
        
        
        
        
    }
    
    
}


- (void)searchAdd:(UIButton *)action {
    
    if (action == self.shope) {
  
        WebViewAddViewController *web = [[WebViewAddViewController alloc]init];
        web.key = @"在线下单";
        web.webURL = @"http://wap.yto.net.cn/OrderManage/OnlineOrders.htm";
        [self.navigationController pushViewController:web animated:YES];
    }
    if (action == self.cunston) {
      
        WebViewAddViewController *web = [[WebViewAddViewController alloc]init];
        web.key = @"投诉建议";
        web.webURL = @"http://wap.yto.net.cn/Complaint/ComplaintsProposals.htm";
        [self.navigationController pushViewController:web animated:YES];
    }
    
    if (action == self.pack) {
        
        WebViewAddViewController *web = [[WebViewAddViewController alloc]init];
        web.key = @"邮寄须知";
        web.webURL = @"http://www.yto.net.cn/gw/service/Illegalquery.html";
        [self.navigationController pushViewController:web animated:YES];
    }
    if (action == self.search) {
     
        WebViewAddViewController *web = [[WebViewAddViewController alloc]init];
        web.key = @"价格查询";
        web.webURL = @"http://wap.yto.net.cn/OrderManage/TransportPrice.htm";
        [self.navigationController pushViewController:web animated:YES];
    }
    
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
