//
//  BookSortTool.m
//  图书管理
//
//  Created by snow on 2017/5/19.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "BookSortTool.h"
#import "SearchType.h"
@interface BookSortTool()
{
    UIImageView *_bacV;
    UIButton *_indicator;
    NSString *_type;
}
@end
@implementation BookSortTool
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bacV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, self.frame.size.height)];
        _bacV.image = [UIImage imageNamed:@"mainCellBackground"];
        [self insertSubview:_bacV atIndex:0];
        
    }
    return self;
}
-(BookSortTool *)creatViewWithViewTitle:(NSString *)title withSubViews:(NSArray *)subViews cols:(NSInteger)cols{
    _type = title;
    CGFloat marginX= 10;
    CGFloat marginY = 5;
    CGFloat width = (screenW-10*(cols+1))/cols;
    CGFloat heigh = width*0.4;
    int lastRow = 0;
    int i = 0;
    for (i=0; i<subViews.count; i++) {
        int row = i/cols;
        int col = i%cols;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(marginX*(col+1)+(width*col), (marginY*(row+1)+(heigh*row)),width, heigh);
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        [button setTitle:subViews[i] forState:UIControlStateNormal];
        [button setTitleColor:LXbarTintColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:LXbarTintColor forState:UIControlStateSelected];
        [self addSubview:button];
        lastRow = row;
        if (i == 0) {
            button.selected = YES;
            _indicator = button;
        }
    }
    self.frame= CGRectMake(0, 0, screenW, (lastRow+2)*marginY+(lastRow+1)*heigh);
    _bacV.frame = CGRectMake(0, 0, screenW, self.frame.size.height);
    return self;
}
-(void)click:(UIButton *)btn{
    _indicator.selected = NO;
    btn.selected= !btn.selected;
    _indicator = btn;
    SearchType *searchType = [SearchType shareInstance];
    NSDictionary *dic = searchType.titles_types[_type];
    NSInteger index = [dic[@"chainese"] indexOfObject:btn.titleLabel.text];
    searchType.paramasDic[_type] = [dic[@"number"] objectAtIndex:index];
    
}
@end
