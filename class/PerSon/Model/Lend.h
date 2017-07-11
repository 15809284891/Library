//
//  Lend.h
//  图书管理
//
//  Created by lixue on 16/6/12.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Lend : NSObject
@property(nonatomic,copy)NSString *Barcode;
@property(nonatomic,assign)BOOL CanRenew;
@property(nonatomic,copy)NSString *Date;
@property(nonatomic,copy)NSString *Department;
@property(nonatomic,copy)NSString *Department_id;
@property(nonatomic)NSString *Library_id;//可能出问题
@property(nonatomic,copy)NSString *State;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@end
