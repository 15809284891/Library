//
//  AnnounceOrNews.h
//  图书管理
//
//  Created by shixihao on 16/8/13.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *NewsID;
@property (nonatomic,copy)NSString *newsType;
@property (nonatomic,assign,readonly)CGFloat cellHeight;
@end
