//
//  AKRNWaterfall.h
//  Pods
//
//  Created by 李春城 on 15/11/27.
//
//

#import <UIKit/UIKit.h>

#import "RCTView.h"


@class RCTEventDispatcher;

@interface AKRNWaterfall : UIView

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;
- (void)headerEndRefreshing;
- (void)footerEndRefreshing;
- (void)footerEndRefreshingNoMoreData:(float)bottom;

@property (nonatomic, strong) NSDictionary *box;
@property (nonatomic) int cellCount;



@end
