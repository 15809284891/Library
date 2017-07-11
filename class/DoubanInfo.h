//
//  DoubanInfo.h
//  图书管理
//
//  Created by shixihao on 16/7/20.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BookImage;
@interface DoubanInfo : NSObject
@property (nonatomic,copy)NSString *Alt_Title;
@property (nonatomic,copy)NSString *Author_Info;
@property (nonatomic,copy)NSString *Binding;
@property (nonatomic,assign)NSInteger ISBN10;
@property (nonatomic,assign)NSInteger ISBN13;
@property (nonatomic,strong)BookImage *Images;
@property (nonatomic,copy)NSString *Pages;
@property (nonatomic,copy)NSString *Price;
@property (nonatomic,copy)NSString *PubDate;
@property (nonatomic,copy)NSString *Publisher;
@property (nonatomic,copy)NSString *Summary;
@property (nonatomic,copy)NSString *Title;
@end
