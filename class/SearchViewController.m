//  SearchViewController.m
//  图书管理
//
//  Created by shixihao on 16/7/23.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "SearchViewController.h"
#import "BookData.h"
#import "SearchCell.h"
#import "BookDetailViewController.h"
#import "SerachTypeTable.h"
#import "SearchType.h"
@interface SearchViewController ()<UISearchResultsUpdating,UISearchBarDelegate>

{
    UISearchBar *_myBar;
    UITableViewController *_tableVc;
    UISearchController *_searchVc;
    NSString *_searchText;
    SerachTypeTable *_typeTable;
}
@property (nonatomic,strong)NSMutableArray *resutlArray;
@end
@implementation SearchViewController
-(NSMutableArray *)resutlArray{
    if (!_resutlArray) {
        _resutlArray = [NSMutableArray array];
    }
    return _resutlArray;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    //该 bar 点击之后 push 到 SearchVC；
    _myBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, screenW, 30)];
    _myBar.delegate = self;
    _myBar.placeholder = @"请输入书名";
    [self.view addSubview:_myBar];
    _typeTable = [[SerachTypeTable alloc]initWithFrame:CGRectMake(0, 64+40, self.view.mj_w, self.view.mj_h-64-44-40)];
    [self.view addSubview:_typeTable];
}
#pragma UISearchBarDelegate
//在点击 bar 时触发该方法，创建搜索控制器
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _tableVc = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    _tableVc.tableView.delegate = self;
    _tableVc.tableView.dataSource = self;
    _searchVc = [[UISearchController alloc]initWithSearchResultsController:_tableVc];
    _searchVc.searchBar.placeholder = @"请输入作者";
    _searchVc.delegate = self;
    _searchVc.view.backgroundColor = [UIColor whiteColor];
    _searchVc.searchResultsUpdater = self;
    _searchVc.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:_searchVc animated:YES completion:^{
        self.view.hidden = YES;
        _myBar.hidden = YES;
    }];
    
}

#pragma tableView-datasource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchCell *cell = [SearchCell addSearchCell:tableView];
    cell.bookData = _resutlArray[indexPath.row];
    return cell ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resutlArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma tableView - delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BookData *book  = _resutlArray[indexPath.row];
    return book.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookData *book = _resutlArray[indexPath.row];
    BookDetailViewController *bookDeatilVc = [[BookDetailViewController alloc]init];
    bookDeatilVc.bookIdentifierType = @"id";
    bookDeatilVc.BookBarcode = book.bookID;
    [_searchVc dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController pushViewController:bookDeatilVc animated:YES];
}
#pragma UISearchResultsUpdating
//当搜索框中值发生改变时候，会调用这个方法
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    _searchText = searchController.searchBar.text;
    [self requestResult];
}
-(void)requestResult{
    NSString *str = [NSString urlStringWithpath:BOOK_SEARCH paramas:nil];
    SearchType *searchType = [SearchType shareInstance];
    NSMutableDictionary *paramas = [searchType.paramasDic mutableCopy];
    paramas[@"keyword"] = _searchText;
    [GMDCircleLoader setOnView:_tableVc.tableView withTitle:@"loading" animated:YES];
    [[LXHTTPHelperClass shareInstanse]LXPOST:str
                                  parameters:paramas
                                       Value:^(id responseObject) {
                                           [GMDCircleLoader hideFromView:_tableVc.tableView animated:YES];
                                           id isHaveRecord =responseObject[@"Detail"];
                                           if (![isHaveRecord isKindOfClass:[NSString class]]) {
                                               self.resutlArray = [BookData objectArrayWithKeyValuesArray:responseObject[@"Detail"][@"BookData"]];
                                               [_tableVc.tableView reloadData];

                                           }
                                       } Error:^(NSError *error) {
                                           
                                       }];
}

#pragma UISearchControllerDelegate
//在搜索控制器要消失的时候，让之前的显示
- (void)didDismissSearchController:(UISearchController *)searchController{
    _myBar.hidden = NO;
    self.view.hidden = NO;
}
//在返回的时候让 bar 显示
-(void)viewWillAppear:(BOOL)animated{
    _myBar.hidden = NO;
    self.view.hidden = NO;
}
@end

