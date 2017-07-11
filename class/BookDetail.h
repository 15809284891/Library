//
//  BookDetail.h
//  图书管理
//
//  Created by lixue on 16/7/16.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DoubanInfo;
@interface BookDetail : NSObject
@property(nonatomic,copy)NSString *Author;
@property(nonatomic,assign)NSInteger Avaliable;
@property(nonatomic,assign)NSInteger BrowseTimes;
@property(nonatomic,assign)NSInteger FavTimes;
@property(nonatomic,copy)NSString *Form;
@property(nonatomic,copy)NSString *BookID;
@property(nonatomic,assign)NSInteger ISBN;
@property(nonatomic,copy)NSString *Pub;
@property(nonatomic,assign)NSInteger RentTimes;
@property(nonatomic,copy)NSString *SecondTitle;
@property(nonatomic,assign)NSInteger Sort;
@property(nonatomic,copy)NSString *Subject;
@property(nonatomic,copy)NSString *Summary;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,assign)NSInteger Total;
@property(nonatomic,strong)NSMutableArray *circulationInfoArray;
@property(nonatomic,strong)NSMutableArray *ReferBooksArray;
@property(nonatomic,strong)NSMutableArray *bookInfoArray;
@property(nonatomic,strong)DoubanInfo *doubanInfo;
-(void)loadBookData:(NSDictionary *)dic;
@end
