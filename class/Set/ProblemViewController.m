//
//  ProblemViewController.m
//  图书管理
//
//  Created by shixihao on 16/7/22.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "ProblemViewController.h"
#import "Problem.h"
#import "ProblemCell.h"
@interface ProblemViewController ()
@property(nonatomic)UITableView *tableView;
@property(nonatomic)NSArray *problemArray;
@end

@implementation ProblemViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.title = @"常见问题";  //设置标题
        Problem * problem = [[Problem alloc]init];
        [problem loadData];
        self.problemArray = problem.problemArray;

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    self.view.backgroundColor = LXViewBacColor;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProblemCell *cell = [ProblemCell addProblemCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.problem = self.problemArray[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.problemArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProblemCell *cell = (ProblemCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

@end
