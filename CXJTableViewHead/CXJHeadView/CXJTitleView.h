//
//  CXJTitleView.h
//  CXJTableViewHead
//
//  Created by 陈晓军 on 2020/1/9.
//  Copyright © 2020 陈晓军. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXJTitleView;
NS_ASSUME_NONNULL_BEGIN

@protocol CXJTitleViewDelegate <NSObject>

/**
 选择按钮后回调
 */
- (void)titleView:(CXJTitleView *)titleView didSelectBtn:(UIButton *)btn withIndex:(NSInteger)index;

@end


@interface CXJTitleView : UIView

@property(nonatomic,weak) id<CXJTitleViewDelegate> delegate;

//设置选中的按钮下标
@property(nonatomic,assign) NSInteger selectedIndex;

//添加标题
-(void)addTitles:(NSArray<NSString *> *)titles withColor:(nullable UIColor *)color selectedColor:(nullable UIColor *)selectedColor;


@end

NS_ASSUME_NONNULL_END
