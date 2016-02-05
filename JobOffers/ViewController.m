//
//  ViewController.m
//  JobOffers
//
//  Created by Ricard Perez del Campo on 04/02/16.
//  Copyright © 2016 Ricard Perez del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL showingMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (!self.showingMenu)
    {
        self.menuPositionXConstraint.constant = -self.menuView.bounds.size.width;
    }
}

- (void)onMenuAction:(id)sender
{
    self.showingMenu = !self.showingMenu;
    CGFloat constant = (self.showingMenu ? 0.0 : (-self.menuView.bounds.size.width));
    
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.menuPositionXConstraint.constant = constant;
        [self.view layoutIfNeeded];
    }];
}

@end
