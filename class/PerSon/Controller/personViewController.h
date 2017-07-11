//
//  personViewController.h
//  图书管理
//
//  Created by lixue on 16/4/17.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonView;
extern NSString *const PINotifition;
@interface personViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)PersonView *personView;

@end
