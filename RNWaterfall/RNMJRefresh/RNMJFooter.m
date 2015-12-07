//
//  MJRefresh.m
//  Pods
//
//  Created by 李春城 on 15/11/28.
//
//

#import "RNMJFooter.h"

@implementation RNMJFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];

    // 设置控件的高度
    self.mj_h = 50;
}
//
#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.footerIdle.frame = self.bounds;
    self.footerPulling.frame = self.bounds;
    self.footerRefreshing.frame = self.bounds;
    self.footerNoMoreData.frame = self.bounds;
}
//
#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.footerIdle.hidden = NO;
            self.footerPulling.hidden = YES;
            self.footerRefreshing.hidden = YES;
            self.footerNoMoreData.hidden = YES;
            break;
        case MJRefreshStatePulling:
            self.footerIdle.hidden = YES;
            self.footerPulling.hidden = NO;
            self.footerRefreshing.hidden = YES;
            self.footerNoMoreData.hidden = YES;
            break;
        case MJRefreshStateRefreshing:
            self.footerIdle.hidden = YES;
            self.footerPulling.hidden = YES;
            self.footerRefreshing.hidden = NO;
            self.footerNoMoreData.hidden = YES;
            break;
        case MJRefreshStateNoMoreData:
            self.footerIdle.hidden = YES;
            self.footerPulling.hidden = YES;
            self.footerRefreshing.hidden = YES;
            self.footerNoMoreData.hidden = NO;
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}


@end
