//
//  AKRNWaterfallView.m
//  Pods
//
//  Created by 李春城 on 15/11/27.
//
//

#import "AKRNCollectionView.h"
#import "AKRNWaterfallCell.h"
#import <MJRefresh/MJRefresh.h>
#import "RNMJHeader.h"
#import "RNMJFooter.h"

@interface AKRNCollectionView()

@property (nonatomic, strong) RCTEventDispatcher     *eventDispatcher;

@end

@implementation AKRNCollectionView 
{
    NSArray *cells;
}

- (id)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher reactTag:(NSNumber *)reactTag withFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        _reactTag = reactTag;
        _eventDispatcher = eventDispatcher;
        [self createCollectionView:frame];
    }
    return self;

}

- (void)createCollectionView:(CGRect)frame{
    if (_collectionView == nil) {
        
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.headerHeight = 0;
        layout.footerHeight = 0;
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;

        _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[AKRNCollectionCell class] forCellWithReuseIdentifier:@"AKRNCollectionView"];
        [self addSubview:_collectionView];
        self.backgroundColor = [UIColor clearColor];
    }
    

}

- (void)addPullRefreshForRnCollectionView:(NSDictionary *)diys {
    
    
    if (!self.collectionView.mj_header) {
        RNMJHeader *header = [RNMJHeader headerWithRefreshingBlock:^{
            [_eventDispatcher sendInputEventWithName:@"refresh" body:@{@"target": self.reactTag, @"mode": @"refresh", @"reactTag": self.reactTag}];
        }];
        if (diys[@"headerIdle"]) {
            header.headerIdle = diys[@"headerIdle"];
            header.headerIdle.hidden = YES;
            [header addSubview:header.headerIdle];
        }
        if (diys[@"headerPulling"]) {
            header.headerPulling = diys[@"headerPulling"];
            header.headerPulling.hidden = YES;
            [header addSubview:header.headerPulling];

        }
        if (diys[@"headerRefreshing"]) {
            header.headerRefreshing = diys[@"headerRefreshing"];
            header.headerRefreshing.hidden = YES;
            [header addSubview:header.headerRefreshing];
        }
        self.collectionView.mj_header = header;
        
        RNMJFooter *footer = [RNMJFooter footerWithRefreshingBlock:^{
            [_eventDispatcher sendInputEventWithName:@"infinite" body:@{@"target": self.reactTag, @"mode": @"infinite", @"reactTag": self.reactTag}];
        }];
        if (diys[@"footerIdle"]) {
            footer.footerIdle = diys[@"footerIdle"];
            footer.footerIdle.hidden = YES;
            [footer addSubview:footer.footerIdle];
        }
        if (diys[@"footerPulling"]) {
            footer.footerPulling = diys[@"footerPulling"];
            footer.footerPulling.hidden = YES;
            [footer addSubview:footer.footerPulling];
        }
        if (diys[@"footerRefreshing"]) {
            footer.footerRefreshing = diys[@"footerRefreshing"];
            footer.footerRefreshing.hidden = YES;
            [footer addSubview:footer.footerRefreshing];
        }
        if (diys[@"footerNoMoreData"]) {
            footer.footerNoMoreData = diys[@"footerNoMoreData"];
            footer.footerNoMoreData.hidden = YES;
            [footer addSubview:footer.footerNoMoreData];
        }
        
        self.collectionView.mj_footer = footer;

    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return cells.count;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AKRNCollectionCell *cell = (AKRNCollectionCell *)[cv dequeueReusableCellWithReuseIdentifier:@"AKRNCollectionView" forIndexPath:indexPath];

    AKRNWaterfallCell *cellView = cells[indexPath.row];
    cell.cellView = cellView;
    if (cellView.componentWidth <=0 ) {
        cellView.componentWidth = cellView.frame.size.width;
    }
    if (cellView.componentHeight <=0 ) {
        cellView.componentHeight = cellView.frame.size.height;
    }
    cell.cellView.frame = CGRectMake(0, 0, cellView.componentWidth, cellView.componentHeight);
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    AKRNWaterfallCell *cellView = cells[indexPath.row];
    if (cellView.componentWidth <=0 ) {
        cellView.componentWidth = cellView.frame.size.width;
    }
    if (cellView.componentHeight <=0 ) {
        cellView.componentHeight = cellView.frame.size.height;
    }
    return CGSizeMake(cellView.componentWidth, cellView.componentHeight);
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AKRNCollectionCell *cell = (AKRNCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSDictionary *dic = cell.cellView.itemData;
    if (dic == nil) {
        dic = @{};
    }
    [_eventDispatcher sendInputEventWithName:@"click" body:@{@"target": self.reactTag, @"itemData": dic, @"reactTag": self.reactTag}];
}
-(void)setCells:(NSArray *)array
{
    cells = array;
    [_collectionView reloadData];
}
@end
