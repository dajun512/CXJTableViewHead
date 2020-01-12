//
//  CXJHeaderViewController.h
//  CXJTableViewHead
//
//  Created by 陈晓军 on 2020/1/9.
//  Copyright © 2020 陈晓军. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXJHeaderViewController;
NS_ASSUME_NONNULL_BEGIN

//设置数据源
@protocol CXJHeaderViewDelegate <NSObject>

@required
//添加顶部视图
-(UIView *)headerViewForHeaderVC:(CXJHeaderViewController *)headerVC;

//添加子控制器
-(NSArray<UIViewController *> *)childViewControllersForHeaderVC:(CXJHeaderViewController *)headerVC;

//添加标题
-(NSArray<NSString *> *)childViewTitlesForHeaderVC:(CXJHeaderViewController *)headerVC;


@end

@interface CXJHeaderViewController : UIViewController

@property(nonatomic,weak) id<CXJHeaderViewDelegate> dataSource;

//显示视图
-(void)makeKeyAndVisible;

@end

NS_ASSUME_NONNULL_END
