//
//  MJRefresh.h
//  Pods
//
//  Created by 李春城 on 15/11/28.
//
//

#import "MJRefresh.h"
#import "AKRNWaterfallCell.h"
@interface RNMJHeader : MJRefreshHeader

@property (nonatomic, strong) AKRNWaterfallCell *headerIdle;
@property (nonatomic, strong) AKRNWaterfallCell *headerPulling;
@property (nonatomic, strong) AKRNWaterfallCell *headerRefreshing;

@end
