//
//  ViewController.m
//  HeartFavoriteView
//
//  Created by Qixin on 14/12/16.
//  Copyright (c) 2014年 Qixin. All rights reserved.
//

#import "ViewController.h"
#import "QXHeartFavoriteView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@end

@implementation ViewController

- (IBAction)favoriteClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [sender setTitle:(sender.selected)?@"取消收藏":@"收藏"
            forState:UIControlStateNormal];
    
    
    QXHeartFavoriteView *heartView = [[QXHeartFavoriteView alloc] initWithPoint:sender.center];
    [self.view addSubview:heartView];
    if (sender.selected)
    {
        //收藏动画
        [heartView favorite];
    }
    else
    {
        //取消收藏动画
        [heartView cancelFavorite];
    }
}


@end
