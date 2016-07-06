//
//  NearyTableViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-8.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "NearyTableViewController.h"
#import "TableTableViewCell.h"
#import "NearbyTabelViewController.h"
#import "MapModel.h"
@interface NearyTableViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) void(^block)(NSString *user);
@end

@implementation NearyTableViewController



- (void)stupView {
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[TableTableViewCell class] forCellReuseIdentifier:@"reuse"];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width / 2)];
    image.image = [UIImage imageNamed:@"biaozhi"];
    
    self.tableView.tableHeaderView = image;
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return self.array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if ((indexPath.row + 1) % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:236.0 / 255 green:236.0 / 255 blue:236.0 / 255 alpha:1];
        
    }
    
    MapModel *model = [self.array objectAtIndex:indexPath.item];
    
    cell.name.text = model.name;
    cell.address.text = model.address;
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NearbyTabelViewController *nearby = [[NearbyTabelViewController alloc]init];
    nearby.model = [self.array objectAtIndex:indexPath.item];
    nearby.key = @"a";
    [self.navigationController pushViewController:nearby animated:YES];
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return self.view.bounds.size.height / 5;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self stupView];
    [self navigationString];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
    self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(UserDefault) name:@"change" object:self];
    [self UserDefault];
    
    // Do any additional setup after loading the view.
}

- (void)UserDefault{
    
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        self.block([dic objectForKey:@"languge"]);
        
    }
    
    
    
}


- (void)navigationString{
    
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 40)];
    
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont boldSystemFontOfSize:17];
    title1.textColor = [UIColor whiteColor];
    
    void (^block)(NSString *text) = ^(NSString *user){
        if ([user isEqualToString:@"chaince"]) {
            title1.text = @"圆通列";
        } else {
            
            title1.text = @"YTOTable";
            
        }
    };
    self.block = block;
    
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
