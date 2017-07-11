//
//  BookData.h
//  图书管理
//
//  Created by shixihao on 16/7/23.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookData : NSObject
@property(nonatomic,copy)NSString *Author;
@property(nonatomic,copy)NSString *bookID;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Total;
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@property(nonatomic,strong)NSMutableArray *bookDataArray;;
-(void)loadSearchBookData:(NSDictionary*)dic;
@end
