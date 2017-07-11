//
//  History.h
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface History : NSObject
-(void)initHistoryData:(NSDictionary*)dic;
@property(nonatomic,strong)NSMutableArray *historyArray;
@property(nonatomic,copy)NSString *result;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Barcode;
@property(nonatomic,copy)NSString *Type;
@property(nonatomic,copy)NSString *Date;
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@end
