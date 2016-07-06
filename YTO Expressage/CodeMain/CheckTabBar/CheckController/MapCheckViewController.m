//
//  MapCheckViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-8.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//
#import "CheckModel.h"
#import "MapStringData.h"
#import "MapCheckViewController.h"
#import "POIAnnotation.h"
#import "AnimatedAnnotation.h"
#import "AnimatedAnnotationView.h"

#define Screen_Width self.view.bounds.size.width / 10
#define Screen_Height self.view.bounds.size.height / 10
@interface MapCheckViewController ()
{
    CLLocationManager *_manager;
    
}
//@property (nonatomic, strong) NSMutableArray *dataArray;
//创建动画视图
//@property (nonatomic, strong) NSMutableArray *handleData;
@property (nonatomic, strong) MapStringData *mapString;

//开始时的动画图
@property (nonatomic, strong) NSMutableArray *beginAnimated;

//结束时的动画图
@property (nonatomic, strong) NSMutableArray *endAnimated;

//运输途中的动画图
@property (nonatomic, strong) NSMutableArray *onWayAnimate;

//@property (nonatomic, assign) CGFloat latDiffer;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, strong) UILabel *lableDistance;


@property (nonatomic, assign) CGFloat myLat;

@property (nonatomic, assign) CGFloat myLng;
//@property (nonatomic, assign) NSInteger conut;
@property (nonatomic, assign) BOOL judge;

//@property (nonatomic, strong) UIButton *zoomMap;

@property (nonatomic, strong) UIButton *playMap;

@property (nonatomic, assign) BOOL key;

@property (nonatomic, copy) void (^block)(NSString *user);

@end

@implementation MapCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
    self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];    self.navigationController.navigationBar.translucent = NO;
    self.mapView.frame = CGRectMake(0, 0, Screen_Width * 10, Screen_Width * 10);
//    self.itemCount = YES;
//    self.conut = 0;
    self.mapString = [[MapStringData alloc]init];
//    创建一个通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(userDefault) name:@"change" object:nil];
    
//    self.handleData = [NSMutableArray array];
//    self.dataArray = [NSMutableArray array];
    [self dataNSArrayFoundtion];
    [self animationArrayAdd];
    [self poiHandel];
    [self initBaseNavigationBar];
    [self buttonStup];
    [self userDefault];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)userDefault{
    
        NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
        if (dic) {
            self.block([dic objectForKey:@"languge"]);
        }
        
  
    
    
}
//创建一个放大缩小的按钮和播放按钮
- (void)buttonStup {
    self.key = YES;
    self.playMap = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playMap.frame = CGRectMake(Screen_Width * 10 - 37, 5, 32, 32);
    [self.playMap addTarget:self action:@selector(blayMapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:self.playMap];
    [self.playMap setBackgroundImage:[UIImage imageNamed:@"max.png"] forState:UIControlStateNormal];
    self.lableDistance = [[UILabel alloc]initWithFrame:CGRectMake(0, Screen_Width * 11, 10 * Screen_Width, Screen_Height)];
    
    [self.view addSubview:self.lableDistance];
    
    self.lableDistance.font = [UIFont boldSystemFontOfSize:20];
    self.lableDistance.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    
    
//    self.zoomMap = [UIButton buttonWithType:UIButtonTypeSystem];
    
//    self.zoomMap.frame = CGRectMake(Screen_Width, self.mapView.frame.size.height - 1.2 * Screen_Height, Screen_Height, Screen_Height) ;
    
//    [self.mapView addSubview:self.zoomMap];
//    [self.zoomMap addTarget:self action:@selector(zoomMapButton:) forControlEvents:UIControlEventTouchUpInside];
//    self.zoomMap.userInteractionEnabled = NO;
    

    
    
    
    
    
}
//放大缩小的点击响应
- (void)blayMapButton:(UIButton *)action {
    
    if (self.key) {
        
         self.mapView.frame = CGRectMake(0, 0, Screen_Width * 10, self.view.bounds.size.height);
        [action setBackgroundImage:[UIImage imageNamed:@"min.png"] forState:UIControlStateNormal];
        self.lableDistance.hidden = YES;
        
        self.key = NO;
        
    } else {
         self.mapView.frame = CGRectMake(0, 0, Screen_Width * 10, Screen_Width * 10);
        [action setBackgroundImage:[UIImage imageNamed:@"max.png"] forState:UIControlStateNormal];
        
        self.lableDistance.hidden = NO;
        
        self.key = YES;

    }
    
    
    
}





- (void)cclocationManmger {
    
    
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
    self.mapView.userTrackingMode = MAUserTrackingModeNone;
    

    
    
    
    
    
    
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    if (updatingLocation) {
        
        if ((unsigned)(self.myLng - userLocation.location.coordinate.longitude) >= 0.01 || (unsigned)(self.myLat - userLocation.location.coordinate.latitude) >= 0.01) {
            
            
            self.myLat = userLocation.location.coordinate.latitude;
            self.myLng = userLocation.location.coordinate.longitude;
            
            
          
             NSLog(@"lat555%f", userLocation.coordinate.latitude);
            
            [self pointDistance];
            
            
        }


       
        
        
    }
    
    
}


// 播放响应
//- (void)zoomMapButton:(UIButton *)action {

    
    
    
//}

//对里面的数据重新处理
- (void)dataNSArrayFoundtion {
    
   self.judge = NO;
    
    
    for (MapStringData *model in self.array)  {
     
        
        MapStringData *data = [[MapStringData alloc]init];
        
        if (!([model.context rangeOfString:@"已签收"].length == 3) && ([model.context rangeOfString:@" "].length  != 0)) {
            
            NSArray *arr = [model.context componentsSeparatedByString:@" "];
            NSLog(@"arrFirst%@", [arr firstObject]);
            
            NSString *address = nil;
            
            if ([[arr firstObject]rangeOfString:@"市"].length  != 0)   {
                
                 NSArray *arry = [[arr firstObject] componentsSeparatedByString:@"市"];
                address = [NSString stringWithFormat:@"%@市",[arry firstObject]];
                
                NSLog(@"adderssSHI%@", address);
                
                
            } else if([[arr firstObject]rangeOfString:@"("].length  != 0){
                
                NSArray *arry = [[arr firstObject] componentsSeparatedByString:@"("];
                address = [arry firstObject];
                NSLog(@"(%@)",address);
                
                
            } else {
                
               address = [arr firstObject];
                NSLog(@"else%@", address);
                
            
            }
            
            
            data.time = model.time;
            data.context = model.context;
            data.address = address;

            if (self.array.count == 1) {
                
                data.image = @"a";
            NSLog(@"djsfhjshf%@", address);
                self.mapString = data;
              
               
                
            } else if (self.judge) {
               
                data.image = @"c";
                
                
//                判断是不是和前面的一样
               
            } else {
                
                data.image = @"b";
                
                
            }
            
            
            self.mapString = data;
            
            
            
            return ;
            
            
            
            
            
        } else if ([model.context rangeOfString:@"已签收"].length == 3) {
            
            self.judge = YES;
            
            
            
            
            
            
        }
        
        
    }
    
    
   
        
   
    
    
    


    
    
    
    
}


//创建一个返回bar经行清理
- (void)initBaseNavigationBar
{
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 40)];
    
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont boldSystemFontOfSize:17];
    title1.textColor = [UIColor whiteColor];
    void (^block)(NSString *user) = ^(NSString *user){
        if ([user isEqualToString:@"chaince"]) {
             title1.text = @"地图跟踪";
            
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                                     style:UIBarButtonItemStyleBordered
                                                                                    target:self
                                                                                    action:@selector(returnAction)];
            
        } else {
            title1.text = @"Map Trace";
            
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                                     style:UIBarButtonItemStyleBordered
                                                                                    target:self
                                                                                    action:@selector(returnAction)];
            
            
        }
        
    };
    self.navigationItem.titleView =  title1;

    self.block = block;
    
   
    //    title.backgroundColor = [UIColor whiteColor];
    //    title.layer.cornerRadius = 0.3 * Screen_Height;
    
   
    
}




//通过关键词搜索
- (void)searchPoiByKeyword:(NSString *)key
{
    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
    
    request.searchType          = AMapSearchType_Geocode;
    
   
    
    
    request.address = key; //搜索的关键词
    
//    request.city = 
   
   
    [self.search AMapGeocodeSearch:request];
}



//searchAPI的回调方法；
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    
   
    
    if (response.count == 0) {
        
        
        return ;
        
    } else {
        
         AMapGeocode *poit = [response.geocodes firstObject];
        
//        if (self.conut < self.dataArray.count) {
//            
//            //        筛选后的经纬度
//            MapStringData *model = [[MapStringData alloc]init];
//            model = [self.dataArray objectAtIndex:(self.conut - 1)];
//            model.lat2 = poit.location.latitude;
//            model.lng2 = poit.location.longitude;
//            [self.handleData addObject:model];
//             MapStringData *temp = [self.dataArray objectAtIndex:self.conut];
//            [self searchPoiByKeyword:temp.address];
//
//            if (self.itemCount) {
//                
//                
//                [self annotationStup:model bools:YES];
//                self.itemCount = NO;
//                
//                
//                NSLog(@"%@",model.address);
//                
//            }
//            
//        }
//        
//        
//        
//       
//
//        NSLog(@"🐯%f", poit.location.longitude);
//
//        
//        
//    }
//    
    
        NSLog(@"%@", response);
        
        self.mapString.lat2 = poit.location.latitude;
        self.mapString.lng2 = poit.location.longitude;
        [self annotationStup:self.mapString];
        
        
        
    
    
//    POIAnnotation *poiAnnotion = [[POIAnnotation alloc]initWithPOI:poit];
////    将返回的结果标注到地图上
//    [self.mapView addAnnotation:poiAnnotion];
//    
//    if (poit != nil) {
//        
////        已这个为中心
//        self.mapView.centerCoordinate = poiAnnotion.coordinate;
//        
//        
//        
//    }
    
    
}
}

//标注的回调方法
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[AnimatedAnnotation class]]) {
        static NSString *poiIdentifier = @"reuse";
        AnimatedAnnotationView *annotationView = (AnimatedAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (annotationView == nil) {
            
           annotationView = [[AnimatedAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
            
            
            
            
        }
        
        annotationView.centerOffset = CGPointMake(0, -16);
//        annotationView.enabled = NO;
        annotationView.canShowCallout = YES;
//        annotationView.draggable = YES;//可以拖拽默认为no
        return annotationView;
        
        
        
        
        
    }
    return nil;
}



//动画数组的创建
- (void)animationArrayAdd {
    
    self.onWayAnimate = [NSMutableArray array];
    self.endAnimated = [NSMutableArray array];
    self.beginAnimated = [NSMutableArray array];
    
    
    for (NSInteger i = 1; i <= 9; i ++) {
        
        [self.onWayAnimate addObject:[UIImage imageNamed:[NSString stringWithFormat:@"car%ld", i]]];
         
    }
   
    for (NSInteger i = 1; i < 4; i ++) {
        [self.endAnimated addObject:[UIImage imageNamed:[NSString stringWithFormat:@"end%ld", i]]];
        
        
        
    }
    
    
    for (NSInteger i = 1; i < 4; i ++) {
        
        
        [self.beginAnimated addObject:[UIImage imageNamed:[NSString stringWithFormat:@"began%ld", i]]];
        
    }
    
    
    
}


- (void)poiHandel {
    
    
    
        NSLog(@"data%@",self.mapString.address);
            
        [self searchPoiByKeyword: self.mapString.address];
        
    
        
    
}

//创建标签
- (void)annotationStup:(MapStringData *)data {
    
    
    
    [self cclocationManmger];
    
    AnimatedAnnotation *annotation = [[AnimatedAnnotation alloc]initWithCoordinate:CLLocationCoordinate2DMake(data.lat2, data.lng2)];
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(data.lat2, data.lng2) animated:YES];
    
    NSLog(@"hanhan%f, %f", data.lat2, data.lng2);
    
        
        if ([data.image isEqualToString:@"a"]) {
            
            annotation.animatedImages = self.beginAnimated;
            
            
            
        } else if([data.image isEqualToString:@"b"]){
            
            annotation.animatedImages = self.onWayAnimate;
        } else {
            
            annotation.animatedImages = self.endAnimated;
            
            
        }

        
    
    annotation.subtitle = data.context;
    
    
    annotation.title = data.time;
    
    [self.mapView addAnnotation:annotation];
    

    
}


- (void)pointDistance {
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(self.myLat, self.myLng));
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(self.mapString.lat2, self.mapString.lng2));
    
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1, point2);
    
    NSLog(@"%f", distance);
    NSUserDefaults *dic = [NSUserDefaults standardUserDefaults];
    if (dic) {
        NSLog(@"🐎");
        if ([[dic objectForKey:@"languge"] isEqualToString:@"chaince"]) {
            
        
        NSString *stringDistance  = [NSString stringWithFormat:@"距离我还有:%0.2f 公里", (distance / 1000)];
        
        if (self.judge) {
            self.lableDistance.text = @"已经签收";
        } else {
            
            self.lableDistance.text = stringDistance;
            }
        
 
        
        } else {
            NSString *stringDistance  = [NSString stringWithFormat:@"Distance To Me Frome:%0.2f 公里", (distance / 1000)];
            
            if (self.judge) {
                self.lableDistance.text = @"Have to sign for";
            } else {
                
                self.lableDistance.text = stringDistance;
                
            }
        }
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
