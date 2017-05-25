//
//  ViewController.m
//  SKiPhoneHomeButton
//
//  Created by ShevaKuilin on 2017/5/13.
//  Copyright © 2017年 ShevaKuilin. All rights reserved.
//

#import "SKHomeButton.h"
#import "ViewController.h"
#import "SKHomeButtonModel.h"

@interface ViewController ()

@property (nonatomic, strong, readwrite) SKHomeButton *homeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHomeButtom];
//    [self setGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setHomeButtom {
    self.homeButton = [[SKHomeButton alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    [self.view addSubview:self.homeButton];
}


@end
