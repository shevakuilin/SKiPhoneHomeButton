//
//  SKHomeButton.m
//  SKiPhoneHomeButton
//
//  Created by ShevaKuilin on 2017/5/13.
//  Copyright © 2017年 ShevaKuilin. All rights reserved.
//

#import "Tool.h"
#import "SKHomeButton.h"
#import "SKBaseOptionsView.h"
#import "SKAnimationController.h"

@interface SKHomeButton ()

@property (nonatomic, strong, readwrite) UIView *baseView;
@property (nonatomic, strong, readwrite) SKBaseOptionsView *secondOptionsView;
@property (nonatomic, strong, readwrite) SKAnimationController *animationController;
@property (nonatomic, assign, readwrite) CGPoint startPoint;
@property (nonatomic, strong, readwrite) dispatch_source_t timer;
@property (nonatomic, assign, readwrite) NSInteger quoteCount;

@end

@implementation SKHomeButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.3;
        [self setUI];
        [self setGesture];
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(notice:) name:@"hiddenSecondView" object:nil];
        self.animationController = [[SKAnimationController alloc] init];
    }
    return self;
}

#pragma mark - 设置UI

- (void)setUI {
    self.baseView = [UIView new];
    [self addSubview:self.baseView];
    self.baseView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
    self.baseView.layer.masksToBounds = YES;
    self.baseView.layer.cornerRadius = 10;
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIImageView * thirdRound = [UIImageView new];
    [self.baseView addSubview:thirdRound];
    thirdRound.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    thirdRound.layer.masksToBounds = YES;
    thirdRound.layer.cornerRadius = 19.5;
    thirdRound.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:1].CGColor;
    thirdRound.layer.borderWidth = 0.5;
    thirdRound.userInteractionEnabled = NO;
    [thirdRound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.baseView);
        make.size.mas_offset(CGSizeMake(39, 39));
    }];
    
    UIImageView *secondRound = [UIImageView new];
    [self.baseView addSubview:secondRound];
    secondRound.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    secondRound.layer.masksToBounds = YES;
    secondRound.layer.cornerRadius = 16;
    secondRound.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:1].CGColor;
    secondRound.layer.borderWidth = 0.5;
    secondRound.userInteractionEnabled = NO;
    [secondRound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.baseView);
        make.size.mas_offset(CGSizeMake(32, 32));
    }];
    
    UIImageView *firstRound = [UIImageView new];
    [self.baseView addSubview:firstRound];
    firstRound.backgroundColor = [UIColor whiteColor];
    firstRound.layer.masksToBounds = YES;
    firstRound.layer.cornerRadius = 12.5;
    firstRound.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:1].CGColor;
    firstRound.layer.borderWidth = 0.5;
    firstRound.userInteractionEnabled = NO;
    [firstRound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.baseView);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
}

#pragma mark - 手势

- (void)setGesture {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)];
    [self addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *showGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSecondOptionsView)];
    [self addGestureRecognizer:showGesture];
}

- (void)drag:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.alpha = 1;
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint offset = [sender translationInView:self];
        [sender.view setCenter:CGPointMake(self.center.x + offset.x, self.center.y + offset.y)];
        [sender setTranslation:CGPointZero inView:self];
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self autoCloseEdge];
    }
}


#pragma mark - 自动靠边

- (void)autoCloseEdge {
    [UIView animateWithDuration:0.5f animations:^{
        // center
        self.center = [self calculatePoisitionWithEndOffset:CGPointZero];//center;
    } completion:^(BOOL finished) {
        // 靠边之后自动缩进边缘处
        [self performSelector:@selector(autoEdgeOffset) withObject:nil afterDelay:0];
    }];
}

- (void)autoEdgeOffset {
    CGPoint config = CGPointMake(self.bounds.origin.x, self.bounds.origin.y);
    [UIView animateWithDuration:0.5f animations:^{
        self.center = [self calculatePoisitionWithEndOffset:config];
        [self fadeoutTimer];
    }];
}

- (CGPoint)calculatePoisitionWithEndOffset:(CGPoint)offset {
    CGFloat ballHalfW = self.bounds.size.width * 0.5;
    CGFloat ballHalfH = self.bounds.size.height * 0.5;
    CGPoint center = self.center;
    
    if (center.y > 100 && center.y < (HEIGHT - 100)) {// 左右靠边范围
        if (center.x < WIDTH / 2) {
            center.x = ballHalfW;
        } else {
            center.x = WIDTH - ballHalfW;
        }
    } else {// 上下靠边范围
        if (center.y < 100) {
            center.y = ballHalfH;
        } else {
            center.y = HEIGHT - ballHalfH;
        }
    }
    
    return center;
}

#pragma mark - 显示/隐藏二级选项界面

- (void)showSecondOptionsView {
    self.hidden = YES;
    self.secondOptionsView = [[SKBaseOptionsView alloc] initWithFrame:[self superview].frame displayType:SK_BASEVIEW_TYPE_NORMAL homeBtnPoint:self.bounds.origin];
    [[self superview] addSubview:self.secondOptionsView];
    self.secondOptionsView.userInteractionEnabled = YES;
    
    _startPoint = CGPointMake(0, 0);
    if (self.center.y > 100 && self.center.y < (HEIGHT - 100)) {// 左右靠边
        if (self.center.x < WIDTH / 2) {
            _startPoint = self.center.y < [self superview].center.y ? CGPointMake(self.frame.size.width, self.frame.origin.y + self.frame.size.height) : CGPointMake(self.frame.size.width, self.frame.origin.y);
        } else {
            _startPoint = self.center.y < [self superview].center.y ? CGPointMake(WIDTH - self.frame.size.width, self.frame.origin.y + self.frame.size.height) : CGPointMake(WIDTH - self.frame.size.width, self.frame.origin.y );
        }
    } else {// 上下靠边
        if (self.center.y < 100) {
            _startPoint = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.size.height);
        } else {
            _startPoint = CGPointMake(self.frame.origin.x + self.frame.size.width, HEIGHT - self.frame.size.height);
        }
    }
    [self.animationController transformAnimationGroupWithView:self.secondOptionsView.baseView duration:0.3 startPoint:_startPoint animationType:SK_ANIMATION_TYPE_LARGEN isFinish:^(BOOL isFinish) {
    }];
    
    self.secondOptionsView.startPoint = _startPoint;
    self.secondOptionsView.animationController = self.animationController;
}

#pragma mark - 通知

- (void)notice:(id)sender {
    NSString *isHidden = [sender userInfo][@"isHidden"];
    if ([isHidden isEqualToString:@"YES"]) {
        self.hidden = NO;
        self.alpha = 1;
        [self fadeoutTimer];
    }
}

#pragma mark - 计时器

- (void)fadeoutTimer {
    NSLog(@"开始渐隐");
    if (_quoteCount > 0) {
        NSLog(@"计时已存在，重新开始渐隐");
        _quoteCount = 0;
        dispatch_source_cancel(_timer);
    }
    _quoteCount += 1;
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    NSLog(@"开始计时");
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), DISPATCH_TIME_FOREVER, 0.1 * NSEC_PER_SEC);// 这里使用DISPATCH_TIME_FOREVER, 仅重复一次
    SKWeakSelf;
    dispatch_source_set_event_handler(_timer, ^{
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.alpha = 0.3;
            weakSelf.quoteCount -= 1;
            NSLog(@"渐隐效果完成!");
            dispatch_source_cancel(weakSelf.timer);
            NSLog(@"计时结束");
        }];
    });
    dispatch_resume(_timer);
}

@end
