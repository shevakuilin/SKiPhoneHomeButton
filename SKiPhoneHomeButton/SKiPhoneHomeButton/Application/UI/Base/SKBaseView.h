//
//  SKBaseView.h
//  SKiPhoneHomeButton
//
//  Created by ShevaKuilin on 2017/5/13.
//  Copyright © 2017年 ShevaKuilin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SK_BASEVIEW_TYPE) {
    SK_BASEVIEW_TYPE_NORMAL,// 默认格式
    SK_BASEVIEW_TYPE_DOUBLETOP,// 双顶部控件格式
    SK_BASEVIEW_TYPE_FOUR// 四控件格式
};

@interface SKBaseView : UIView

- (instancetype)initWithFrame:(CGRect)frame displayType:(SK_BASEVIEW_TYPE)displayType;

@end
