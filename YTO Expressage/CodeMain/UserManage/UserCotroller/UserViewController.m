//
//  UserViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//
#import <UIImageView+WebCache.h>
#import "UserView.h"
#import "UserViewController.h"
#import "International.h"
#define Screen_Width self.view.bounds.size.width / 10
#define Screen_Height self.view.bounds.size.width / 10
@interface UserViewController ()<UIAlertViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScroll;
@property (nonatomic, strong) UIButton *add;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UserView *swep;
@property (nonatomic, strong) UserView *language;
@property (nonatomic, strong) UserView *mssage;
@property (nonatomic, strong) UserView *call;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *folter;
@property (nonatomic, strong) UIView *baclk;
@property (nonatomic, copy) void (^block)(NSString *a);
@property (nonatomic, strong) UILabel *title1;
@property (nonatomic, copy) NSString *languge1;
@property (nonatomic, copy) void (^block1)(NSString *user);

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
    self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];
    [self navigationString];
    void (^block)(NSString *user1) = ^(NSString *user1) {
        if ([user1 isEqualToString:@"chaince"]) {
            
            self.title1.text = @"管理";
        }else {
            
            
            self.title1.text = @"Manager";
            
        }
        
    };
    
    self.block1 = block;
    
    
    
    [self setupView];
    [self dataAddView];
    [self userSwitchLanguge];
    // Do any additional setup after loading the view.
}


-(void)userSwitchLanguge {
    
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        self.block1([dic objectForKey:@"languge"]);
        
    }
    
    
    
}

- (void)setupView{
    
    
    
    self.mainScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.mainScroll.delegate = self;
    self.mainScroll.showsVerticalScrollIndicator = NO;
    self.mainScroll.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.mainScroll.contentSize = CGSizeMake(0, self.view.bounds.size.height - 200);
    [self.view addSubview:self.mainScroll];
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(0, -200, self.mainScroll.bounds.size.width,200)];
    self.image.image = [UIImage imageNamed:@"zd1"];
    [self.mainScroll addSubview:self.image];
    
//    清除缓存
    self.swep = [[UserView alloc]initWithFrame:CGRectMake(0, 1 * Screen_Height, 10 * Screen_Width, Screen_Height * 1.5)];
//    self.swep.backgroundColor = [UIColor whiteColor];
    [self.mainScroll addSubview:self.swep];
    self.swep.back.backgroundColor = [UIColor colorWithRed:240.0 / 255 green:240.0 / 255 blue:130.0 / 255 alpha:1];
//    语言切换
    self.language = [[UserView alloc]initWithFrame:CGRectMake(0, 2.5 * Screen_Height, 10 * Screen_Width, 1.5 * Screen_Height)];
    self.language.button1.selected = YES;
//    self.language.backgroundColor = [UIColor whiteColor];
    [self.mainScroll addSubview:self.language];
    self.language.back.backgroundColor = [UIColor whiteColor];
    
    
    
//    版本信息
    self.mssage = [[UserView alloc]initWithFrame:CGRectMake(0, 4.6 * Screen_Height, Screen_Width * 10, Screen_Height * 1.5)];
//    self.mssage.backgroundColor = [UIColor whiteColor];
    self.mssage.button1.selected = YES;
    [self.mainScroll addSubview:self.mssage];
    self.mssage.back.backgroundColor = [UIColor colorWithRed:240.0 / 255 green:240.0 / 255 blue:130.0 / 255 alpha:1];
//    电话
    self.call  = [[UserView alloc]initWithFrame:CGRectMake(0, 6.1 * Screen_Height, Screen_Width * 10, Screen_Height * 1.5)];
//    self.call.backgroundColor = [UIColor whiteColor];
    self.call.button1.selected = YES;
    [self.mainScroll addSubview:self.call];
    self.call.back.backgroundColor = [UIColor whiteColor];
    
    
    
}





- (void)dataAddView {
    
    [self sewpClean];
    [self languageDataAdd];
    
    
    [self.swep.button1 addTarget:self action:@selector(sewpCleanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self.mssage.button1 addTarget:self action:@selector(mssageView:) forControlEvents:UIControlEventTouchUpInside];
    
    
        [self.call.button1 addTarget:self action:@selector(callCuntons:) forControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *user2 = [user objectForKey:@"languge"];
    
        if ([user2 isEqualToString:@"chaince"]) {
        
             [self.swep.button1 setTitle:@"清理" forState:UIControlStateNormal];
            self.mssage.myTitle.text = @"版本信息";
            [self.mssage.button1 setTitle:@"查看" forState:UIControlStateNormal];
            self.call.myTitle.text = @"客服";
            [self.call.button1 setTitle:@"联系" forState:UIControlStateNormal];

        }else {
            [self.swep.button1 setTitle:@"Clear" forState:UIControlStateNormal];
            self.mssage.myTitle.text = @"Information";
//            self.mssage.myTitle.font = [UIFont systemFontOfSize:15];
            
            [self.mssage.button1 setTitle:@"Check" forState:UIControlStateNormal];
            self.call.myTitle.text = @"Customer";
            [self.call.button1 setTitle:@"Call" forState:UIControlStateNormal];
            
            
        }
        

    
  
    
}
//清理缓存
- (void)sewpClean {
//    缓存文件的地址
    self.swep.button1.selected = YES;
    self.path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    float folder = [self folderSizeAtPath:self.path];
    self.folter = [NSString stringWithFormat:@"%0.1fM", folder];
    
   
    void (^blocke)(NSString *user3) = ^(NSString *user) {
        if ([user isEqualToString:@"chaince"]) {
            
            self.swep.myTitle.text = [NSString stringWithFormat:@"可清理缓存: %@", self.folter];
        }else {
            self.swep.myTitle.text = [NSString stringWithFormat:@"To clear the cache: %@", self.folter];
            
        }
        
    };
    
    self.block1 = blocke;
    
    
    
    
    
    
}

//语言切换
- (void)languageDataAdd {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *user1 = [user objectForKey:@"languge"];
    
        if ([user1 isEqualToString:@"chaince"]) {
            
            self.language.myTitle.text = @"汉语";
            [self.language.button1 setTitle:@"切换" forState:UIControlStateNormal];
 
            
        } else {
            self.language.myTitle.text = @"Chinese";
            [self.language.button1 setTitle:@"Switch" forState:UIControlStateNormal];

            
        }
 
    
    
       [self.language.button1 addTarget:self action:@selector(languageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

//清理内存
- (void)sewpCleanAction:(UIButton *)action {
    
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        if ([[dic objectForKey:@"languge"] isEqualToString:@"chaince"] ) {
             self.swep.myTitle.text = @"清理完毕";
        }else {
           self.swep.myTitle.text = @"Cleared";
        }
       
  
        
    }
    
    [self clearCache:self.path];
        self.swep.button1.selected = NO;
    
    
    
    
}



- (void)navigationString{
    
    
   self.title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width * 6, 0.7 * Screen_Height)];
    
    self.title1.textAlignment = NSTextAlignmentCenter;
    self.title1.font = [UIFont boldSystemFontOfSize:17];
    self.title1.textColor = [UIColor whiteColor];
    
    //    title.backgroundColor = [UIColor whiteColor];
    //    title.layer.cornerRadius = 0.3 * Screen_Height;
    
    self.navigationItem.titleView = self.title1;

    
    
    
    
}


//语言切话点击发法
- (void)languageAction:(UIButton *)cha1But1 {
    
    
    

    
    
    self.baclk = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.baclk];
    self.baclk.backgroundColor = [UIColor blackColor];
    self.baclk.alpha = 0.6;

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width * 4.5, Screen_Width * 5)];
    view.center = CGPointMake(5 * Screen_Width, 6 * Screen_Height);
    view.backgroundColor = [UIColor colorWithRed:215.0 / 255 green:215.0 / 255 blue:210.0 / 255 alpha:1];
    view.layer.cornerRadius = 5;
    [self.baclk addSubview:view];
    
    
    
    UILabel *chanice = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width * 0.3, Screen_Width * 0.3, 2.5 * Screen_Width, Screen_Width * 0.7)];
    [view addSubview:chanice];
    chanice.text = @"中文";
    
    
    UILabel *english = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width * 0.3, 2 * Screen_Width, 2.5 * Screen_Width, Screen_Width * 0.7)];
    
    [view addSubview:english];
    english.text = @"English";
    
    
    UIButton *enty = [UIButton buttonWithType:UIButtonTypeSystem];
    enty.frame = CGRectMake(0, 0, 1.5 * Screen_Width, Screen_Width * 0.8);
    enty.center = CGPointMake(2 * Screen_Width, 3.6 * Screen_Width);
    [view addSubview:enty];
    enty.layer.cornerRadius = 3;
    
    [enty addTarget:self action:@selector(entyAction:) forControlEvents:UIControlEventTouchUpInside];
    enty.backgroundColor = [UIColor whiteColor];
    
    
    
//    语言置换条件
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        if ([[dic objectForKey:@"languge"] isEqualToString:@"chaince"]) {
            self.title1.text = @"语言切换";
            [enty setTitle:@"确定" forState:UIControlStateNormal];
            
        }else {
            
            self.title1.text = @"Language switching";
            [enty setTitle:@"OK" forState:UIControlStateNormal];

        }
        
    }
    
    
//    中文的checkBox
    UITapGestureRecognizer *tapCha = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chanse1Action:)];
    
    UIView *cha1 = [[UIView alloc]initWithFrame:CGRectMake(3.3 * Screen_Width, Screen_Width * 0.3, Screen_Width * 0.5, Screen_Width * 0.5)];
    [cha1 addGestureRecognizer:tapCha];
    
    cha1.center = CGPointMake(3.55 * Screen_Width, 0.65 * Screen_Width);
    [view addSubview:cha1];
    cha1.layer.cornerRadius = 0.25 * Screen_Width;
    cha1.backgroundColor = [UIColor whiteColor];
    UIButton *cha1But = [UIButton buttonWithType:UIButtonTypeSystem];
    cha1But.frame = CGRectMake(0, 0, Screen_Width * 0.15, Screen_Width * 0.15);
    cha1But.backgroundColor = [UIColor blackColor];
    cha1But.center = CGPointMake(0.25 * Screen_Width, 0.25 * Screen_Width);
    cha1But.layer.cornerRadius = 0.075 * Screen_Width;
    
    
    [cha1 addSubview:cha1But];
    [cha1But addTarget:self action:@selector(chanse1Action:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    切换到英文;
    UITapGestureRecognizer *tapEg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(englishAction:)];
    
    UIView *egl1 = [[UIView alloc]initWithFrame:CGRectMake(3.3 * Screen_Width, Screen_Width * 2, Screen_Width * 0.5, Screen_Width * 0.5)];
    egl1.center = CGPointMake(3.55 * Screen_Width, 2.35 * Screen_Width);
//    添加手势
    [egl1 addGestureRecognizer:tapEg];
    [view addSubview:egl1];
    egl1.layer.cornerRadius = 0.25 *Screen_Width;
    egl1.backgroundColor = [UIColor whiteColor];
    UIButton *egl1butt = [UIButton buttonWithType:UIButtonTypeSystem];
    egl1butt.frame = CGRectMake(0, 0, Screen_Width * 0.15,Screen_Width * 0.15);
    egl1butt.backgroundColor = [UIColor blackColor];
    egl1butt.center = CGPointMake(0.25 * Screen_Width, 0.25 * Screen_Width);
    egl1butt.layer.cornerRadius =  0.075 *Screen_Width;
    
    [egl1 addSubview:egl1butt];
    [egl1butt addTarget:self action:@selector(englishAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
   void(^block)(NSString *a) = ^(NSString *b){
       if ([b isEqualToString:@"chaince"]) {
           
           cha1But.backgroundColor = [UIColor greenColor];
           cha1But.frame = CGRectMake(0, 0, 0.33 * Screen_Width, 0.33 *Screen_Width);
           cha1But.center = CGPointMake(0.25 * Screen_Width, 0.25 * Screen_Width);
           cha1But.layer.cornerRadius = 0.165 * Screen_Width;
           
           egl1butt.frame = CGRectMake(0, 0, Screen_Width * 0.15, Screen_Width * 0.15);
           egl1butt.backgroundColor = [UIColor blackColor];
           egl1butt.center = CGPointMake(0.25 * Screen_Width, 0.25 * Screen_Width);
           egl1butt.layer.cornerRadius =  0.075 *Screen_Width;

           
       }
       
       if ([b isEqualToString:@"english"]) {
           
           
        egl1butt.backgroundColor = [UIColor greenColor];
           egl1butt.frame = CGRectMake(0, 0, 0.33 * Screen_Width, 0.33 *Screen_Width);
           egl1butt.center = CGPointMake(0.25 * Screen_Width, 0.25 * Screen_Width);
           egl1butt.layer.cornerRadius = 0.165 * Screen_Width;
           cha1But.frame = CGRectMake(0, 0, Screen_Width * 0.15, Screen_Width * 0.15);
           cha1But.backgroundColor = [UIColor blackColor];
           cha1But.center = CGPointMake(0.25 * Screen_Width, 0.25 * Screen_Width);
           cha1But.layer.cornerRadius = 0.075 * Screen_Width;
 
       }
        
        
    };
    
    block([self searchUserDefatults]);
    
    
    self.block = block;
    
    

    
    
    
}


//选择中文时
- (void)chanse1Action:(id)action {
    self.block(@"chaince");
    self.languge1 = nil;
    self.languge1 = @"chaince";
//    action.backgroundColor = [UIColor greenColor];
//    action.frame = CGRectMake(0, 0, 0.33 * Screen_Width, 0.33 *Screen_Width);
//    action.center = CGPointMake(0.25 * Screen_Width, 0.25 * Screen_Width);
//    action.layer.cornerRadius = 0.165 * Screen_Width;
    
    
}
//英文时；
- (void)englishAction:(id)action {
    self.block(@"english");
    self.languge1 = nil;
    self.languge1 = @"english";
    
//    action.backgroundColor = [UIColor greenColor];
//    action.frame = CGRectMake(0, 0, 0.33 * Screen_Width, 0.33 *Screen_Width);
//    action.center = CGPointMake(0.25 * Screen_Width, 0.25 * Screen_Width);
//    action.layer.cornerRadius = 0.165 * Screen_Width;

    
    
    
    
}

- (void)entyAction:(UIButton *)action {
    
    
    [self.baclk removeFromSuperview];
     [self setUserDefatults];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (user) {
        if ([[user objectForKey:@"languge"]isEqualToString:@"chaince"]) {
          self.title1.text = @"管理";
        } else {
            
            self.title1.text = @"Manager";
        }
        
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"change" object:[user objectForKey:@"languge"] userInfo:nil];
   
    [self userSwitchLanguge];
    [self dataAddView];
    
   
    
    
}


- (void)mssageView:(UIButton *)action {

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"版本信息" message:@"当前版本1.0.1, 已是最新版本" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [self.view addSubview:alert];
    
    [alert show];

    
    
    
}

- (void)callCuntons:(UIButton *)action{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (user) {
        
        
        
        
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"联系客服" message:@"95554" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [self.view addSubview:alert];
    [alert show];
    alert.delegate = self;
    
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 1) {
        
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSString *tell =@"tel:95554";
        
        NSURL *telURL =[NSURL URLWithString:tell];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:callWebview];

        
    }
    
}
- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}

/*整个目录的文件大小*/

- (float ) folderSizeAtPath:(NSString *) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (void)clearCache:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
    
}


// 边界插入图
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat yOffset = scrollView.contentOffset.y;
    //    NSLog(@"%f", yOffset);
    CGFloat xOffset = (yOffset + 200)/2;
    if (yOffset < -200) {
        CGRect f = self.image.frame;
        f.origin.y = yOffset - 80.0;
        f.size.height = -yOffset + 80.0;
        f.origin.x = xOffset;
        f.size.width = self.view.frame.size.width + fabsf(xOffset)*2;
        self.image.frame = f;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    
    
    [super viewDidAppear:animated];
    [self sewpClean];
    
    
    
}



-(NSString *)searchUserDefatults{
    NSString *string = nil;
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        
  string = [dic objectForKey:@"languge"];
        
        
        
    }
    
    return string;
    
}

- (void)setUserDefatults{
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        
        [dic removeObjectForKey:@"languge"];
        [dic synchronize];
        NSLog(@"%@sdfg",_languge1);
        
        [dic setObject:_languge1 forKey:@"languge"];
        
        [dic synchronize];
        
        NSLog(@"dsafdjkash%@", [dic objectForKey:@"languge"]);
        
    }
    
    
}





- (void)changInternational {
    
    
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
