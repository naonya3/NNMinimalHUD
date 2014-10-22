//
//  NNMinimalHUD.h
//  NNMinimalHUD
//
//  Created by Naoto Horiguchi on 2014/02/13.
//  Copyright (c) 2014年 Naoto Horiguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNMinimalHUD : UIView

+ (void)reset;

+ (UIEdgeInsets)contentInsets;
+ (void)setContentInsets:(UIEdgeInsets)insets;

+ (CGSize)minSize;
+ (void)setMinSize:(CGSize)minSize;

//+ (CGSize)maxSize;
//+ (void)setMaxSize:(CGSize)maxSize;

+ (UIColor *)backgroundColor;
+ (void)setBackgroundColor:(UIColor *)color;

+ (UIView *)backgroundView;
+ (void)setBackgroundView:(UIView *)backgroundView;

+ (UIView *)HUDBackgroundView;
+ (void)setHUDBackgroundView:(UIView *)hudBackgroundView;

+ (void)showWithContentsView:(UIView *)contentsView;
+ (void)showWithContentsView:(UIView *)contentsView duration:(NSTimeInterval)duration;

+ (void)showInView:(UIView *)parentView withContentsView:(UIView *)contentsView;
+ (void)showInView:(UIView *)parentView withContentsView:(UIView *)contentsView duration:(NSTimeInterval)duration;

+ (void)dismiss;

+ (void)dismissWithContentsView:(UIView *)contentsView;
+ (void)dismissWithContentsView:(UIView *)contentsView duration:(NSTimeInterval)duration;

+ (NNMinimalHUD*)showedHUD;

@end
