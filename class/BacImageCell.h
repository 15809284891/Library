//
//  BacImageCell.h
//  图书管理
//
//  Created by shixihao on 16/7/21.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookDetail;
@interface BacImageCell : UIView
@property(nonatomic,strong)UIImageView *imageBacV;
@property(nonatomic,strong)UIImageView *bookImageV;
@property(nonatomic,strong)UILabel *TitleLb;
-(void)initContent:(BookDetail *)bookdetail;
@end
