//
//  LXScrollerView.m
//  LXSrollerView
//
//  Created by shixihao on 16/7/26.
//  Copyright © 2016年 shixihao. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import"Masonry.h"
#import "LXScrollerView.h"

@implementation LXScrollerView

-(void)initWithMyScrollerView:(NSArray *)ImageArray{
    self.ImageArray = ImageArray;
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.scrollerView.contentSize = CGSizeMake(ImageArray.count*self.bounds.size.width,0);
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.scrollEnabled = YES;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollerView];
    self.pageControl = [[UIPageControl alloc]init];
    [self addSubview:self.pageControl];
    for (int i=0; i<ImageArray.count; i++) {
        UIImageView *tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollerView.bounds.size.width*i, 0, self.scrollerView.bounds.size.width, self.scrollerView.bounds.size.height)];
        tempImage.image = [UIImage imageNamed:ImageArray[i]];
        [self.scrollerView addSubview:tempImage];
    }
    [self.pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(10);
        make.bottom.equalTo(self.scrollerView.bottom).offset(-10);
        make.centerX.equalTo(self.scrollerView.centerX);
    }];
    self.pageControl.pageIndicatorTintColor  = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor =[UIColor whiteColor];
    self.pageControl.numberOfPages = ImageArray.count;
    self.scrollerView.delegate = self;
    self.scrollerView.alwaysBounceVertical = NO;
    [self addTimer];
}
-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(ImageRepeat) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)ImageRepeat{
    NSInteger page = self.pageControl.currentPage;
    if (page == self.ImageArray.count - 1) {
        page = 0;
    }else
        page++;
    self.scrollerView.contentOffset = CGPointMake(page*(self.scrollerView.bounds.size.width), 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = fabs(self.scrollerView.contentOffset.x)/(self.scrollerView.bounds.size.width);
    [self.pageControl setCurrentPage:index];
}
@end
