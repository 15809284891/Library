
//
//  CirculateViewController.m
//  图书管理
//
//  Created by shixihao on 16/8/13.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "CirculateViewController.h"
#import "CirculateInfoView.h"
#import "CirculationInfo.h"
@interface CirculateViewController ()

@end

@implementation CirculateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.circulateArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CirculateInfoView *cell = [CirculateInfoView addCirculateCell:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    cell.circulationInfo = _circulateArray[indexPath.row];
    return cell;
}



@end
