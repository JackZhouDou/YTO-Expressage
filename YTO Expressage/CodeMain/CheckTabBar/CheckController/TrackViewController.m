//
//  TrackViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-3.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "TrackViewController.h"
#import "TrackTableViewCell.h"
#import "CheckModel.h"
#import "CoerDateModel.h"
#import "MapCheckViewController.h"
@interface TrackViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UITableView *table;

@property (nonatomic, assign) CGFloat  width;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) void(^block)(NSString *user);

@end

@implementation TrackViewController

- (void)initFrame {
    
    
    self.width = self.view.bounds.size.width / 10;
    
    self.height = self.view.bounds.size.height / 10;
    
    
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationString];
//    创建一个通知者中心；
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(userDefutle) name:@"change" object:nil];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
    self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];
    [self navigationBar];
    
    [self initFrame];
    [self setupView];
    [self userDefutle];
    
    // Do any additional setup after loading the view.
}

- (void)setupView{
    
    
    UIBarButtonItem *baclk = [[UIBarButtonItem alloc]init];
    
    //    baclk.tintColor = [UIColor colorWithRed:240.0 / 255 green:188.0 / 255 blue: 10.0 / 255 alpha:1];
    self.navigationItem.backBarButtonItem = baclk;
    
    
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[TrackTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.height * 1.5)];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(self.width / 2, 0, self.width * 1.5 , self.width * 1.5)];
    image.image = [UIImage imageNamed:@"zdd"];
    image.layer.cornerRadius = self.width * 0.75;
    image.clipsToBounds = YES;
    image.center = CGPointMake(self.width, 0.75 * self.height);
    [viewHeader addSubview:image];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(2 * self.width, 0, self.width * 8, 0.75 * self.height)];
    
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:20];
    viewHeader.backgroundColor = [UIColor colorWithRed:240.0 / 255 green:240.0 / 255 blue:240.0 / 255 alpha:1];
    [viewHeader addSubview:title];
    
    UILabel *orderText = [[UILabel alloc]initWithFrame:CGRectMake(self.width * 2, 0.78 * self.height, self.width * 8, 0.5 * self.height)];
    orderText.textAlignment = NSTextAlignmentCenter;
    orderText.font = [UIFont boldSystemFontOfSize:17];
    orderText.text = self.order;
    
    [viewHeader addSubview:orderText];
    
    
    self.table.tableHeaderView = viewHeader;
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 40)];
//    标题
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont boldSystemFontOfSize:17];
    title1.textColor = [UIColor whiteColor];
        //    title.backgroundColor = [UIColor whiteColor];
    //    title.layer.cornerRadius = 0.3 * Screen_Height;
    
    self.navigationItem.titleView =  title1;

    
    
    void (^block)(NSString *user) = ^(NSString *user) {
        if ([user isEqualToString:@"chaince"]) {
            baclk.title = @"返回";
            title.text = @"运单号";
            title1.text = @"物流跟踪";

        }else {
            baclk.title = @"Back";
            title.text = @"Express Number";
            title1.text = @"Express Trace";
            
        }
        
    };
    
    self.block = block;

    
    
    
}



- (void)userDefutle {
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        
        self.block([dic objectForKey:@"laguage"]);
        
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%ld", self.array.count);
    
    return self.array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TrackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
  
    
    
    
    
    
    CheckModel *model = [self.array objectAtIndex:indexPath.row];
    
    if ([model.context rangeOfString:@"已签收"].length == 3) {
        
        
        cell.imagebig.image = [UIImage imageNamed:@"enty"];
        
    } else if (indexPath.row == self.array.count - 1){
 
        cell.imagebig.image = [UIImage imageNamed:@"began"];
        
        
        
    } else {
       cell.imagebig.image = [UIImage imageNamed:@"up"];
        
        
    }
        
    
    
    
    cell.time.text = model.time;
    
    cell.address.text = model.context;
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return self.width * 3;
}


- (void)navigationBar {
    
   

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"mapSearch"] style:UIBarButtonItemStylePlain target:self action:@selector(barAddViewAction:)];
       
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    
    
    
    
    
    
}

- (void)barAddViewAction:(UIBarButtonItem *)action {
    
    MapCheckViewController *map = [[MapCheckViewController alloc]init];
    map.array = self.array;
    
    [self.navigationController pushViewController:map animated:YES];
    
    
    
}


- (void)navigationString{
    
    
//    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 40)];
//    
//    title1.textAlignment = NSTextAlignmentCenter;
//    title1.font = [UIFont boldSystemFontOfSize:17];
//    title1.textColor = [UIColor whiteColor];
//    title1.text = @"物流跟踪";
//    //    title.backgroundColor = [UIColor whiteColor];
//    //    title.layer.cornerRadius = 0.3 * Screen_Height;
//    
//    self.navigationItem.titleView =  title1;
    
    
    
    
    
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
