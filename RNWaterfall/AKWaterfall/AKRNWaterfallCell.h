//
//  AKRNCollectionCell.h
//  Pods
//
//  Created by 李春城 on 15/11/27.
//
//

#import <UIKit/UIKit.h>

#import "AKRNCollectionCell.h"

@class AKRNCollectionCell;

@interface AKRNWaterfallCell : UIView
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) AKRNCollectionCell *cellView;
@property (nonatomic) float componentHeight;
@property (nonatomic) float componentWidth;
@property (nonatomic, strong) NSString *cellType;
@property (nonatomic, strong) NSDictionary *itemData;
@end
