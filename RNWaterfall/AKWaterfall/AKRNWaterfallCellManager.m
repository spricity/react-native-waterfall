//
//  AlinkRNCollctionCellViewManager.m
//  Pods
//
//  Created by 李春城 on 15/11/27.
//
//

#import "AKRNWaterfallCellManager.h"
#import "AKRNWaterfallCell.h"

@implementation AKRNWaterfallCellManager

RCT_EXPORT_MODULE()
- (UIView *)view
{
    return [[AKRNWaterfallCell alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(componentHeight, float)
RCT_EXPORT_VIEW_PROPERTY(componentWidth, float)
RCT_EXPORT_VIEW_PROPERTY(cellType, NSString)
RCT_EXPORT_VIEW_PROPERTY(itemData, NSDictionary)



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
