//
//  HJBHeaderScrollView.m
//  05-图片轮播器
//
//  Created by 小明 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HJBHeaderScrollView.h"
//#import "UIImageView+WebCache.h"
#import "SDImageCache.h"


#define kSCreenWidth [UIScreen mainScreen].bounds.size.width
#define kSCreenHeight [UIScreen mainScreen].bounds.size.height
#define kSelfWidth self.frame.size.width
@interface HJBHeaderScrollView ()<UIScrollViewDelegate>

@property(strong, nonatomic) UIPageControl *pageControl;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) NSMutableArray *imgArr;

@property(strong, nonatomic) UIImageView *currentImageView;
@property(strong, nonatomic) UIImageView *leftImageView;
@property(strong, nonatomic) UIImageView *rightImageView;

@end

@implementation HJBHeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)array {
  if (self = [super initWithFrame:frame]) {
    //   1.添加imageview
    //CGFloat viewW = self.frame.size.width;
    _imgArr = array.copy;
    self.bounces = NO;
    self.contentSize = CGSizeMake(3 * kSelfWidth, 0);
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    //    3.分页
    self.pagingEnabled = YES;
    [self setupUI];
    [self addTimer];
     [self creatTapHandel];
      
  }
  return self;
}




//定时器执行的方法
- (void)next {
  //  NSLog(@"====================");
  [self setContentOffset:CGPointMake(2 * self.frame.size.width, 0)
                animated:YES];
}
/**
 *  更新数据换页
 */
- (void)reloadImage {
  CGPoint offset = [self contentOffset];
  if (offset.x <= 2 * self.frame.size.width &&
      offset.x >= 1.5 * self.frame.size.width) {
    if (self.pageControl.currentPage == (self.pageControl.numberOfPages - 1)) {
      self.pageControl.currentPage = 0;
    } else {
      self.pageControl.currentPage =
          (_pageControl.currentPage + 1) % (self.pageControl.numberOfPages);
    }
  } else if (offset.x >= 0 && offset.x <= 0.5 * self.frame.size.width) {
    if (self.pageControl.currentPage == 0) {
      self.pageControl.currentPage = (self.pageControl.numberOfPages - 1);
    } else {
      self.pageControl.currentPage =
          (self.pageControl.currentPage - 1) % (self.pageControl.numberOfPages);
    }
  }

  self.currentImageView.image = [[SDImageCache sharedImageCache]
      imageFromDiskCacheForKey:[NSString stringWithFormat:@"img_0%ld",
                                                          (long)self.pageControl
                                                              .currentPage]];

  self.rightImageView.image = [[SDImageCache sharedImageCache]
      imageFromDiskCacheForKey:
          [NSString stringWithFormat:@"img_0%ld",
                                     (self.pageControl.currentPage + 1) >=
                                             (self.pageControl.numberOfPages)
                                         ? 0
                                         : (self.pageControl.currentPage + 1)]];

  self.leftImageView.image = [[SDImageCache sharedImageCache]
      imageFromDiskCacheForKey:
          [NSString stringWithFormat:@"img_0%ld",
                                     (self.pageControl.currentPage - 1) < 0
                                         ? (self.pageControl.numberOfPages - 1)
                                         : (self.pageControl.currentPage - 1)]];
}
/**
 *  自动滚动结束调用
 *
 *  @param scrollView scrollView
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  [self reloadImage];
  [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}
/**
 *  手动滚动结束调用
 *
 *  @param scrollView scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  [self reloadImage];
  [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}

//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  //    移除定时器
    [self removeTimer];
}

//结束拖拽是调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
  // 添加定时器
  [self addTimer];
}
// 添加定时器
- (void)addTimer {
  //    1.添加定时器
  NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                    target:self
                                                  selector:@selector(next)
                                                  userInfo:nil
                                                   repeats:YES];
  //    2.改变(添加)定时器的模式,能够同时处理两件事情
  [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
  self.timer = timer;
}
//    移除定时器
- (void)removeTimer {
  [self.timer invalidate];
  self.timer = nil;
}
/**
 *  设置界面控件
 */
- (void)setupUI {
  self.delegate = self;
  [self addSubview:self.currentImageView];
  [self addSubview:self.leftImageView];
  [self addSubview:self.rightImageView];
  [self addSubview:self.pageControl];
  self.pageControl.center =
      CGPointMake(1.5 * self.frame.size.width, self.frame.size.height * 0.95);
}

//滚动过程
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //下面两句话，把pageControl一直放在scrollview中间！
  CGPoint offset = [self contentOffset];
  self.pageControl.center = CGPointMake(
      1.5 * self.frame.size.width + (offset.x - self.frame.size.width),
      self.bounds.size.height * 0.95);
}

/**
 *  懒加载imgArr
 *
 *  @return imgArr
 */
- (NSMutableArray *)imgArr {
  if (_imgArr == nil) {
    _imgArr = [NSMutableArray array];
  }
  return _imgArr;
}
/**
 *  懒加载pageControl
 *
 *  @return pageControl
 */
- (UIPageControl *)pageControl {
  if (_pageControl == nil) {
    _pageControl = [[UIPageControl alloc]
        initWithFrame:CGRectMake(0, 0, self.frame.size.width, 5)];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.numberOfPages = self.imgArr.count;
    _pageControl.currentPage = 0;
  }
  return _pageControl;
}
/**
 *  懒加载控件
 *
 *  @return currentImageView
 */
- (UIImageView *)currentImageView {
  if (_currentImageView == nil) {
    _currentImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0,
                                                      self.frame.size.width,
                                                      self.frame.size.height)];
    _currentImageView.image = [[SDImageCache sharedImageCache]
        imageFromDiskCacheForKey:[NSString stringWithFormat:@"img_0%d", 0]];
      
      
  }
  return _currentImageView;
}
/**
 *  懒加载控件
 *
 *  @return leftImageView
 */
- (UIImageView *)leftImageView {
  if (_leftImageView == nil) {
    _leftImageView = [[UIImageView alloc]
        initWithFrame:CGRectMake(0, 0, self.frame.size.width,
                                 self.frame.size.height)];
    _leftImageView.image = [[SDImageCache sharedImageCache]
        imageFromDiskCacheForKey:[NSString stringWithFormat:@"img_0%lu",
                                                            (unsigned long)self
                                                                .imgArr.count]];
      
  }
  return _leftImageView;
}
/**
 *  懒加载控件
 *
 *  @return rightImageView
 */
- (UIImageView *)rightImageView {
  if (_rightImageView == nil) {
    _rightImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(2 * self.frame.size.width,
                                                      0, self.frame.size.width,
                                                      self.frame.size.height)];
    _rightImageView.image = [[SDImageCache sharedImageCache]
        imageFromDiskCacheForKey:[NSString stringWithFormat:@"img_0%d", 1]];
      
  }
  return _rightImageView;
}

-(void)creatTapHandel
{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];



}

-(void)tapAction
{

    if (_pageControl.currentPage == 0) {
        
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        
    }
    else if (_pageControl.currentPage == 1)
    {
       _pageControl.pageIndicatorTintColor = [UIColor cyanColor];
        
    }
    
    
    

}






@end
