//
//  ViewController.m
//  Catnip
//
//  Created by Adam Cooper on 8/8/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "ViewController.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>

@interface ViewController () <MDCSwipeToChooseDelegate>
@property (nonatomic, strong) MDCSwipeToChooseView *swipeView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *nameAgeLabel;
@property (nonatomic, strong) UIView *catAmountView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.swipeView];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.nameAgeLabel];
    [self.view addSubview:self.catAmountView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)catAmountView {
    if (!_catAmountView) {
        _catAmountView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, self.swipeView.frame.size.height + self.topLabel.frame.size.height, 100, 50)];
        UIImageView *catIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [catIconImageView setImage:[UIImage imageNamed:@"catOutline"]];
        [_catAmountView addSubview:catIconImageView];

        UILabel *catQuantityLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 17, 50, 50)];
        [catQuantityLabel setText:@"'s: 3"];
        [catQuantityLabel setTextColor:[UIColor orangeColor]];
        [_catAmountView addSubview:catQuantityLabel];
    }
    return _catAmountView;
}

-(UILabel *)nameAgeLabel {
    if (!_nameAgeLabel) {
        _nameAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, self.swipeView.frame.size.height + self.topLabel.frame.size.height + 8, self.view.frame.size.width-100, 50)];
        [_nameAgeLabel setText:@"Charles, 61"];
        [_nameAgeLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:21.0]];
    }
    return _nameAgeLabel;
}

-(UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        [_topLabel setBackgroundColor:[UIColor orangeColor]];
        [_topLabel setTextColor:[UIColor whiteColor]];
        [_topLabel setTextAlignment:NSTextAlignmentCenter];
        [_topLabel setText:@"CatNip"];
    }
    return _topLabel;
}

-(MDCSwipeToChooseView *)swipeView {
    if (!_swipeView) {

        // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
        MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
        options.likedText = @"Like";
        options.likedColor = [UIColor greenColor];
        options.nopeText = @"Nope";
        options.nopeColor = [UIColor redColor];
        options.onPan = ^(MDCPanState *state){
            if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
                NSLog(@"Let go now to delete the photo!");
            }
        };

        _swipeView = [[MDCSwipeToChooseView alloc] initWithFrame:CGRectMake(0, self.topLabel.frame.size.height, self.view.frame.size.width, 400)
                                                         options:options];
        _swipeView.imageView.image = [UIImage imageNamed:@"testImage"];

    }
    return _swipeView;
}

#pragma mark - MDCSwipeToChooseDelegate Callbacks

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Didn't swipe all the way");
}

// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        return YES;
    } else {
        // Snap the view back and cancel the choice.
        [UIView animateWithDuration:0.16 animations:^{
            view.transform = CGAffineTransformIdentity;
            view.center = [view superview].center;
        }];
        return NO;
    }
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved!");
    }
}


@end
