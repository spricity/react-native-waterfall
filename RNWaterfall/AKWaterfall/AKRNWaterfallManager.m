//
//  AKRNWaterfallManager.m
//  Pods
//
//  Created by 李春城 on 15/11/27.
//
//
#import "AKRNWaterfallManager.h"
#import "AKRNWaterfall.h"

#import "RCTBridge.h"
#import "RCTConvert.h"
#import "RCTUIManager.h"
#import "RCTSparseArray.h"

@implementation AKRNWaterfallManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[AKRNWaterfall alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}
@synthesize bridge = _bridge;


- (dispatch_queue_t)methodQueue
{
    return _bridge.uiManager.methodQueue;
}
RCT_EXPORT_VIEW_PROPERTY(box, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(cellCount, int)

//- (NSDictionary *)constantsToExport
//{
//  UIPickerView *view = [[UIPickerView alloc] init];
//  return @{
//    @"ComponentHeight": @(view.intrinsicContentSize.height),
//    @"ComponentWidth": @(view.intrinsicContentSize.width)
//  };
//}

- (NSDictionary *)customDirectEventTypes
{
    return @{
             @"refresh":    @{ @"registrationName": @"onRefresh" },
             @"infinite":   @{ @"registrationName": @"onInfinite" },
             @"click":      @{ @"registrationName": @"onClick" },
             };
}

RCT_EXPORT_METHOD(headerEndRefreshing:(nonnull NSNumber *)reactTag)
{
    [self.bridge.uiManager addUIBlock:
     ^(__unused RCTUIManager *uiManager, RCTSparseArray *viewRegistry){
         
         AKRNWaterfall *wf = viewRegistry[reactTag];
         
         if ([wf isKindOfClass:[AKRNWaterfall class]]) {
             [wf headerEndRefreshing];
         }else{
             RCTLogError(@"Cannot header endRefreshing: %@ (tag #%@) is not AKRNWaterfall", wf, reactTag);
         }
     }];
}

RCT_EXPORT_METHOD(footerEndRefreshing:(nonnull NSNumber *)reactTag)
{
    [self.bridge.uiManager addUIBlock:
     ^(__unused RCTUIManager *uiManager, RCTSparseArray *viewRegistry){
         
         AKRNWaterfall *wf = viewRegistry[reactTag];
         
         if ([wf isKindOfClass:[AKRNWaterfall class]]) {
             [wf footerEndRefreshing];
         }else{
             RCTLogError(@"Cannot footer endRefreshing: %@ (tag #%@) is not AKRNWaterfall", wf, reactTag);
         }
     }];
}
RCT_EXPORT_METHOD(footerEndRefreshingNoMoreData:(nonnull NSNumber *)reactTag contentInsetBottom:(float)bottom)
{
    [self.bridge.uiManager addUIBlock:
     ^(__unused RCTUIManager *uiManager, RCTSparseArray *viewRegistry){
         
         AKRNWaterfall *wf = viewRegistry[reactTag];
         
         if ([wf isKindOfClass:[AKRNWaterfall class]]) {
             [wf footerEndRefreshingNoMoreData:bottom];
         }else{
             RCTLogError(@"Cannot footer endRefreshing: %@ (tag #%@) is not AKRNWaterfall", wf, reactTag);
         }
     }];
}

@end
