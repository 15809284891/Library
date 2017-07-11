//
//  FirstCell.m
//  图书管理
//
//  Created by lixue on 16/7/17.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前

#define MAS_SHORTHAND_GLOBALS//添加了该宏，就可以用equlto了，会自动包装

#import "Masonry.h"
#import "BasicInfoCell.h"
#import "BookDetail.h"
#import "CirculationInfo.h"
@interface BasicInfoCell (){
    NSArray *tipArray;
}

@property(nonatomic)UILabel *Tilte;
@property(nonatomic)UILabel *SortLb;//索书号
@property(nonatomic)UILabel *AuthorLb;//作者
@property(nonatomic)UILabel *AvaliableLb;  //可借数量，两次
@property(nonatomic)UILabel *RentTimesLb;//借阅次数
@property(nonatomic)UILabel *FavTimesLb;//收藏次数
@property(nonatomic)UILabel *BrowseTimesLb;//浏览次数
@property(nonatomic)UILabel *Total;//藏书数量，两次
@property(nonatomic)UILabel *Subject;//主题分类
@property(nonatomic)UILabel *Pub;//出版社
@property(nonatomic)NSArray *contentArray;

@end
@implementation BasicInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}
-(void)setBookDetail:(BookDetail *)bookDetail{
    NSArray *  tipArray = @[@"索书号:",@"作者:",@"可借数量:",@"借阅次数:",@"收藏次数:",@"浏览次数:",@"藏书数量",@"出版社:"];
    if (bookDetail.circulationInfoArray.count == 0) {
        self.contentArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@""];
    }
    
    else{
        CirculationInfo *circulation = bookDetail.circulationInfoArray[0];
        self.contentArray = @[circulation.Sort,bookDetail.Author,[NSString stringWithFormat:@"%ld",bookDetail.Avaliable],[NSString stringWithFormat:@"%ld",bookDetail.RentTimes],[NSString stringWithFormat:@"%ld",bookDetail.FavTimes],[NSString stringWithFormat:@"%ld",bookDetail.BrowseTimes],[NSString stringWithFormat:@"%ld",bookDetail.Total],bookDetail.Pub];
    }
    
    CGFloat locationY= 10;
    for (int i=0; i<8; i++) {
        CGFloat locationX =5;
        CGFloat ContentlocationX =90;
        CGFloat Width = 80;
        UILabel *lable = [[UILabel alloc]init];
        lable.textColor = [UIColor darkGrayColor];
        lable.font = [UIFont systemFontOfSize:14.0];
        UILabel *contentLable = [[UILabel alloc]init];
        contentLable.textColor = [UIColor darkGrayColor];
        contentLable.font = [UIFont systemFontOfSize:14.0];
        if (i==4||i==6) {
            locationX = 160;
            ContentlocationX = 235;
            locationY = locationY-30;
        }
        if (i==0|| i==1||i==7) {
            Width = 300;
        }
        lable.text = tipArray[i];
        contentLable.text = self.contentArray[i];
        contentLable.font = [UIFont systemFontOfSize:15];
        lable.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:contentLable];
        [self.contentView addSubview:lable];
        lable.frame = CGRectMake(locationX, locationY, 80, 30);
        contentLable.frame = CGRectMake(ContentlocationX, locationY, Width, 30);
        locationY =  locationY+30;
        
    }


}
+(BasicInfoCell *)addBasicInfoCell:(UITableView *)tableView{
    NSString *identity = @"basicInfoCell";
    BasicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[BasicInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    //为什么自定义的cell也要移除上面的子视图？因为lable的创建在这个方法里面，会调用好多次
    else{
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        
    }
    return cell;
}


@end
