//
//  SKBaseView.m
//  SKiPhoneHomeButton
//
//  Created by ShevaKuilin on 2017/5/13.
//  Copyright © 2017年 ShevaKuilin. All rights reserved.
//

#import "Tool.h"
#import "SKBaseOptionsView.h"

@interface SKBaseOptionsView ()

@property (nonatomic, strong, readwrite) UIVisualEffectView *effectView;
@property (nonatomic, strong, readwrite) UIButton *centerBackButton;
@property (nonatomic, strong, readwrite) UIButton *topButton;
@property (nonatomic, strong, readwrite) UIButton *leftButton;
@property (nonatomic, strong, readwrite) UIButton *rightButton;
@property (nonatomic, strong, readwrite) UIButton *bottomButton;
@property (nonatomic, strong, readwrite) UIButton *letfMobileButton;
@property (nonatomic, strong, readwrite) UIButton *rightMobileButton;

@property (nonatomic, assign, readwrite) CGPoint homeBtnPoint;

@end

@implementation SKBaseOptionsView

- (instancetype)initWithFrame:(CGRect)frame displayType:(SK_BASEVIEW_TYPE)displayType homeBtnPoint:(CGPoint)homeBtnPoint {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.homeBtnPoint = homeBtnPoint;
        [self setBaseUI];
        [self setGesture];
        switch (displayType) {
            case SK_BASEVIEW_TYPE_NORMAL:
                [self setNormalUI];
                break;
            case SK_BASEVIEW_TYPE_DOUBLETOP:
                [self setDoubleTopUI];
                break;
            case SK_BASEVIEW_TYPE_FOUR:
                [self setFourUI];
                break;
            default:
                [self setNormalUI];
                break;
        }
    }
    return self;
}

#pragma mark - 基础UI

- (void)setBaseUI {
    self.baseView = [UIView new];
    [self addSubview:self.baseView];
    self.baseView.backgroundColor = [UIColor blackColor];
    self.baseView.alpha = 0.8;
    self.baseView.layer.masksToBounds = YES;
    self.baseView.layer.cornerRadius = 10;
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_offset(CGSizeMake(280, 280));
    }];
    
    
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self.baseView addSubview:self.effectView];
    self.effectView.layer.masksToBounds = YES;
    self.effectView.layer.cornerRadius = 10;
    self.effectView.userInteractionEnabled = YES;
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.baseView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.topButton = [UIButton new];
    [self.baseView addSubview:self.topButton];
    [self.topButton setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [self.topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60, 80));
    }];
    
    self.leftButton = [UIButton new];
    [self.baseView addSubview:self.leftButton];
    [self.leftButton setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60, 80));
    }];

    self.rightButton = [UIButton new];
    [self.baseView addSubview:self.rightButton];
    [self.rightButton setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60, 80));
    }];
    
    self.bottomButton = [UIButton new];
    [self.baseView addSubview:self.bottomButton];
    [self.bottomButton setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60, 80));
    }];
    
    self.letfMobileButton = [UIButton new];
    [self.baseView addSubview:self.letfMobileButton];
    [self.letfMobileButton setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [self.letfMobileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60, 80));
    }];

    self.rightMobileButton = [UIButton new];
    [self.baseView addSubview:self.rightMobileButton];
    [self.rightMobileButton setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [self.rightMobileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60, 80));
    }];
}

#pragma mark - 默认格式UI

- (void)setNormalUI {
    [self.topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.baseView);
        make.top.equalTo(self.baseView).offset(15);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topButton.mas_bottom).offset(-15);
        make.left.equalTo(self.baseView).offset(25);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topButton.mas_bottom).offset(-15);
        make.right.equalTo(self.baseView).offset(-25);
    }];
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.effectView);
        make.bottom.equalTo(self.baseView).offset(-15);
    }];
}

#pragma mark - 顶部双控件格式UI

- (void)setDoubleTopUI {
    
}


#pragma mark - 四控件格式UI

- (void)setFourUI {
    
}

#pragma mark - 手势

- (void)setGesture {
    UITapGestureRecognizer *clickScreenGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    [self addGestureRecognizer:clickScreenGesture];
    
    UITapGestureRecognizer *clickSelfGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    [self.baseView addGestureRecognizer:clickSelfGesture];
}

- (void)hidden {
    [self.animationController transformAnimationGroupWithView:self.baseView duration:0.3 startPoint:_startPoint animationType:SK_ANIMATION_TYPE_SHRINK isFinish:^(BOOL isFinish) {
        if (isFinish) {
            NSNotification * notice = [NSNotification notificationWithName:@"hiddenSecondView" object:nil userInfo:@{@"isHidden":@"YES"}];
            [[NSNotificationCenter defaultCenter] postNotification:notice];
        }
    }];
}

@end
