//
//  DetailModel.h
//  图书管理
//
//  Created by lixue on 16/4/23.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailModel : NSObject<NSCoding>
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *Publisher;
@property (nonatomic,copy)NSString *Date;
@property (nonatomic,copy)NSString *Passage;
@property (nonatomic,assign,readonly)CGFloat titleHeight;
+(DetailModel *)shareInstance;
-(void)getDetailModelDataWithType:(NSString *)type withID:(NSString*)ID Block:(void (^)(DetailModel *detaiLModel, NSError *error))block;
@end
