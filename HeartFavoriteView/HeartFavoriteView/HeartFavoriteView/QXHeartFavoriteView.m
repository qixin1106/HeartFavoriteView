//
//  GMHeartFavoriteView.m
//  HeartFavorite
//
//  Created by Qixin on 14-4-9.
//  Copyright (c) 2014年 Qixin. All rights reserved.
//

#import "QXHeartFavoriteView.h"

#define AnimDuration 1.0

@interface QXHeartFavoriteView ()
@property (strong, nonatomic) UIImageView *heart;
@property (strong, nonatomic) UIImageView *brokeHeartLeft;
@property (strong, nonatomic) UIImageView *brokeHeartRight;
@end

@implementation QXHeartFavoriteView


#pragma mark - 心动画
- (void)favorite
{
    [UIView animateWithDuration:0.25 animations:^{
        self.heart.alpha = 1;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25f animations:^{
                self.heart.alpha = 0;
            }];
        });
    }];


    
    NSValue *value = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    NSValue *value1 = [NSValue valueWithCGSize:CGSizeMake(1.4, 1.4)];
    NSValue *value2 = [NSValue valueWithCGSize:CGSizeMake(0.8, 0.8)];
    NSValue *value3 = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    NSArray *values = @[value,value1,value2,value3];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform.scale"];
    [animation setValues:values];
    [animation setDuration:AnimDuration*0.5f];



    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue = [NSNumber numberWithFloat:-15/90.0*M_PI_2];
    rotation.toValue = [NSNumber numberWithFloat:15/90.0*M_PI_2];
    rotation.duration = 0.5f;
    rotation.repeatCount = MAXFLOAT;
    rotation.autoreverses = YES;
    rotation.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];

    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    move.fromValue = [NSNumber numberWithFloat:0];
    move.toValue = [NSNumber numberWithFloat:-100];
    move.duration = AnimDuration;
    move.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];


    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = AnimDuration;
    group.animations = @[rotation,move,animation];
    [self.heart.layer addAnimation:group forKey:@"move-rotate-layer"];
}


#pragma mark - 碎心动画
- (void)cancelFavorite
{
    [UIView animateWithDuration:0.25 animations:^{
        self.brokeHeartLeft.alpha = 1;
        self.brokeHeartRight.alpha = 1;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25f animations:^{
                self.brokeHeartLeft.alpha = 0;
                self.brokeHeartRight.alpha = 0;
            }];
        });
    }];


    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue = [NSNumber numberWithFloat:5/90.0*M_PI_2];
    rotation.toValue = [NSNumber numberWithFloat:-45/90.0*M_PI_2];
    rotation.duration = AnimDuration;
    rotation.repeatCount = 1;
    rotation.autoreverses = YES;
    rotation.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];


    CABasicAnimation *rotation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation2.fromValue = [NSNumber numberWithFloat:-5/90.0*M_PI_2];
    rotation2.toValue = [NSNumber numberWithFloat:45/90.0*M_PI_2];
    rotation2.duration = AnimDuration;
    rotation2.repeatCount = 1;
    rotation2.autoreverses = YES;
    rotation2.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];


    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    move.fromValue = [NSNumber numberWithFloat:0];
    move.toValue = [NSNumber numberWithFloat:100];
    move.duration = AnimDuration;
    move.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];



    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = AnimDuration;
    group.animations = @[rotation,move];

    CAAnimationGroup *group2 = [CAAnimationGroup animation];
    group2.delegate = self;
    group2.duration = AnimDuration;
    group2.animations = @[rotation2,move];

    [self.brokeHeartLeft.layer addAnimation:group forKey:@"move-rotate-cancel"];
    [self.brokeHeartRight.layer addAnimation:group2 forKey:@"move-rotate-cancel2"];
}




#pragma mark - 入口
- (id)initWithPoint:(CGPoint)point
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0,0, 63, 55);
        self.center = CGPointMake(point.x, point.y);

        //TODO: 完整的心
        UIImage *imageHeart = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_xin_hong" ofType:@"png"] options:NSDataReadingMapped error:nil]];
        self.heart = [[UIImageView alloc] initWithImage:imageHeart];
        self.heart.frame = self.bounds;
        self.heart.alpha = 0;
        [self addSubview:self.heart];


        //TODO: 碎心
        UIImage *imagebrokeHeartLeft = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_xin_hui_left" ofType:@"png"] options:NSDataReadingMapped error:nil]];
        self.brokeHeartLeft = [[UIImageView alloc] initWithImage:imagebrokeHeartLeft];
        self.brokeHeartLeft.frame = CGRectMake(20, 0, 32, 55);
        self.brokeHeartLeft.alpha = 0;
        self.brokeHeartLeft.layer.anchorPoint = CGPointMake(1, 1);
        [self addSubview:self.brokeHeartLeft];

        UIImage *imagebrokeHeartRight = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_xin_hui_right" ofType:@"png"] options:NSDataReadingMapped error:nil]];
        self.brokeHeartRight = [[UIImageView alloc] initWithImage:imagebrokeHeartRight];
        self.brokeHeartRight.frame = CGRectMake(11, 0, 32, 55);
        self.brokeHeartRight.alpha = 0;
        self.brokeHeartRight.layer.anchorPoint = CGPointMake(0, 1);
        [self addSubview:self.brokeHeartRight];
    }
    return self;
}


- (void)dealloc
{
    [self.heart.layer removeAllAnimations];
    [self.brokeHeartLeft.layer removeAllAnimations];
    [self.brokeHeartRight.layer removeAllAnimations];
}


#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.heart.layer removeAllAnimations];
    [self performSelector:@selector(removeFromSuperview)];
}




@end
