//
//  MapViewController.h
//  YTO Expressage
//
//  Created by dlios on 15-7-6.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "BaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface MapViewController : BaseViewController<AMapSearchDelegate, MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;




- (void)returnAction;


@end
