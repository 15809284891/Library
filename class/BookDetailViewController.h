//
//  BookDetailViewController.h
//  图书管理
//
//  Created by lixue on 16/7/16.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookDetail;
@interface BookDetailViewController : UIViewController
@property(nonatomic,strong)id isHavebookdetail;
@property(nonatomic,copy)NSString *bookIdentifierType;
@property(nonatomic,copy)NSString *BookBarcode;
@end
