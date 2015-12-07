//
//  AKRNWaterfall.m
//  Pods
//
//  Created by 李春城 on 15/11/27.
//
//

#import "AKRNWaterfall.h"

#import "RCTConvert.h"
#import "RCTEventDispatcher.h"
#import "RCTUtils.h"
#import "UIView+React.h"
#import "AKRNCollectionView.h"
#import "AKRNWaterfallCell.h"
#import <MJRefresh/MJRefresh.h>

@interface AKRNWaterfall()
@property (nonatomic, strong) RCTEventDispatcher     *eventDispatcher;
@property (nonatomic) NSMutableArray* numbers;
@property (nonatomic) NSMutableArray* numberWidths;
@property (nonatomic) NSMutableArray* numberHeights;
@property (nonatomic, strong) AKRNCollectionView *waterfallView;

@end

@implementation AKRNWaterfall
{
    NSMutableArray *_cells;
    NSMutableDictionary *_mjviews;
    
}

- (void)createCollectionViewWithFrame:(NSDictionary *)bounds{
    
    if (_waterfallView == nil) {
        CGRect frame = CGRectMake([bounds[@"x"] integerValue], [bounds[@"y"] integerValue], [bounds[@"width"] integerValue], [bounds[@"height"] integerValue]);
        _waterfallView = [[AKRNCollectionView alloc] initWithEventDispatcher:_eventDispatcher reactTag:self.reactTag withFrame:frame];
        _waterfallView.backgroundColor = [UIColor clearColor];
        // 打开下接刷新
        [_waterfallView addPullRefreshForRnCollectionView:_mjviews];
        [self addSubview:_waterfallView];
    }

}

- (id)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
  RCTAssertParam(eventDispatcher);
    
  if ((self = [super initWithFrame:CGRectZero])) {
      _eventDispatcher = eventDispatcher;
      _cells = [NSMutableArray array];
      _mjviews = [[NSMutableDictionary alloc] init];
  }
  return self;
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex{
    // just add them to registry
    if ([subview isKindOfClass:[AKRNWaterfallCell class]]){
        AKRNWaterfallCell *waterfallCell = (AKRNWaterfallCell *)subview;
        if ([waterfallCell.cellType isEqual:@"cell"]) {
            [_cells addObject:waterfallCell];
            if (_cells.count == self.cellCount) {
                [self createCollectionViewWithFrame:self.box];
                [self.waterfallView setCells:_cells];
            }
        }else{
            [_mjviews setObject:waterfallCell forKey:waterfallCell.cellType];
        }
    }
}
// 移除所有的subview，交由collectionview管理避免crash
- (NSArray *)reactSubviews
{
    return nil;
}

- (void)removeReactSubview:(UIView *)subview
{
    
    if (_cells.count <= 0) {
        RCTLogError(@"Attempting to remove invalid RCT subview of AKRNWaterfall");
        return;
    }
    [_cells removeObject:subview];
}

//- (UIView *)reactSuperview
//{
//    RCTAssert(self.superview != nil, @"put reactNavSuperviewLink back");
//    return self.superview ? self.superview : NULL;
//}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_waterfallView.collectionView reloadData];
//    [self layoutIfNeeded];
}


RCT_NOT_IMPLEMENTED(-initWithFrame:(CGRect)frame)
RCT_NOT_IMPLEMENTED(-initWithCoder:(NSCoder *)aDecoder)

- (void)headerEndRefreshing{
    [_waterfallView.collectionView.mj_header endRefreshing];
}
- (void)footerEndRefreshing{
    [_waterfallView.collectionView.mj_footer endRefreshing];
}
- (void)footerEndRefreshingNoMoreData:(float)bottom{
    [_waterfallView.collectionView.mj_footer endRefreshingWithNoMoreData];
    _waterfallView.collectionView.contentInset = UIEdgeInsetsMake(0, 0, bottom, 0);
}

@end
