//
//  LocationViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-6.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "LocationViewController.h"

@interface LocationViewController ()
{
    CLLocationManager *manage;
    
    
    
}

@property (nonatomic, strong) AMapSearchAPI *_search;

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, assign) CGFloat lat;

@property (nonatomic, assign) CGFloat log;





@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)mapInit {
    
    [MAMapServices sharedServices].apiKey = @"028c305f1e10d7fb98d6267509d07d8d";
    self.mapView = [[MAMapView alloc]init];
  
    
    
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
