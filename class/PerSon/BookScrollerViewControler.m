//
//  BookScrollerViewControler.m
//  图书管理
//
//  Created by shixihao on 16/8/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "BookScrollerViewControler.h"
#import "FavoriteView.h"
@interface BookScrollerViewControler()
@property (nonatomic,weak)UIScrollView *scrollerView;
/**可见的控件*/
@property (nonatomic,strong)NSMutableSet *visiblaImageViews;
/**缓冲池中可用的*/
@property (nonatomic,strong)NSMutableSet *reusedImageViews;
@end
@implementation BookScrollerViewControler
//-(void)viewDidLoad{
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self setupScrollerView];
//}
//-(void)setupScrollerView{
//    UIScrollView *scrolleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height-64)];
//    scrolleView.pagingEnabled = YES;
//    scrolleView.delegate = self;
//    scrolleView.contentSize = CGSizeMake(self.FavoriteArray.count*self.view.frame.size.width,0);
//    scrolleView.scrollEnabled = YES;
//    scrolleView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:scrolleView];
//    self.scrollerView = scrolleView;
//    [self setupFavoriteViews];
//}
//-(void)setupFavoriteViews{
////   for (int i = 0; i<self.FavoriteArray.count; i++) {
//       FavoriteView *favoriteView = [[FavoriteView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
//       favoriteView.favorite = self.FavoriteArray[i];
//       favoriteView.backgroundColor = [UIColor clearColor];
//       [self.scrollerView addSubview:favoriteView];
//
//    
////}
//}
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"------");
//}
@end

