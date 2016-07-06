//
//  CheckViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//



#import "CheckViewController.h"
#import "MapViewController.h"
#import <ZBarSDK.h>
#import "NetworkHandler.h"
#import "TrackViewController.h"
#import "CheckModel.h"
#import "CoerDateModel.h"
#import "MapCheckViewController.h"
#import "RecordViewController.h"
#import "Express.h"
#import "ButtonView.h"
//#import "ZBController.h"
@interface CheckViewController () <ZBarReaderViewDelegate, ZBarReaderDelegate, UITextFieldDelegate>

@property (nonatomic, strong)ZBarReaderView *reader;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UITextField *remark;
@property (nonatomic, strong) UITextField *order;
@property (nonatomic, strong) UIButton *check;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *search;
@property (nonatomic, strong) UIView *BackView;
@property (nonatomic, strong) NSMutableArray *array;
//标记的所有国际化属性；
@property (nonatomic, copy) void(^block)(NSString *user);

@property (nonatomic, copy) NSString *user;

@end

@implementation CheckViewController

-(void)initScreenView {
    UIBarButtonItem *baclk = [[UIBarButtonItem alloc]init];
    
    
    void(^block)(NSString *user) = ^(NSString *user){
        if ([user isEqualToString:@"chaince"]) {
            
                baclk.title = @"返回";
            }else{
                
                
                    
                    baclk.title = @"back";
                    
                
            }
            
        
        
    };
    self.block = block;
    
    
    baclk.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = baclk;
    self.width = self.view.bounds.size.width / 10;
    self.height = self.view.bounds.size.height / 10;
   
}


//测试

- (void)navigationViewAddRight {
    
 
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"my"] style:UIBarButtonItemStylePlain target:self action:@selector(myOrderFrom:)];
    
    
    item1.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item1;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
     self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];
//    创建通知者中心
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(UserDefute) name:@"change" object:nil];
    
    
    [self navigationString];
    [self initScreenView];
    
    [self viewDiDloadAll];
    
    [self navigationViewAddRight];
    
   [self UserDefute];

//    [self animationAddView];
    
//    [self buttonAddZbar];
    
    // Do any additional setup after loading the view.
}

- (void)UserDefute{
    
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        
        self.block([dic objectForKey:@"languge"]);
        
        self.user = [dic objectForKey:@"languge"];
        
    }
    
    
}



- (void)viewDiDloadAll {
    
    self.remark = [[UITextField alloc]initWithFrame:CGRectMake(2.5 * self.width, self.height * 2, self.width * 5.7, self.height * 0.6)];
    
    
    self.remark.textAlignment = NSTextAlignmentCenter;
    self.remark.borderStyle = UITextBorderStyleRoundedRect;
    self.remark.delegate = self;
    
    self.remark.backgroundColor = [UIColor brownColor];
    
    
    [self.view addSubview:self.remark];
    self.remark.layer.cornerRadius = 0.3 * self.height;
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bi"]];
    self.remark.backgroundColor = [UIColor whiteColor];
    self.remark.center = CGPointMake(self.width * 5, 2.3 * self.height);
    image.backgroundColor = [UIColor whiteColor];
    image.frame = CGRectMake(5 * self.width - 0.8 * self.height, 0,0.6 * self.height,0.6 * self.height);
    image.layer.cornerRadius = 0.3 * self.height;
    image.clipsToBounds = YES;
    self.remark.rightView = image;
    self.remark.rightViewMode =  UITextFieldViewModeUnlessEditing;
    self.remark.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    self.order = [[UITextField alloc]initWithFrame:CGRectMake(2 * self.width, 3.8 * self.height, self.width * 6, 32)];
    
//    self.order.backgroundColor = [UIColor brownColor];
    
   
    
    self.order.textAlignment = NSTextAlignmentCenter;
    self.order.backgroundColor = [UIColor whiteColor];
    self.order.layer.cornerRadius = 16;
    self.order.center = CGPointMake(5 * self.width, 3.8 * self.height + 16);
    [self.view addSubview:self.order];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.button.frame = CGRectMake(6 * self.width - 32, 0, 32, 32);
    
    self.button.clipsToBounds = YES;
//    self.button.backgroundColor = [UIColor colorWithRed:90.0 / 255 green:150.0 / 255 blue:220.0 / 255 alpha:1.0];
    
    self.button.layer.cornerRadius =16;
    
    self.order.rightView = self.button;
    
    self.order.rightViewMode = UITextFieldViewModeAlways;
    self.order.delegate = self;
    
    [self.button setBackgroundImage:[UIImage imageNamed:@"phone.png"] forState:UIControlStateNormal];
    
    [self.button addTarget:self action:@selector(swepPhone:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    查地图button方法
    
    ButtonView *check1 = [[ButtonView alloc]initWithFrame:CGRectMake(2 * self.width, 6 * self.height, 50, 74)];
    
    [self.view addSubview:check1];
    [check1.backButon setBackgroundImage:[UIImage imageNamed:@"shu"] forState:UIControlStateNormal];
        [check1.backButon addTarget:self action:@selector(checkModel:) forControlEvents:UIControlEventTouchUpInside];
//    check1.backButon.layer.cornerRadius = 12;
//    check1.backButon.backgroundColor = [UIColor whiteColor];
    
    
    
    
//    self.check = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.check.frame = CGRectMake(2.5 * self.width, 4.8 * self.height + 32, self.width * 2.5, self.height * 0.8);
//    self.check.layer.cornerRadius = 0.4 * self.height;
    
//    [self.view addSubview:self.check];
//    [self.check setTitle:@"查地图" forState:UIControlStateNormal];
//    
//    [self.check addTarget:self action:@selector(checkModel:) forControlEvents:UIControlEventTouchUpInside];
    
//    查单号
    
    ButtonView *search1 = [[ButtonView alloc]initWithFrame:CGRectMake(8 * self.width - 60, 6 * self.height , 60, 74)];
    [self.view addSubview:search1];
   
    [search1.backButon setBackgroundImage:[UIImage imageNamed:@"che"] forState:UIControlStateNormal];
    [search1.backButon addTarget:self action:@selector(searchModel:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 40)];
    
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont boldSystemFontOfSize:17];
    title1.textColor = [UIColor whiteColor];

    
    void (^block)(NSString *user) = ^( NSString *user){
        if ([user isEqualToString:@"chaince"]) {
            search1.title1.font = [UIFont systemFontOfSize:19];
           check1.title1.font = [UIFont systemFontOfSize:19];
            search1.title1.text = @"查物流";
            check1.title1.text = @"查地图";
             self.order.placeholder = @"快递单号";
            self.remark.placeholder = @"写备注";
            title1.text = @"快递查询";
            self.navigationItem.titleView =  title1;
        } else {
            
            search1.title1.text = @"CheckMap";
            
            check1.title1.text = @"CheckTable";
            search1.title1.font = [UIFont systemFontOfSize:9];
            check1.title1.font = [UIFont systemFontOfSize:9];

           
            
            self.order.placeholder = @"OrderID";
            self.remark.placeholder = @"Remarks";
            
            title1.text = @"Express Check";
            
            self.navigationItem.titleView =  title1;
            
            
        }
        
        
        
    };
    
    self.block = block;
    
//    self.search = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    self.search.frame = CGRectMake(self.width * 6, 4.8  * self.height + 32, 2.5 * self.width, self.height * 0.8);
//    self.search.layer.cornerRadius = self.height * 0.4;
//    
//    [self.view addSubview:self.search];
//    
//    [self.search setTitle:@"查物流" forState:UIControlStateNormal];
//    [self.search addTarget:self action:@selector(searchModel:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

/*
 **
 **zbar按钮
 */
//- (void)buttonAddZbar {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(100, 500, 100, 100);
//    button.backgroundColor = [UIColor blackColor];
//    [button addTarget:self action:@selector(barbuttonAdd:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    
//    
//}
/*
 **点击效果
 **
 */
////- (void)barbuttonAdd:(UIButton *)button {
//
//    ZBController *zbar = [ZBController new];
//    [self.navigationController pushViewController:zbar animated:YES];
//    
//    
//    
//    
//    
//}

-(void)swepPhone:(UIButton *)button {

    
    self.BackView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.BackView.backgroundColor = [UIColor blackColor];
//    self.BackView.alpha = 0.7;
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    cancel.frame = CGRectMake(self.width * 3.5, self.height * 4 + self.width * 4, 3 * self.width, self.height * 0.6);
    cancel.layer.cornerRadius = self.height * 0.3;
    [self.BackView addSubview:cancel];
    cancel.backgroundColor = [UIColor whiteColor];
        [cancel addTarget:self action:@selector(cancelModel:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (user) {
        
        if ([[user objectForKey:@"languge"] isEqualToString:@"chaince"]) {
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            
            
            
            
        } else {
            
            [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
            
        }
        
    }
    
    
   
    
    
    
    [self.view addSubview:self.BackView];
    self.reader = [ZBarReaderView new];

   self.reader.frame =  CGRectMake(self.width * 3, self.height * 3, self.width * 4, self.width * 4);
    
//    reader.backgroundColor = [UIColor whiteColor];
//    reader.alpha = 0.5;
    UIView *bacle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width * 4, 3)];
    bacle.backgroundColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
    bacle.center = CGPointMake(2 * self.width, 2 * self.width);
    [_reader addSubview:bacle];
    
    self.reader.readerDelegate = self;
    
    [self.BackView addSubview:_reader];
 
    ZBarImageScanner *scanner = self.reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    self.reader.torchMode = 0;
    [self.reader start];
    
    UIButton *light = [UIButton buttonWithType:UIButtonTypeSystem];
    light.frame = CGRectMake(self.BackView.frame.size.width - 80, 110, 40, 40);
    light.center = CGPointMake(self.BackView.frame.size.width - 40, 110);
    UIImage *image = [UIImage imageNamed:@"light1"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [light setImage:image forState:UIControlStateNormal];
    [self.BackView addSubview:light];
    light.backgroundColor = [UIColor whiteColor];
    light.layer.cornerRadius = 20;
    [light addTarget:self action:@selector(lightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)lightButtonAction:(UIButton *)action {
    
    if (self.reader.torchMode == 0) {
        NSLog(@"1");
        self.reader.torchMode = 1;
        UIImage *image = [UIImage imageNamed:@"light"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [action setImage:image forState:UIControlStateNormal];
    } else {
         NSLog(@"0");
        self.reader.torchMode = 0;
        UIImage *image = [UIImage imageNamed:@"light1"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [action setImage:image forState:UIControlStateNormal];
    }
    
    
}


- (void)cancelModel:(UIButton *)cancel {
    
    [self.BackView removeFromSuperview];
    
}



- (void)searchModel:(UIButton *)search {
    
    if ([self.order.text isEqualToString:@""]) {
        
    
        
        
    } else {
        
        [self animationAddView];
    
    [self handelViewKey:@"search"];
    
        
    }
    
}

//选择查地图时时
- (void)checkModel:(UIButton *)checke {
    if ([self.order.text isEqualToString:@""]) {
        
        
        
        
    } else {
        
        [self animationAddView];
        
        [self handelViewKey:@"checke"];
        
        
    }
    
    
    
    
    
    
}


//ZBar的协议方法， 当扫描成功后调用此方法
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image {
    
    ZBarSymbol *symbol = nil;
    
    for (symbol in symbols) {
        break;
    }
    
    
    
    self.order.text = symbol.data;
    
    [readerView stop];
    
    
    self.reader = nil;
    
    [self.BackView removeFromSuperview];
    
   
    
    
}



- (void)handelViewKey:(NSString *)str {
    

    NSString *url =[NSString stringWithFormat:@"http://api.webapp.58.com/kuaidi/query?type=yuantong&postid=%@", self.order.text];
    
    NSLog(@"%@", self.order.text);
    [NetworkHandler getDataWithURLStr:url completion:^(id result) {
        
        self.array = [NSMutableArray array];
        
        NSArray *arr = [[result objectForKey:@"content"]objectForKey:@"data"];
        
        for (NSDictionary *dic in arr) {
        
            CheckModel *model = [[CheckModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.array addObject:model];
            
            
            
        
            
        }
        
        
        if (result == nil) {
            
            [self alertStupView];
            
            
            
        } else if ([str isEqualToString:@"search"]) {
            [self removeLoadView];
            TrackViewController *track = [[TrackViewController alloc]init];
            
            track.array = self.array;
            
            track.order = self.order.text;
            
            [self.navigationController pushViewController:track animated:YES];
            
            [self addCoreData];
        } else {
            [self removeLoadView];
            
            MapCheckViewController *check = [[MapCheckViewController alloc]init];
            check.array = self.array;
            [self.navigationController pushViewController:check animated:YES];
            
            [self addCoreData];
            
            
        }
        
       
        
   
        
    } error:^(id judge) {
        
        if (judge != nil) {
            
            
            [self alertStupView];
                      
            
        }
        
        
        
    }];
    
   
    
    
    
    
    
}


-(void)alertStupView {
    
    
    
    

    void(^block)(NSString *user) = ^(NSString *user) {
        if ([user isEqualToString:@"chaince"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"圆通提示" message:@"物流信息有误，可能是运单号输入有误 或者 物流单号已过期" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];

            [self.view addSubview:alert];
            [alert show];

        } else {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"YTO Hint" message:@"Logistics information is wrong" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ensure", nil];
            
            [self.view addSubview:alert];
            [alert show];

            
            
            
        }
        
        
    };
                          
    
    block(_user);
    
    
    
}


//保存到数据库中

- (void)addCoreData {
    BOOL key = NO;
    
    CoerDateModel *model = [[CoerDateModel alloc]initCoreDate];
    
    NSArray *arr = [model selectModel];
    
    for (Express *temp in arr) {
        if ([temp.indent isEqualToString:self.order.text]) {
            key = YES;
            
        }
        
    }
    
    
    if (!key) {
        
        
        CheckModel *check = [self.array lastObject];
        [model addModel:check.time indent:self.order.text remark:self.remark.text];
        
        
    }
    
    
    
}



- (void) myOrderFrom:(UIBarButtonItem *)item {
    
    RecordViewController *record = [[RecordViewController alloc]init];
    [self.navigationController pushViewController:record animated:YES];
    
    
    
}
- (void)navigationString{
    
 
//    
//    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 40)];
//    
//    title1.textAlignment = NSTextAlignmentCenter;
//    title1.font = [UIFont boldSystemFontOfSize:17];
//    title1.textColor = [UIColor whiteColor];
//    
//    void(^block)(NSString *user) = ^(NSString *user) {
//           NSLog(@"asdfsdkjf");
//        if ([user isEqualToString:@"chaince"]) {
//            
//            title1.text = @"快递查询";
//            self.navigationItem.titleView =  title1;
//            NSLog(@"WWsdkjf");
//            
//        } else {
//            
//           title1.text = @"Express Check";
//            
//           self.navigationItem.titleView =  title1;
//            
//        }
//    };
//    
//    self.block = block;
    
    //    title.backgroundColor = [UIColor whiteColor];
    //    title.layer.cornerRadius = 0.3 * Screen_Height;
    
    
    
    
    
    
    
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
