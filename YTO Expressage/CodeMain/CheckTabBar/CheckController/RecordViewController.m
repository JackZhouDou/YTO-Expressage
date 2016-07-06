//
//  RecordViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-5.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//
#import "CoerDateModel.h"
#import "CheckCollectionViewCell.h"
#import "RecordViewController.h"
#import "NetworkHandler.h"
#import "CheckModel.h"
#import "TrackViewController.h"

#define Screen_Width self.view.bounds.size.width / 10
#define Screen_Height self.view.bounds.size.height / 10

@interface RecordViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, assign) BOOL key;
@property (nonatomic, copy) void (^block)(NSString *user);

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self navigationString];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(userDelfutel) name:@"change" object:nil];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
    self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];
    UIBarButtonItem *baclk = [[UIBarButtonItem alloc]init];
   
    baclk.tintColor = [UIColor yellowColor];
    self.navigationItem.backBarButtonItem = baclk;
    
//    标题
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,100, 40)];
    
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont boldSystemFontOfSize:17];
    title1.textColor = [UIColor whiteColor];
    
    //    title.backgroundColor = [UIColor whiteColor];
    //    title.layer.cornerRadius = 0.3 * Screen_Height;
    
    self.navigationItem.titleView =  title1;

    
    void (^block)(NSString *user) = ^(NSString *user) {
        if ([user isEqualToString:@"chaince"]) {
        
             baclk.title = @"返回";
            title1.text = @"我的查询记录";
            
        
        } else {
            
            baclk.title = @"Back";
            title1.text = @"My Check Record";
            
            
        }
        
    };
    self.block = block;
    
//    baclk.tintColor = [UIColor colorWithRed:240.0 / 255 green:188.0 / 255 blue: 10.0 / 255 alpha:1];
    
    
    [self arrayAdd];
    [self stupeViewAll];
    [self rieghtButton];
    [self userDelfutel];
    // Do any additional setup after loading the view.
}


- (void)userDelfutel {
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        
        self.block([dic objectForKey:@"languge"]);
        
    }
    
}
- (void)arrayAdd {
   
    
    
    CoerDateModel *model = [[CoerDateModel alloc]initCoreDate];
    
     self.array = [NSMutableArray arrayWithArray:[model selectModel]];
    
    
    
}





- (void)stupeViewAll {
   
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(Screen_Width * 8, Screen_Width * 3);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing  = 10;
    
 self.collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow];
    [self.view addSubview:self.collection];
    
    self.collection.backgroundColor = [UIColor whiteColor];
    
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerClass:[CheckCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    
    
    
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    
    
    return self.array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CheckCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    Express *model = [self.array objectAtIndex:indexPath.row];
    
    
    [cell loadeViewAdd:model];
    
    
    void (^block)(NSIndexPath *indexpat) = ^(NSIndexPath *indexPat) {
        
        [_array removeObjectAtIndex:indexPat.item];
        
        NSArray *arr = @[indexPat];
        
        [collectionView deleteItemsAtIndexPaths:arr];
        
        
    };
    
    cell.block = block;
    
    
    
    
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self animationAddView];
    
    Express *model = [self.array objectAtIndex:indexPath.row];
    [self handleNetWorke:model.indent];
    
    
    
    
    
}
- (void)handleNetWorke:(NSString *)worke {
    
    NSString *url =[NSString stringWithFormat:@"http://api.webapp.58.com/kuaidi/query?type=yuantong&postid=%@", worke];
    
    NSLog(@"%@",worke);
 
        
     NSMutableArray *array = [NSMutableArray array];
    
        
        [NetworkHandler getDataWithURLStr:url completion:^(id result) {
            
            
            
            NSArray *arr = [[result objectForKey:@"content"]objectForKey:@"data"];
            
            for (NSDictionary *dic in arr) {
                
                CheckModel *model = [[CheckModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [array addObject:model];
                
                
            }
            if (arr.count == 0) {
                [self alertViewAddView];
                
            }else {
                
                
                TrackViewController *trackView = [[TrackViewController alloc]init];
                trackView.array = array;
                trackView.order = worke;

                [self.navigationController pushViewController:trackView animated:YES];
            }
            
            [self removeLoadView];
            
            
            
        } error:^(id judge) {
            if (judge != nil) {
                
                [self removeLoadView];
                [self alertViewAddView];
                
                
                
            }
            
            
            
            
            
        }];
            
        
    
    
}


- (void)alertViewAddView{
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
   NSString *str = [dic objectForKey:@"languge"];
    if ([str isEqualToString:@"chaince"]) {
        

    UIAlertView *alert = [[ UIAlertView alloc]initWithTitle:@"圆通提示你" message:@"单号已过期" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [self.view addSubview:alert];
    [alert show];
        
    } else {
        UIAlertView *alert = [[ UIAlertView alloc]initWithTitle:@"YTO Prompt you to" message:@"Number has been overdue" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [self.view addSubview:alert];
        [alert show];
        
    }
    
    
    
    
}

- (void)rieghtButton {

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(alertViewStup)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    
}

- (void)alertViewStup {
  
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    
    NSString *user = [dic objectForKey:@"languge"];
   
        if ([user isEqualToString:@"chaince"]) {
            NSString *item = @"";
            if (self.array.count == 0) {
                self.key = YES;
                item = @"暂无记录, 赶紧添加吧!";
                
            } else {
                self.key = NO;
                
                item = @"是否清除所有查询记录";
            }
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:item delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [self.view addSubview:alert];
            [alert show];

        } else {
            
            NSString *item = @"";
            if (self.array.count == 0) {
                self.key = YES;
                item = @"No record, To add!";
                
            } else {
                self.key = NO;
                
                item = @"Whether to clear all the query record";
            }
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Prompt" message:item delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            [self.view addSubview:alert];
            [alert show];

            
            
            
            
        }

        
        
   
    
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (self.key) {
            
            [self.navigationController  popViewControllerAnimated:YES];
            
            
        } else {
            
        [self DeleteAllModel];
        
        }
    }
    
    
    
}

//- (void)navigationString{
//    
//    
//    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,100, 40)];
//    
//    title1.textAlignment = NSTextAlignmentCenter;
//    title1.font = [UIFont boldSystemFontOfSize:17];
//    title1.textColor = [UIColor whiteColor];
//    title1.text = @"我的查询记录";
//    //    title.backgroundColor = [UIColor whiteColor];
//    //    title.layer.cornerRadius = 0.3 * Screen_Height;
//    
//    self.navigationItem.titleView =  title1;
//    
//    
//    
//    
//    
//}

- (void)DeleteAllModel {
    
     CoerDateModel *model = [[CoerDateModel alloc]initCoreDate];
    [model deleteAll];
    [self.array removeAllObjects];
    [self arrayAdd];
    [self.collection reloadData];
    
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
