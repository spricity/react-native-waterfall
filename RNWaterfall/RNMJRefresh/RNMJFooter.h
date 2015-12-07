//
//  MJRefresh.h
//  Pods
//
//  Created by 李春城 on 15/11/28.
//
//

#import "MJRefreshBackFooter.h"
#import "AKRNWaterfallCell.h"
@interface RNMJFooter : MJRefreshBackFooter

@property (nonatomic, strong) AKRNWaterfallCell *footerIdle;
@property (nonatomic, strong) AKRNWaterfallCell *footerPulling;
@property (nonatomic, strong) AKRNWaterfallCell *footerRefreshing;
@property (nonatomic, strong) AKRNWaterfallCell *footerNoMoreData;

@end
