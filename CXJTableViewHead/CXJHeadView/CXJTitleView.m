//
//  CXJTitleView.m
//  CXJTableViewHead
//
//  Created by 陈晓军 on 2020/1/9.
//  Copyright © 2020 陈晓军. All rights reserved.
//

#import "CXJTitleView.h"
#import "CXJTitleButton.h"

//按钮索引的标记值
static NSInteger const _ButtonIdxPrefix = 999;
//滑动空间的高度
static CGFloat const _BottomViewH = 2;
@interface CXJTitleView()

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) UIView *bottomView;

@property(nonatomic,strong) NSArray<UIButton *> *titleBtns;

@end

@implementation CXJTitleView
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor orangeColor];
    }
    return _bottomView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self initView];
}


/**
 初始化控件
 */
-(void)initView{
    
    //添加scrollView
    [self addSubview:self.scrollView];
    //添加底部滚动条
    [self addSubview:self.bottomView];
    
}

/**
 添加标题控件
 */
-(void)addTitles:(NSArray<NSString *> *)titles withColor:(nullable UIColor *)color selectedColor:(nullable UIColor *)selectedColor{
    if (!titles.count || ![titles.firstObject isKindOfClass:[NSString class]]) return;
    
    if (self.titleBtns.count) {
        [self.titleBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if (!color) {
        color = [UIColor darkGrayColor];
    }
    if (!selectedColor) {
        selectedColor = [UIColor orangeColor];
    }
    
    __block NSMutableArray *titleBtns = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CXJTitleButton *btn = [CXJTitleButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj withColor:color selectedColor:selectedColor];
        [btn addTarget:weakSelf action:@selector(handleWithClickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = _ButtonIdxPrefix+idx;
        
        [titleBtns addObject:btn];
        [weakSelf.scrollView addSubview:btn];
    }];
    
    self.titleBtns = titleBtns.copy;
    [titleBtns removeAllObjects];
    titleBtns = nil;
    
    //设置底部滚动条的初始frame
    CGFloat bottomViewW = self.bounds.size.width / self.titleBtns.count;
    CGFloat bottomViewY = self.bounds.size.height - _BottomViewH;
    self.bottomView.frame = CGRectMake(0, bottomViewY, bottomViewW, _BottomViewH);
    
    //设置默认选中
    [self setSelectedButton:[self.titleBtns firstObject] animate:NO];
    
}



//按钮点击事件
-(void)handleWithClickTitleButton:(UIButton *)button{
    self.selectedIndex = button.tag - _ButtonIdxPrefix;
}


//更新选中索引
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (!self.titleBtns.count || selectedIndex < 0 || selectedIndex >= self.titleBtns.count || self.titleBtns[selectedIndex].selected == YES) return;
    
    //取消选中
    self.titleBtns[_selectedIndex].selected = NO;
    
    //设置选中
    self.titleBtns[selectedIndex].selected = YES;
    [self setSelectedButton:self.titleBtns[selectedIndex] animate:YES];
    
    _selectedIndex = selectedIndex;
}


//动画到选中某个按钮
-(void)setSelectedButton:(UIButton *)button animate:(BOOL)animate{
    button.selected = YES;
    
    //下划线滚动到选中按钮
    CGRect rect = button.frame;
    rect.origin.y = rect.size.height - _BottomViewH;
    rect.size.height = _BottomViewH;
    if (button.bounds.size.width <= 0) {
        rect.origin.y = self.bounds.size.height - _BottomViewH;
        rect.size.width = self.bounds.size.width / self.titleBtns.count;
    }
    
    if (animate) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomView.frame = rect;
        }];
    }else{
        self.bottomView.frame = rect;
    }
    
    //代理回调
    if ([self.delegate respondsToSelector:@selector(titleView:didSelectBtn:withIndex:)]) {
        [self.delegate titleView:self didSelectBtn:button withIndex:button.tag - _ButtonIdxPrefix];
    }
}


-(void)dealloc{
    
    self.scrollView = nil;
    self.bottomView = nil;
    self.titleBtns = nil;
}


#pragma mark - 计算布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    __block CGFloat btnX = 0;
    __block CGFloat btnW = self.bounds.size.width / self.titleBtns.count;
    CGFloat btnH = self.bounds.size.height;
    [self.titleBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        btnX = idx * btnW;
        obj.frame = CGRectMake(btnX, 0, btnW, btnH);
        
    }];
    
    
}


@end
