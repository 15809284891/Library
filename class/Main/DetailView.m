//
//  DetailView.m
//  图书管理
//
//  Created by lixue on 16/4/20.
//  Copyright © 2016年 lixue. All rights reserved.
//
#import "DetailView.h"
#import "DetailModel.h"
@interface DetailView()<UIWebViewDelegate>
@property (nonatomic,weak)UILabel *titleLb;
@property (nonatomic,weak)UIWebView *webView;
@property (nonatomic,weak)UILabel *DateLb;
@property (nonatomic,weak)UILabel *PublisherLb;
@property (nonatomic,weak)UILabel *DateTipLb;
@property (nonatomic,weak)UILabel *PublisherTipLb;
@property (nonatomic,strong)UIView *webBrowserView;
@end
@implementation DetailView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initContentView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initContentView];
    }
    return self;
}
-(void)initContentView{
    self.scalesPageToFit = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.webBrowserView = self.scrollView.subviews[0];
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.font = [UIFont systemFontOfSize:20];
    titleLb.numberOfLines = 0;
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.lineBreakMode = NSLineBreakByCharWrapping;
    [self.scrollView addSubview:titleLb];
    self.titleLb = titleLb;
    
}
-(void)setDetail:(DetailModel *)detail{
    _detail = detail;
    NSLog(@"%@",detail.Passage);
    [self loadHTMLString:detail.Passage baseURL:[NSURL URLWithString:@"http://api.xiyoumobile.com/news/UploadFile/"]];
    self.titleLb.text = _detail.Title;
    self.PublisherLb.text = _detail.Publisher;
    self.DateLb.text = _detail.Date;
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLb.frame = CGRectMake(0, 0, 375, 80);
    CGRect frame = self.webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(_titleLb.frame);
    self.webBrowserView.frame = frame;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 667-64)];
        webView.scalesPageToFit = YES;
        [webView loadRequest:request];
        [self addSubview:webView];
        return NO;
    }
    return YES;
}
@end
