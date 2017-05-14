//
//  SKBaseView.m
//  SKiPhoneHomeButton
//
//  Created by ShevaKuilin on 2017/5/13.
//  Copyright © 2017年 ShevaKuilin. All rights reserved.
//

#import "Tool.h"
#import "SKBaseView.h"

@interface SKBaseView ()

@property (nonatomic, strong, readwrite) UIView *baseView;
@property (nonatomic, strong, readwrite) UIButton *centerBackButton;
@property (nonatomic, strong, readwrite) UIButton *topButton;
@property (nonatomic, strong, readwrite) UIButton *leftButton;
@property (nonatomic, strong, readwrite) UIButton *rightButton;
@property (nonatomic, strong, readwrite) UIButton *bottomButton;
@property (nonatomic, strong, readwrite) UIButton *letfMobileButton;
@property (nonatomic, strong, readwrite) UIButton *rightMobileButton;

@end

@implementation SKBaseView

- (instancetype)initWithFrame:(CGRect)frame displayType:(SK_BASEVIEW_TYPE)displayType {
    self = [super init];
    if (self) {
        self.frame = frame;
        [self setBaseUI];
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
    self.baseView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
    self.baseView.layer.masksToBounds = YES;
    self.baseView.layer.cornerRadius = 10;
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
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
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(15);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topButton.mas_bottom).offset(-15);
        make.left.equalTo(self).offset(25);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topButton.mas_bottom).offset(-15);
        make.right.equalTo(self).offset(-25);
    }];
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-15);
    }];
}

#pragma mark - 顶部双控件格式UI

- (void)setDoubleTopUI {
    
}


#pragma mark - 四控件格式UI

- (void)setFourUI {
    
}

@end
