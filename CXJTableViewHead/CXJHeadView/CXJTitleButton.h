//
//  CXJTitleButton.h
//  CXJTableViewHead
//
//  Created by 陈晓军 on 2020/1/10.
//  Copyright © 2020 陈晓军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXJTitleButton : UIButton

/**
 设置文字和颜色
 */
-(void)setTitle:(NSString *)title withColor:(UIColor *)color selectedColor:(UIColor *)selectedColor;


@end

NS_ASSUME_NONNULL_END
