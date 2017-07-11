//
//  DetailViewController.h
//  图书管理
//
//  Created by lixue on 16/4/20.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
@class News;
@interface DetailViewController : UIViewController
@property(nonatomic,strong)News *news;
@end
