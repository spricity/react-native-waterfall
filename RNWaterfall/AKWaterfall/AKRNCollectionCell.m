//
//  AKRNCollectionViewCell.m
//  Pods
//
//  Created by 李春城 on 15/11/27.
//
//

#import "AKRNCollectionCell.h"

@implementation AKRNCollectionCell


-(void)setCellView:(AKRNWaterfallCell *)cellView {
    _cellView = cellView;
    _cellView.tag = 1000;
    AKRNWaterfallCell* oldCellView = (id)[self viewWithTag:1000];
    if (oldCellView) {
        [oldCellView removeFromSuperview];
    }
    cellView.tag = 1000;
    [self.contentView addSubview:cellView];
}

//-(void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//    [_cellView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
