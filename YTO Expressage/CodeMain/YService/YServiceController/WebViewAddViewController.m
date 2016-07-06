//
//  WebViewAddViewController.m
//  YTO Expressage
//
//  Created by dlios on 15-7-13.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "WebViewAddViewController.h"

@interface WebViewAddViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *web;

//@property (nonatomic,strong) UIActivityIndicatorView *activity;



@end

@implementation WebViewAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationString];
    UIBarButtonItem *baclk = [[UIBarButtonItem alloc]init];
    baclk.title = @"返回";
    self.navigationItem.backBarButtonItem = baclk;
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200.0 / 255 green:80.0 / 255 blue:200.0 / 255 alpha:0.8];
    self.view.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:YES];
    self.web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.web.delegate = self;
    self.web.scalesPageToFit = YES;
    
    [self.view addSubview:self.web];
    
    [self loadWebView];
    
    // Do any additional setup after loading the view.
}

- (void)loadWebView{
    
    NSURL *url = [NSURL URLWithString:self.webURL];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    [self.web loadRequest:requst];
    
    
    
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
   
    
    [self animationAddView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
        
    [self removeLoadView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"圆通温馨提示" message:@"当前网络不好" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
    
}



- (void)navigationString{
    
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 40)];
    
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont boldSystemFontOfSize:17];
    title1.textColor = [UIColor whiteColor];
    title1.text = self.key;
    //    title.backgroundColor = [UIColor whiteColor];
    //    title.layer.cornerRadius = 0.3 * Screen_Height;
    
    self.navigationItem.titleView =  title1;
    
    
    
    
    
}


- (void)dealloc
{
    self.web.delegate = nil;
    self.web = nil;
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
