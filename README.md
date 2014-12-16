HeartFavoriteView
=================

演示效果:

![image](https://raw.githubusercontent.com/qixin1106/HeartFavoriteView/master/HeartFavoriteView/heart.gif)

### CODE
    
    QXHeartFavoriteView *heartView = [[QXHeartFavoriteView alloc] initWithPoint:sender.center];
    [self.view addSubview:heartView];
   
    //收藏动画
    [heartView favorite];
    
     //取消收藏动画
    [heartView cancelFavorite];


