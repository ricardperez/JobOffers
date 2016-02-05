//
//  ViewController.h
//  JobOffers
//
//  Created by Ricard Perez del Campo on 04/02/16.
//  Copyright © 2016 Ricard Perez del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView* menuView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint* menuPositionXConstraint;

- (IBAction)onMenuAction:(id)sender;

@end

