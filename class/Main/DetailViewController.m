//
//  DetailViewController.m
//  图书管理
//
//  Created by lixue on 16/4/20.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"
#import "DetailModel.h"
#import "DetailModel.h"
#import "News.h"
#import <WebKit/WebKit.h>
@interface DetailViewController ()<WKNavigationDelegate,WKUIDelegate>
{
    WKUserContentController *_contetController;
    CGFloat _wkWebViewContentH;
}
@property(nonatomic,copy)NSString *TextInfo;
@property(nonatomic,weak) DetailView *detailView;
@property(nonatomic,strong)WKWebView *wkwebView;
@property(nonatomic,strong)UILabel *titleView;

@end

@implementation DetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"详情";
    self.automaticallyAdjustsScrollViewInsets  = NO;
    [self setupWKwebview];
    [GMDCircleLoader setOnView:self.view withTitle:@"loading" animated:YES];
    DetailModel *model = [DetailModel shareInstance];
    [model getDetailModelDataWithType:self.news.newsType withID:self.news.NewsID Block:^(DetailModel *detaiLModel, NSError *error) {
        #warning 必须切换到主线程，不然程序会崩溃
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self setTitleViewText:detaiLModel.Title];
//            [self setWebContentFrame];
            [_wkwebView loadHTMLString:detaiLModel.Passage baseURL:[NSURL URLWithString:@"http://api.xiyoumobile.com/xiyoulibv2/"]];
        });
    }];
}
-(void)setupWKwebview{
    WKWebViewConfiguration *wkConfig = [[WKWebViewConfiguration alloc]init];
    // 自适应屏幕宽度js
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 添加自适应屏幕宽度js调用的方法
    _contetController = [[WKUserContentController alloc] init];
    wkConfig.userContentController = _contetController;
    [_contetController addUserScript:wkUserScript];
    
    self.wkwebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, screenW,screenH-64) configuration:wkConfig];
    self.wkwebView.navigationDelegate = self;
    self.wkwebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.wkwebView.scrollView.showsVerticalScrollIndicator= NO;
    self.wkwebView.UIDelegate = self;
    //侧滑返回上一页
    self.wkwebView.allowsBackForwardNavigationGestures = NO;
    [self.view addSubview:_wkwebView];
}
#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
     [GMDCircleLoader hideFromView:self.view animated:YES];
  }
////解决 wkWebView 中的链接点不了
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


@end
