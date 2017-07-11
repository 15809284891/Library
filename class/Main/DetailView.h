//
//  DetailView.h
//  图书管理
//
//  Created by lixue on 16/4/20.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@class DetailModel;
@class YYLabel;
@interface DetailView :UIWebView
@property(nonatomic,strong) DetailModel *detail;

@end
