//
//  SKHomeButtonModel.m
//  SKiPhoneHomeButton
//
//  Created by ShevaKuilin on 2017/5/14.
//  Copyright © 2017年 ShevaKuilin. All rights reserved.
//

#import "Tool.h"
#import "SKHomeButtonModel.h"

@implementation SKHomeButtonModel

#pragma mark - 手势

+ (void)setGestureWithHomeButton:(UIView *)homeButton {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)];
    [homeButton addGestureRecognizer:gesture];
}

- (void)drag:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint offset = [sender translationInView:sender.view];
        [sender.view setCenter:CGPointMake(sender.view.center.x + offset.x, sender.view.center.y + offset.y)];
        [sender setTranslation:CGPointZero inView:sender.view];
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        
    }
}

@end
