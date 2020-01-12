//
//  CXJTableViewCell.m
//  CXJTableViewHead
//
//  Created by 陈晓军 on 2020/1/11.
//  Copyright © 2020 陈晓军. All rights reserved.
//

#import "CXJTableViewCell.h"

@implementation CXJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setChildView:(UIView *)childView{
    if (_childView) {
        [_childView removeFromSuperview];
    }
    
    _childView = childView;
    //childView.frame = self.contentView.bounds;
    [self.contentView addSubview:childView];
    
}

@end
