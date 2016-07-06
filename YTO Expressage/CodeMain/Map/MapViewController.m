//
//  MapViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-6.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "MapViewController.h"
//#import "MapModel.h"

//#import "POIAnnotation.h"
//#import "NearbyTabelViewController.h"

#define KEYAPA @"028c305f1e10d7fb98d6267509d07d8d"

@interface MapViewController ()
//{
//    CLLocationManager *_manager;
//
//}


//@property (nonatomic, assign) CGFloat lat;
//@property (nonatomic, assign) CGFloat lng;
//@property (nonatomic, assign) CGFloat lng1;
//
////@property (nonatomic) AMapSearchType searchType;
//
//@property (nonatomic, strong) NSMutableArray *array;



@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.array = [NSMutableArray array];
    [self initMapView];//地图初始化
    //给tableBar添加标题和返回响应
    [self initSearch];//索引的初始化；
    

    // Do any additional setup after loading the view.
}

//定位功能的实现

//- (void)CllocationWithUser {
//    
//    
//    
//    _manager =[[CLLocationManager alloc] init];
//    
//    // fix ios8 location issue
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
//#ifdef __IPHONE_8_0
//        if ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)])
//        {
//            [_manager performSelector:@selector(requestAlwaysAuthorization)];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
//        }
//        
//        if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)])
//        {
//            [_manager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
//        }
//#endif
//}
//    
//    
//   self.mapView.showsUserLocation = YES;
//    self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
//    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
//    
//    
//}
//


////自定义精度圈的范围
//- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay {
//    if (overlay == mapView.userLocationAccuracyCircle) {
//        
//        MACircleView *accuracy = [[MACircleView alloc]initWithOverlay:overlay];
//        accuracy.lineWidth = 20.0f;
//        accuracy.strokeColor = [UIColor lightGrayColor];
//        accuracy.fillColor = [UIColor lightGrayColor];//填充的颜色
//        return accuracy;
//        
//        
//        
//        
//        
//        
//    }
//    
//    return nil;
//    
//}


////自定义用户注视
//
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
//    
//    if ([annotation isKindOfClass:[POIAnnotation class]]) {
//        
//        static NSString *poiIdentifier = @"poiannotation";
//        
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[self.mapView
// dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
//        
//        if (annotationView == nil) {
//            
//            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
//            
//        }
//        
//        annotationView.canShowCallout = YES;
////        添加一个详情的点击button
//        annotationView.centerOffset= CGPointMake(0, -10);
//
//        annotationView.image = [UIImage imageNamed:@"2222223"];
//        
//        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        
//        return annotationView ;
//        
//    }
//    
//    
//    return nil;
//    
//}

////详情的点击响应方法;
//
//- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//    
//    id<MAAnnotation> annotation = view.annotation;
//    
//    if ([annotation isKindOfClass:[POIAnnotation class]]) {
//        POIAnnotation *poiAnnotation = (POIAnnotation *)annotation;
//        NearbyTabelViewController *tabel = [[NearbyTabelViewController alloc]init];
//        
//        tabel.poi = poiAnnotation.poi;
//        
//        [self.navigationController pushViewController:tabel animated:YES];
//        
//        
//    }
//    
//    
//}




//地图的实列化
- (void)viewDidAppear:(BOOL)animated {
    
//    3D地图实列化 实列化只能一次
    
    [super viewDidAppear:animated];
    
//    if (self.mapView == nil) {
//       
//        
//        
//        [MAMapServices sharedServices].apiKey = KEYAPA;
//        
//        self.mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
//        self.mapView.delegate = self;
//        self.mapView.scrollEnabled = YES;
//        self.mapView.rotateEnabled = YES;
//        
//        [self.view addSubview:self.mapView];
//        
//        [self CllocationWithUser];
//        
//        
//        
//    }
    
   
    
    
}

//地图初始
- (void)initMapView {
    
    if (self.mapView == nil) {
        
        
        
        [MAMapServices sharedServices].apiKey = KEYAPA;
        
        self.mapView = [[MAMapView alloc]init];
        self.mapView.delegate = self;
        self.mapView.scrollEnabled = YES;
        self.mapView.rotateEnabled = YES;
        
        [self.view addSubview:self.mapView];
        
//        [self CllocationWithUser];
        
        
        
    }

    
    
    
}
//搜索初始化
- (void)initSearch {
    
    
       self.search = [[AMapSearchAPI alloc]initWithSearchKey:KEYAPA Delegate:self];
//    self.search.delegate = self;
    
    
}


//截屏图
- (void)shotImage {
    
    UIImage *screenshotImage = [self.mapView takeSnapshotInRect:self.view.bounds];
    
    
    
    
    
}

////获取的经纬度
//- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
//    
//    if (updatingLocation) {
//    
//        if (self.lng == 0.0 || (self.lng - userLocation.location.coordinate.longitude) >= 0.00001  || (self.lat - userLocation.location.coordinate.latitude) >= 0.00001) {
//            
//            
//            self.lat = userLocation.location.coordinate.latitude;
//            self.lng = userLocation.location.coordinate.longitude;
//            
//            
//            [self searchRequestFrom];
//            
//            
//             self.lng1 = self.lng;
//            
//        }
//        
//        
//        
//        
////   调用索引
//        
//        
//        
//        //self.mapView.showsUserLocation = NO;
//        
//    }
//    
//    
//    
//    
//    
//}



////关键字搜索请求
//
//- (void)searchRequestFrom {
//    
//    
//    
//    
//    self.search = [[AMapSearchAPI alloc]initWithSearchKey:KEYAPA Delegate:self];
//    AMapPlaceSearchRequest *poinRequest = [[AMapPlaceSearchRequest alloc]init];
//    
//    poinRequest.searchType = AMapSearchType_PlaceAround;
//    
//    poinRequest.location = [AMapGeoPoint locationWithLatitude:self.lat longitude:self.lng];
//    
//    poinRequest.radius = 3000;
//    
//    NSLog(@"%f, %f", self.lat, self.lng);
//    poinRequest.keywords = @"圆通";
//    poinRequest.sortrule = 1;
//    
//    NSLog(@"truhtjdhs");
//    poinRequest.requireExtension = YES;
////    发起周边搜索请求
//    [self.search AMapPlaceSearch:poinRequest];
//    
//    
//    
//}


////实现poi搜索
//- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response {
//    
//    
//    
//    if (response.pois.count == 0) {
//        
//        
//        return ;
//        
//        
//    }
//    
//    
//    NSMutableArray *poinAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
//    
////    所有返回的数据
//    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
//       
//        [poinAnnotations addObject:[[POIAnnotation alloc]initWithPOI:obj]];
//    
//    
//        
//        
//        
//    }];
//    
//
//    [self.array removeAllObjects];
//    //帮他加到model中
//    for (POIAnnotation *po in poinAnnotations) {
//        MapModel *model = [[MapModel alloc]init];
//        model.name = po.poi.name;
//        model.address = po.poi.address;
//        model.latitude = po.poi.location.latitude;
//        model.longitude = po.poi.location.longitude;
//        model.tell = po.poi.tel;
//        model.distance = po.poi.distance;
//        model.district = po.poi.district;
//        
//        [self.array addObject:model];
//        
//        
//       
//        
//        
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    [self.mapView addAnnotations:poinAnnotations];
//    
//    if (poinAnnotations.count == 1) {
//        
//        self.mapView.centerCoordinate = [poinAnnotations[0] coordinate];
//        
//        
//    } else {
//        
//        [self.mapView showAnnotations:poinAnnotations animated:YES];
//    }
//    
//    
//   NSLog(@"chao%@",response);
//    
//    
//    
//    
//}



-(void)clearSearch {
    
    
    self.search.delegate = nil;
    
    
    
    
}



- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
    
    [self.mapView setCompassImage:nil];
}


//退出时进行清理
- (void)returnAction {
    
    
  
    
        [self.navigationController popViewControllerAnimated:YES];
        
        [self clearMapView];
        
        [self clearSearch];
    

    
    
}

//给左标题添加一个按钮

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
