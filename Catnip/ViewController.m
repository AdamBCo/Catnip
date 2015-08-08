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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.swipeView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

        _swipeView = [[MDCSwipeToChooseView alloc] initWithFrame:self.view.bounds
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
