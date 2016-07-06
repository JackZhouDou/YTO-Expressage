//
//  NearbyViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-8.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "NearbyViewController.h"
#import "POIAnnotation.h"
#import "NearbyTabelViewController.h"
#import "NearyTableViewController.h"
#import "MapModel.h"
@interface NearbyViewController ()
{
    CLLocationManager *_manager;
    
}

@property (nonatomic, assign) CGFloat lat;
@property (nonatomic, assign) CGFloat lng;
@property (nonatomic, assign) CGFloat lng1;

//@property (nonatomic) AMapSearchType searchType;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, copy) void (^block)(NSString *user);

@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIBarButtonItem *baclk = [[UIBarButtonItem alloc]init];
    void (^block)(NSString *user) = ^(NSString *user) {
        if ([user isEqualToString:@"chaince"]) {
            baclk.title = @"返回";
            
        } else{
            
            baclk.title = @"Back";
            
        }
        
    };
    self.block = block;
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(UserDelutf) name:@"change" object:nil];
    
    self.navigationItem.backBarButtonItem = baclk;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
//    UIBarButtonItem *baclk = [[UIBarButtonItem alloc]init];
//    baclk.title = @"返回";
//    self.navigationItem.backBarButtonItem = baclk;
    self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];
    self.mapView.frame = self.view.bounds;
    
      self.array = [NSMutableArray array];
    
    [self CllocationWithUser];
    [self rightBarControll];
    [self UserDelutf];
    
    // Do any additional setup after loading the view.
}

- (void)UserDelutf {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (user) {
    
        self.block([user objectForKey:@"languge"]);
        
        
    }
    
    
    
}
- (void)CllocationWithUser {



    _manager =[[CLLocationManager alloc] init];

    // fix ios8 location issue
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
#ifdef __IPHONE_8_0
        if ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_manager performSelector:@selector(requestAlwaysAuthorization)];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
        }

        if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [_manager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
        }
#endif
}


   self.mapView.showsUserLocation = YES;
    self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;


}







//自定义精度圈的范围
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay {
    if (overlay == mapView.userLocationAccuracyCircle) {
        
        MACircleView *accuracy = [[MACircleView alloc]initWithOverlay:overlay];
        accuracy.lineWidth = 20.0f;
        accuracy.strokeColor = [UIColor lightGrayColor];
        accuracy.fillColor = [UIColor lightGrayColor];//填充的颜色
        return accuracy;
        
        
        
        
        
        
    }
    
    return nil;
    
}


//自定义用户注视

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[POIAnnotation class]]) {
        
        static NSString *poiIdentifier = @"poiannotation";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[self.mapView
                                                                      dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        
        if (annotationView == nil) {
            
            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
            
        }
        
        annotationView.canShowCallout = YES;
        //        添加一个详情的点击button
        annotationView.centerOffset= CGPointMake(0, -10);
        
        annotationView.draggable = NO;
        annotationView.image = [UIImage imageNamed:@"2222223"];
        
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return annotationView ;
        
    }
    
    
    return nil;
    
}



//详情的点击响应方法;

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    id<MAAnnotation> annotation = view.annotation;
    
    if ([annotation isKindOfClass:[POIAnnotation class]]) {
        POIAnnotation *poiAnnotation = (POIAnnotation *)annotation;
        NearbyTabelViewController *tabel = [[NearbyTabelViewController alloc]init];
        
        tabel.poi = poiAnnotation.poi;
        
        [self.navigationController pushViewController:tabel animated:YES];
        
        
    }
    
    
}









//获取的经纬度
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    if (updatingLocation) {
        
        if (self.lng == 0.0 || (self.lng - userLocation.location.coordinate.longitude) >= 0.00001  || (self.lat - userLocation.location.coordinate.latitude) >= 0.00001) {
            
            
            self.lat = userLocation.location.coordinate.latitude;
            self.lng = userLocation.location.coordinate.longitude;
            
            
            [self searchRequestFrom];
            
            
            self.lng1 = self.lng;
            
        }
        
        
        
        
        //   调用索引
        
        
        
        //self.mapView.showsUserLocation = NO;
        
    }
    
    
    
    
    
}




//关键字搜索请求

- (void)searchRequestFrom {
    
    
    
    
//    self.search = [[AMapSearchAPI alloc]initWithSearchKey:KEYAPA Delegate:self];
    
    AMapPlaceSearchRequest *poinRequest = [[AMapPlaceSearchRequest alloc]init];
    
    poinRequest.searchType = AMapSearchType_PlaceAround;
    
    poinRequest.location = [AMapGeoPoint locationWithLatitude:self.lat longitude:self.lng];
    
    poinRequest.radius = 3000;
    
    NSLog(@"%f, %f", self.lat, self.lng);
    poinRequest.keywords = @"圆通";
    poinRequest.sortrule = 1;
    
    NSLog(@"truhtjdhs");
    poinRequest.requireExtension = YES;
    //    发起周边搜索请求
    [self.search AMapPlaceSearch:poinRequest];
    
    
    
}


//实现poi搜索
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response {
    
    
    
    if (response.pois.count == 0) {
        return ;
    }
    
    NSMutableArray *poinAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    //    所有返回的数据
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poinAnnotations addObject:[[POIAnnotation alloc]initWithPOI:obj]];
        }];
    
    
    [self.array removeAllObjects];
    //帮他加到model中
    for (POIAnnotation *po in poinAnnotations) {
        MapModel *model = [[MapModel alloc]init];
        model.name = po.poi.name;
        model.address = po.poi.address;
        model.latitude = po.poi.location.latitude;
        model.longitude = po.poi.location.longitude;
        model.tell = po.poi.tel;
        model.distance = po.poi.distance;
        model.district = po.poi.district;
        
        [self.array addObject:model];
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    [self.mapView addAnnotations:poinAnnotations];
    
    if (poinAnnotations.count == 1) {
        
        self.mapView.centerCoordinate = [poinAnnotations[0] coordinate];
        
        
    } else {
        
        [self.mapView showAnnotations:poinAnnotations animated:YES];
    }
    
    
    NSLog(@"chao%@",response);
    
    
    
    
}


//添加右边bar
- (void)rightBarControll {
    
    
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 40)];
    
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont boldSystemFontOfSize:17];
    title1.textColor = [UIColor whiteColor];
    
    //    title.backgroundColor = [UIColor whiteColor];
    //    title.layer.cornerRadius = 0.3 * Screen_Height;
    
    
    self.navigationItem.titleView =  title1;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeSystem];
    right.frame = CGRectMake(0, 0, 50, 30);
    
    right.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    right.backgroundColor = [UIColor whiteColor];
    [right setTitleColor:[UIColor colorWithRed:90.0 / 255 green:145.0 / 255 blue:220.0 / 255 alpha:1] forState:UIControlStateNormal];
    right.layer.cornerRadius = 12;
    [right addTarget:self action:@selector(rightBar:) forControlEvents:UIControlEventTouchUpInside];
    
    void (^block)(NSString *user) = ^(NSString *user) {
        if ([user isEqualToString:@"chaince"]) {
            
            title1.text = @"附近圆通";
            [right setTitle:@"所有" forState:UIControlStateNormal];
        }else {
           title1.text = @"Nearby YTO";
            [right setTitle:@"All" forState:UIControlStateNormal];
            
        }
        
        
    };
    self.block = block;
    
//    
//    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"所有" style:UIBarButtonItemStylePlain target:self action:@selector(rightBar:)];
//    buttonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    
    
    
    
    
    
}


- (void)rightBar:(id)action {
    NearyTableViewController *nearby = [[NearyTableViewController alloc]init];
    nearby.array = self.array;
    
    [self.navigationController pushViewController:nearby animated:YES];
    
    
    
    
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
