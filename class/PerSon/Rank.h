//
//  Rank.h
//  图书管理
//
//  Created by shixihao on 16/7/19.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Rank : NSObject
@property (nonatomic,copy)NSString *BookRank;
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *Sort;
@property (nonatomic,copy)NSString *BorNum;
@property (nonatomic,copy)NSString *LibarayId;
@property (nonatomic,copy)NSMutableArray *rankArray;
/*cell高度*/
@property (nonatomic,assign,readonly)CGFloat cellHeight;
@end
