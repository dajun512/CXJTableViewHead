//
//  CXJContentCollectionCell.m
//  CXJTableViewHead
//
//  Created by 陈晓军 on 2020/1/11.
//  Copyright © 2020 陈晓军. All rights reserved.
//

#import "CXJContentCollectionCell.h"

@implementation CXJContentCollectionCell


-(void)setCellView:(UIView *)cellView
{
    if (_cellView) {
        [_cellView removeFromSuperview];
    }
    _cellView = cellView;
    //cellView.frame = self.contentView.bounds;
    [self.contentView addSubview:cellView];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
   
}

@end
