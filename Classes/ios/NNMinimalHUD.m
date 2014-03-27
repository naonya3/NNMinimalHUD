//
//  NNMinimalHUD.m
//  NNMinimalHUD
//
//  Created by Naoto Horiguchi on 2014/02/13.
//  Copyright (c) 2014年 Naoto Horiguchi. All rights reserved.
//

#import "NNMinimalHUD.h"

static UIEdgeInsets _contentInsets;
static CGSize _minSize;
static CGSize _maxSize;
static UIColor *_backgroundColor;
static UIView *_backgroundView;
static UIView *_HUDBackgroundView;

static NNMinimalHUD *_showedHUD;
static UIWindow *_originalWindow;
static UIWindow *_HUDWindow;

@implementation NNMinimalHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+ (void)load
{
    _minSize = [self minSize];
    _maxSize = [self maxSize];
    _HUDBackgroundView = [self HUDBackgroundView];
    _backgroundColor = [self backgroundColor];
    _contentInsets = [self contentInsets];
}

+ (void)reset
{
    _contentInsets = UIEdgeInsetsZero;
    _minSize = CGSizeZero;
    _maxSize = CGSizeZero;
    _HUDBackgroundView = nil;
    _backgroundColor = nil;
    _backgroundView = nil;
    _HUDBackgroundView = nil;
    
    _minSize = [self minSize];
    _maxSize = [self maxSize];
    _HUDBackgroundView = [self HUDBackgroundView];
    _backgroundColor = [self backgroundColor];
    _contentInsets = [self contentInsets];
}

+ (UIEdgeInsets)contentInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, _contentInsets)) {
        _contentInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    }
    return _contentInsets;
}

+ (void)setContentInsets:(UIEdgeInsets)insets
{
    _contentInsets = insets;
}

+ (CGSize)minSize
{
    if (CGSizeEqualToSize(CGSizeZero, _minSize)) {
        _minSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 120, 120);
    }
    return _minSize;
}

+ (void)setMinSize:(CGSize)minSize
{
    _minSize = minSize;
}

+ (CGSize)maxSize
{
    if (CGSizeEqualToSize(CGSizeZero, _maxSize)) {
        _maxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 80, CGFLOAT_MAX);
    }
    return _maxSize;
}

+ (void)setMaxSize:(CGSize)maxSize
{
    _maxSize = maxSize;
}

+ (UIColor *)backgroundColor
{
    if (!_backgroundColor) {
        _backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _backgroundColor;
}

+ (void)setBackgroundColor:(UIColor *)color
{
    _backgroundColor = color;
}

+ (UIView *)backgroundView
{
    return _backgroundView;
}

+ (void)setBackgroundView:(UIView *)backgroundView
{
    _backgroundView = backgroundView;
}

+ (UIView *)HUDBackgroundView
{
    if (!_HUDBackgroundView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        view.layer.cornerRadius = 10;
        view.clipsToBounds = YES;
        _HUDBackgroundView = view;
    }
    return _HUDBackgroundView;
}

+ (void)setHUDBackgroundView:(UIView *)hudBackgroundView
{
    _HUDBackgroundView = hudBackgroundView;
}

+ (void)showWithContentsView:(UIView *)contentsView
{
    [self showWithContentsView:contentsView duration:0.];
}

+ (void)showWithContentsView:(UIView *)contentsView duration:(NSTimeInterval)duration
{
    if (_showedHUD) {
        [self dismissAnimated:NO];
    }
    
    [self showInView:nil withContentsView:contentsView duration:duration];
}

+ (void)showInView:(UIView *)parentView withContentsView:(UIView *)contentsView
{
    [self showInView:parentView withContentsView:contentsView duration:0.];
}

+ (void)showInView:(UIView *)parentView withContentsView:(UIView *)contentsView duration:(NSTimeInterval)duration
{
    if (_showedHUD) {
        [self dismissAnimated:NO];
    }
    
    if (!parentView) {
        _originalWindow = [[UIApplication sharedApplication] keyWindow];
        _HUDWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _HUDWindow.windowLevel = _originalWindow.windowLevel + 1.;
        [_HUDWindow makeKeyAndVisible];
        parentView = _HUDWindow;
    }
    
    _showedHUD = [[NNMinimalHUD alloc] initWithFrame:parentView.bounds];
    _showedHUD.backgroundColor = _backgroundColor;
    if (_backgroundView) {
        _backgroundView.frame = _showedHUD.bounds;
        [_showedHUD addSubview:_backgroundView];
    }
    
    UIView *hudView = [[UIView alloc] init];
    hudView.backgroundColor = [UIColor clearColor];
    
    _HUDBackgroundView.frame = hudView.bounds;
    _HUDBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [hudView addSubview:_HUDBackgroundView];
    
    if (contentsView) {
        [hudView addSubview:contentsView];
        contentsView.frame = CGRectMake(CGRectGetWidth(hudView.frame)  / 2 - CGRectGetWidth(contentsView.frame)  / 2,
                                        CGRectGetHeight(hudView.frame) / 2 - CGRectGetHeight(contentsView.frame) / 2,
                                        contentsView.frame.size.width,
                                        contentsView.frame.size.height);
        
        contentsView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin    |
                                        UIViewAutoresizingFlexibleBottomMargin |
                                        UIViewAutoresizingFlexibleLeftMargin   |
                                        UIViewAutoresizingFlexibleRightMargin;
    }
    
    CGFloat width =  MAX(_minSize.width,  CGRectGetWidth(contentsView.frame) + _contentInsets.left + _contentInsets.right);
    CGFloat height = MAX(_minSize.height, CGRectGetHeight(contentsView.frame) + _contentInsets.top + _contentInsets.bottom);
    
    hudView.frame = CGRectMake(CGRectGetWidth(parentView.frame) / 2 - width / 2, CGRectGetHeight(parentView.frame) / 2 - height / 2, width, height);
    
    [_showedHUD addSubview:hudView];

    _showedHUD.alpha = 0.;
    [parentView addSubview:_showedHUD];
    
    [UIView animateWithDuration:0.1 animations:^{
        _showedHUD.alpha = 1.0;
    }];
    
    if (duration > 0.) {
        __block __weak NNMinimalHUD *bHUD = _showedHUD;
        
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (bHUD) {
                [self dismiss];
            }
        });
    }
}

+ (void)dismiss
{
    [self dismissAnimated:YES];
}

+ (void)dismissAnimated:(BOOL)animated
{
    [self dismissWithContentsView:nil duration:0 animated:animated];
}

+ (void)dismissWithContentsView:(UIView *)contentsView
{
    [self dismissWithContentsView:contentsView duration:2. animated:YES];
}

+ (void)dismissWithContentsView:(UIView *)contentsView duration:(NSTimeInterval)duration
{
    [self dismissWithContentsView:contentsView duration:duration animated:YES];
}

+ (void)dismissWithContentsView:(UIView *)contentsView duration:(NSTimeInterval)duration animated:(BOOL)animated
{
    if (contentsView && duration > 0.) {
        UIView *parentView = [_showedHUD.superview isEqual:_HUDWindow]? nil: _showedHUD.superview;
        [self dismissAnimated:NO];
        [self showInView:parentView withContentsView:contentsView duration:duration];
        return;
    }
    
    void (^completionBlock)(BOOL) = ^(BOOL finish){
        if (_HUDWindow) {
            [_HUDWindow removeFromSuperview];
            _HUDWindow = nil;
            [_originalWindow makeKeyWindow];
            _originalWindow = nil;
        } else {
            [_showedHUD removeFromSuperview];
        }
        _showedHUD = nil;
    };
    
    if (!animated) {
        completionBlock(YES);
        return;
    }
    
    _showedHUD.userInteractionEnabled = NO;
    _HUDWindow.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.44 delay:duration options:0 animations:^{
        _showedHUD.alpha = 0.0;
    } completion:completionBlock];
}

@end
