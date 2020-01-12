//
//  CXJTitleButton.m
//  CXJTableViewHead
//
//  Created by 陈晓军 on 2020/1/10.
//  Copyright © 2020 陈晓军. All rights reserved.
//

#import "CXJTitleButton.h"

@implementation CXJTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(void)setTitle:(NSString *)title withColor:(UIColor *)color selectedColor:(nonnull UIColor *)selectedColor
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:selectedColor forState:UIControlStateSelected];
    
}


-(void)setHighlighted:(BOOL)highlighted{}

@end
