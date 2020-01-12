//
//  ViewController.m
//  CXJTableViewHead
//
//  Created by 陈晓军 on 2020/1/9.
//  Copyright © 2020 陈晓军. All rights reserved.
//  

#import "ViewController.h"
@interface ViewController ()<CXJHeaderViewDelegate>


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = self;
    self.title = @"演示";
    //展示
    [self makeKeyAndVisible];
  
}

#pragma mark - 实现数据源代理方法
//添加顶部视图
-(UIView *)headerViewForHeaderVC:(CXJHeaderViewController *)headerVC
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    headView.backgroundColor = [UIColor redColor];
    return headView;
}

//添加子控制器
-(NSArray<UIViewController *> *)childViewControllersForHeaderVC:(CXJHeaderViewController *)headerVC
{
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor yellowColor];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor blueColor];
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor purpleColor];

    return @[vc1,vc2,vc3];
}

//添加标题
-(NSArray<NSString *> *)childViewTitlesForHeaderVC:(CXJHeaderViewController *)headerVC
{
    return @[@"标题1",@"标题2",@"标题3"];
}




@end
