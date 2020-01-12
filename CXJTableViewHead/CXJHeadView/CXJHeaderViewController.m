//
//  CXJHeaderViewController.m
//  CXJTableViewHead
//
//  Created by 陈晓军 on 2020/1/9.
//  Copyright © 2020 陈晓军. All rights reserved.
//

#import "CXJHeaderViewController.h"
#import "CXJTableView.h"
#import "CXJTitleView.h"
#import "CXJContentView.h"
#import "CXJTableViewCell.h"
#import "CXJContentCollectionCell.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width

//标题控件高度
static CGFloat const _TitleViewHeight = 40;
static NSString *const _CollectionViewCellReuseID = @"_CollectionViewCellReuseID";
static NSString *const _TableViewCellReuseID = @"_TableViewReuseID";

@interface CXJHeaderViewController ()<UITableViewDelegate,UITableViewDataSource,CXJTitleViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) CXJTableView  *tableView;

@property(nonatomic,weak) UIView *headerView;

@property(nonatomic,strong) CXJTitleView *titleView;

@property(nonatomic,strong) CXJContentView *contentView;

@property(nonatomic,assign,getter=isShowHeaderView) BOOL showHeaderView;

@end

@implementation CXJHeaderViewController

#pragma mark - 视图懒加载
//标题视图
-(CXJTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[CXJTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, _TitleViewHeight)];
        _titleView.delegate = self;
    }
    return _titleView;
}

//内容视图
-(CXJContentView *)contentView
{
    if (!_contentView) {
        CGFloat viewH = [self tableView:nil heightForRowAtIndexPath:nil];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kScreenW, viewH);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _contentView = [[CXJContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, viewH) collectionViewLayout:layout];
        _contentView.dataSource = self;
        _contentView.delegate = self;
        _contentView.contentInset = UIEdgeInsetsZero;
        _contentView.pagingEnabled = YES;
        _contentView.bounces = NO;
        [_contentView registerClass:[CXJContentCollectionCell class] forCellWithReuseIdentifier:_CollectionViewCellReuseID];
    }
    return _contentView;
}

//滚动视图
-(CXJTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[CXJTableView alloc] initWithFrame:self.view.bounds];
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.estimatedRowHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[CXJTableViewCell class] forCellReuseIdentifier:_TableViewCellReuseID];
    }
    return _tableView;
}

#pragma mark - 处理逻辑
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

/**
 显示视图
 */
-(void)makeKeyAndVisible
{
    //添加tableView
    [self.view addSubview:self.tableView];
    
    [self addHeaderView];
    
    [self addChildViewControllersAndTitles];
}







#pragma mark - 添加子View
/**
 添加头部视图
 */
-(void)addHeaderView{
    UIView *headerView = [self.dataSource headerViewForHeaderVC:self];
    if (!headerView) return;

    if (self.headerView) {
        [self.headerView removeFromSuperview];
    }
    //添加头部视图
    CGRect rect = CGRectMake(0, -headerView.frame.size.height, self.tableView.bounds.size.width, headerView.frame.size.height);
    headerView.frame = rect;
    [self.tableView addSubview:self.headerView = headerView];
}

/**
 添加子控制器和标题
 */
-(void)addChildViewControllersAndTitles{
    
    NSArray<UIViewController *> *controllers = [self.dataSource childViewControllersForHeaderVC:self];
    NSArray<NSString *> *titles = [self.dataSource childViewTitlesForHeaderVC:self];
    
    if (controllers.count <= 0 || titles.count != controllers.count) return;
    
    //添加标题视图
    [self.titleView addTitles:titles withColor:nil selectedColor:nil];


    //添加子控制器
    for (UIViewController *vc in controllers) {
        [self addChildViewController:vc];
    }
    
    //添加内容视图
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIView *childView = self.childViewControllers[indexPath.item].view;
    CXJContentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"_CollectionViewCellReuseID" forIndexPath:indexPath];
    cell.cellView = childView;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger idx = scrollView.contentOffset.x / kScreenW;
    self.titleView.selectedIndex = idx;
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_TableViewCellReuseID forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.childView = self.contentView;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    return  screenH - [self safeAreaHeight] - _TitleViewHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.titleView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _TitleViewHeight;
}



#pragma mark - CXJTitleViewDelegate
- (void)titleView:(CXJTitleView *)titleView didSelectBtn:(UIButton *)btn withIndex:(NSInteger)index
{
    CGPoint offsetP = CGPointMake(index * kScreenW, 0);
    [self.contentView setContentOffset:offsetP animated:YES];
}



#pragma mark - UIScrollViewDelegate

//滚动触发
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = self.tableView.contentOffset;
    UIEdgeInsets inset = self.tableView.contentInset;
    CGFloat areaTop = [self safeAreaTop];
    
    //上拉
    if (offset.y > -areaTop && !self.isShowHeaderView) {
        self.tableView.contentOffset = CGPointMake(offset.x, -areaTop);
    }
   
    //处理下拉
    if (self.isShowHeaderView && inset.top > 0) {
        CGFloat downTop = offset.y + areaTop;
        CGFloat headerViewH = self.headerView.bounds.size.height;
        if (-headerViewH < -downTop ) {
            inset.top = ABS(downTop);
            if (ABS(downTop) > headerViewH ) {
                inset.top = headerViewH;
            }
            
            self.tableView.contentInset = inset;
        }
    }

 
   
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    UIEdgeInsets inset = self.tableView.contentInset;
    CGPoint offset = self.tableView.contentOffset;
    CGFloat areaTop = [self safeAreaTop];
    CGFloat headerViewH = self.headerView.bounds.size.height;
    CGFloat halfTop = (areaTop + (headerViewH * 0.5));
    
    if ((!self.isShowHeaderView && offset.y <= -halfTop) || (self.isShowHeaderView && offset.y < -halfTop)) {
        inset.top = headerViewH;
        self.tableView.contentInset = inset;
        targetContentOffset->x = offset.x;
        targetContentOffset->y = -(headerViewH+areaTop);
        self.showHeaderView = YES;
        return;
    }
    
    if ((self.isShowHeaderView && offset.y >= -halfTop) || (!self.isShowHeaderView && offset.y > -halfTop)) {
        inset.top = 0;
        self.tableView.contentInset = inset;
        targetContentOffset->x = offset.x;
        targetContentOffset->y = -areaTop;
        self.showHeaderView = NO;
    }
}




#pragma mark - 其它


-(CGFloat)safeAreaTop{
    if (@available(iOS 11.0, *)) {
        return self.view.safeAreaInsets.top;
    } else {
        CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat navH = self.navigationController.navigationBar.frame.size.height;
        return statusH + navH;
    }
}

/**
 获取上下所有安全高度
 */
-(CGFloat)safeAreaHeight{
    
    if (@available(iOS 11.0, *)) {
        return (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom);
    } else {
        CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat navH = self.navigationController.navigationBar.frame.size.height;
        CGFloat barH = self.tabBarController.tabBar.bounds.size.height;
        return statusH + navH + barH;
    }
}
@end
