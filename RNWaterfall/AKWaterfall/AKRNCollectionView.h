//
//  AKRNWaterfallView.h
//  Pods
//
//  Created by 李春城 on 15/11/27.
//
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"
#import "RCTEventDispatcher.h"
#import "AKRNWaterfallCell.h"
@interface AKRNCollectionView : UIView <UICollectionViewDataSource,UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

- (id)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher reactTag:(NSNumber *)reactTag withFrame:(CGRect)frame;
- (void)addPullRefreshForRnCollectionView:(NSDictionary *)diys;
-(void)setCells:(NSArray*)array;

@property (nonatomic, strong) NSNumber *reactTag;

@end
