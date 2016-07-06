//
//  NearbyTabelViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-7.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "NearbyTabelViewController.h"
#import "MapModel.h"
#define Screen_Width self.view.bounds.size.width / 10
#define Screen_Height self.view.bounds.size.width / 10
@interface NearbyTabelViewController ()<UIAlertViewDelegate>
@property (nonatomic, copy) void (^block)(NSString *user);

@end

@implementation NearbyTabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *baclk = [[UIBarButtonItem alloc]init];
    baclk.title = @"返回";
    self.navigationItem.backBarButtonItem = baclk;
    
//   通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(userDefault) name:@"change" object:nil];
    
    
     //self.view.backgroundColor = [UIColor colorWithRed:201.0 / 255 green:228.1 / 255 blue:214.0 / 255 alpha:YES];
    //self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:255 / 255.0 blue:240 / 255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
    self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];
    [self stupViewAll];
    // Do any additional setup after loading the view.
}
-(void)userDefault{
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    
    if (dic) {
        
        self.block([dic objectForKey:@"languge"]);
        
    }
    

    
}

- (void)stupViewAll {
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width * 10,Screen_Width * 5)];
    image.image = [UIImage imageNamed:@"zd1"];
    [self.view addSubview:image];
    
    NearbView *name = [[NearbView alloc]initWithFrame:CGRectMake(Screen_Width / 2, 5.5 * Screen_Width + 64, Screen_Width * 5, 5 * Screen_Width / 6)];
    [self.view addSubview:name];
    
    
    name.itemTitl.image = [UIImage imageNamed:@"zddd"];
    
    UILabel *nameTitle = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width, 6.32 * Screen_Width + 64, Screen_Width * 8, Screen_Width)];
    [self.view addSubview:nameTitle];
    
    
    
    NearbView *address = [[NearbView alloc]initWithFrame:CGRectMake(Screen_Width / 2, 7.5 * Screen_Width + 64, Screen_Width * 5, 0.82 * Screen_Width)];
    
    address.itemTitl.image = [UIImage imageNamed:@"address"];
   
    [self.view addSubview:address];
    
    UILabel *addressTitl = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width, 8.3 * Screen_Width + 64, Screen_Width * 8, Screen_Width * 1)];
    addressTitl.numberOfLines = 0;
    
    
    [self.view addSubview:addressTitl];
    
    NearbView *distance = [[NearbView alloc]initWithFrame:CGRectMake(0.5 * Screen_Width, 9.3 * Screen_Width + 64, 5 * Screen_Width, 0.83 * Screen_Width)];
    distance.itemTitl.image = [UIImage imageNamed:@"distance"];
    
    [self.view addSubview:distance];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button.frame = CGRectMake(Screen_Width * 3.5, Screen_Width * 13 + 64, 3 * Screen_Width, Screen_Width);
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = Screen_Width / 2;
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
    
    
    
    
    
    
    
    
    void (^block)(NSString *user) = ^(NSString *user) {
        if ([user isEqualToString:@"chaince"]) {
            
          name.titleLabel.text = @"店名";
             address.titleLabel.text = @"收货地址";
            [button setTitle:@"电话预约" forState:UIControlStateNormal];
            if ([_key isEqualToString:@"a"]) {
                nameTitle.text = self.model.name;
                [self navigationString:self.model.name];
                addressTitl.text =[NSString stringWithFormat:@"%@ ,%@",self.model.district, self.model.address];
                
                distance.titleLabel.text = [NSString stringWithFormat:@"距离我:%ldm", self.model.distance];
                
            }else {
                
                nameTitle.text = self.poi.name;
                //        标题
                [self navigationString:self.poi.name];
                
                addressTitl.text =[NSString stringWithFormat:@"%@ ,%@",self.poi.district, self.poi.address];
                
                distance.titleLabel.text = [NSString stringWithFormat:@"距离我:%ldm", self.poi.distance];
                
                
            }

        } else {
            
            name.titleLabel.text = @"Name";
            address.titleLabel.text = @"Address";
            [button setTitle:@"Call" forState:UIControlStateNormal];
            
            if ([_key isEqualToString:@"a"]) {
                nameTitle.text = self.model.name;
                [self navigationString:self.model.name];
                addressTitl.text =[NSString stringWithFormat:@"%@ ,%@",self.model.district, self.model.address];
                
                distance.titleLabel.text = [NSString stringWithFormat:@"距离我:%ldm", self.model.distance];
                
            }else {
                
                nameTitle.text = self.poi.name;
                //        标题
                [self navigationString:self.poi.name];
                
                addressTitl.text =[NSString stringWithFormat:@"%@ ,%@",self.poi.district, self.poi.address];
                
                distance.titleLabel.text = [NSString stringWithFormat:@"距离我:%ldm", self.poi.distance];
                
                
            }
            
        }
      
        
        
    };
    
    self.block = block;
    
    
}

- (void)buttonAction:(UIButton *)action {
    
    
    NSString *tell = nil;
    if ([_key isEqualToString:@"a"]) {
        tell = self.model.tell;
        
    } else {
        
        tell = self.poi.tel;
        
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"圆通服务" message:tell delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    [self.view addSubview:alert];
    
    alert.delegate = self;
    
    [alert show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
//点击确定按钮
        
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSString *tell = [NSString stringWithFormat:@"tel:%@", self.poi.tel];
        
        NSURL *telURL =[NSURL URLWithString:tell];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:callWebview];
        
        
        
    } else {
        
        
        
        
    }
    
    
}

- (void)navigationString:(NSString *)string{
    
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, 45)];
    
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont boldSystemFontOfSize:17];
    title1.textColor = [UIColor whiteColor];
    title1.text = string;
    //    title.backgroundColor = [UIColor whiteColor];
    //    title.layer.cornerRadius = 0.3 * Screen_Height;
    
    self.navigationItem.titleView =  title1;
    
    
    
    
    
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
