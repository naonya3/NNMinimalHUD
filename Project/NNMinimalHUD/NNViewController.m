//
//  NNViewController.m
//  NNMinimalHUD
//
//  Created by Naoto Horiguchi on 2014/02/13.
//  Copyright (c) 2014年 Naoto Horiguchi. All rights reserved.
//

#import "NNViewController.h"
#import <NNMinimalHUD/NNMinimalHUD.h>
#import <FXBlurView/FXBlurView.h>

@interface NNViewController ()

@end

@implementation NNViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)_didTouchDefaultButton:(id)sender
{
    [NNMinimalHUD reset];
    
    UIActivityIndicatorView *ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [ind sizeToFit];
    [ind startAnimating];
    [NNMinimalHUD showWithContentsView:ind];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:18];
        label.text = @"Success!";
        [label sizeToFit];
        [NNMinimalHUD dismissWithContentsView:label];
    });
}

- (IBAction)_didTouchCustomButton:(id)sender
{
    // Custom Background Color!!
    [NNMinimalHUD setBackgroundColor:[UIColor clearColor]];
    
    // Custom Background View
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor yellowColor];
    backgroundView.alpha = 0.3;
    [NNMinimalHUD setBackgroundView:backgroundView];
    
    // Custom Background of HUD
    UIView *hudBackground = [[UIView alloc] init];
    hudBackground.layer.cornerRadius = 30;
    hudBackground.backgroundColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.7 alpha:0.7];
    [NNMinimalHUD setHUDBackgroundView:hudBackground];
    
    UIActivityIndicatorView *ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [ind sizeToFit];
    [ind startAnimating];
    [NNMinimalHUD showWithContentsView:ind];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:18];
        label.text = @"Success!";
        [label sizeToFit];
        [NNMinimalHUD dismissWithContentsView:label];
    });
    
    {
        double delayInSeconds = 5.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:18];
            label.numberOfLines = 2;
            label.text = @"Setting is global.";
            [label sizeToFit];
            [NNMinimalHUD showWithContentsView:label duration:2];
        });
    }
    
    
}

- (IBAction)_didTouchBlurButton:(id)sender
{
    // Custom Background Color!!
    [NNMinimalHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    
    // Custom Background View
//    FXBlurView *backgroundView = [[FXBlurView alloc] init];
//    backgroundView.blurRadius = 10;
//    backgroundView.underlyingView = [[UIApplication sharedApplication] keyWindow];
//    [NNMinimalHUD setBackgroundView:backgroundView];
    [NNMinimalHUD setBackgroundView:nil];
    // Custom Background of HUD
    FXBlurView *hudBackground = [[FXBlurView alloc] init];
    hudBackground.layer.cornerRadius = 10;
    hudBackground.blurRadius = 20;
    hudBackground.underlyingView = [[UIApplication sharedApplication] keyWindow];
    [NNMinimalHUD setHUDBackgroundView:hudBackground];
    
    UIActivityIndicatorView *ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [ind sizeToFit];
    [ind startAnimating];
    [NNMinimalHUD showWithContentsView:ind duration:2];
}

@end
