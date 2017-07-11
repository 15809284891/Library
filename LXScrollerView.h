//
//  LXScrollerView.h
//  LXSrollerView
//
//  Created by shixihao on 16/7/26.
//  Copyright © 2016年 shixihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXScrollerView : UIView<UIScrollViewDelegate>
@property(nonatomic)UIScrollView *scrollerView;
@property(nonatomic)UIPageControl *pageControl;
@property(nonatomic)NSTimer *timer;
@property(nonatomic)NSArray *ImageArray;
-(void)initWithMyScrollerView:(NSArray *)ImageArray;
@end
