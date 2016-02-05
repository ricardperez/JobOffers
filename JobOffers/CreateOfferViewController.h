//
//  CreateProductTableViewController.h
//  JobOffers
//
//  Created by Ricard Perez del Campo on 04/02/16.
//  Copyright © 2016 Ricard Perez del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfferFormTableViewController.h"

@interface CreateOfferViewController : UIViewController <OfferFormDelegate>

@property (nonatomic, strong) IBOutlet UIViewController* childViewController;
@property (nonatomic, strong) IBOutlet UIView* inputsView;

@property (nonatomic, strong) IBOutlet UIDatePicker* datePicker;
@property (nonatomic, strong) IBOutlet UIPickerView* categoryPickerView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint* inputsViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint* datePickerTopConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint* categoryPickerViewTopConstraint;

@end
