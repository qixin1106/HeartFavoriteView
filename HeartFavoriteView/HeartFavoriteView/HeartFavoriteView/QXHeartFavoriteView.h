//
//  GMHeartFavoriteView.h
//  HeartFavorite
//
//  Created by Qixin on 14-4-9.
//  Copyright (c) 2014年 Qixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QXHeartFavoriteView : UIView
- (id)initWithPoint:(CGPoint)point;
- (void)favorite;//收藏动画
- (void)cancelFavorite;//取消收藏动画
@end
