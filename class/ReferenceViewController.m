//
//  ReferenceViewController.m
//  图书管理
//
//  Created by shixihao on 16/8/13.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "ReferenceViewController.h"
#import "RerferCell.h"
#import "ReferBooks.h"
@interface ReferenceViewController ()

@end

@implementation ReferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.referArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReferBooks *referBook  = self.referArray[indexPath.row];
    RerferCell *cell=[RerferCell addRerferCell:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    cell.referBook = referBook;
    return cell;
}


@end
