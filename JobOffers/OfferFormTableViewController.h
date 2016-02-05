//
//  OfferFormTableViewController.h
//  JobOffers
//
//  Created by Ricard Perez del Campo on 04/02/16.
//  Copyright © 2016 Ricard Perez del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OfferFormTableViewController;

@protocol OfferFormDelegate <NSObject>

- (void)onOfferFormNeedsDatePickerView:(OfferFormTableViewController*)form showingDate:(NSDate*)date;
- (void)textInputDidBeginEditing:(UIResponder*)responder;
- (void)onFormValuesChanged:(OfferFormTableViewController*)form;

@end

@interface OfferFormTableViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) IBOutletCollection(UIResponder) NSArray* inputFields;

@property (nonatomic, strong) IBOutlet UITextField* titleTextField;
@property (nonatomic, strong) IBOutlet UITextView* descriptionTextView;
@property (nonatomic, strong) IBOutlet UIButton* categoryButton;
@property (nonatomic, strong) IBOutlet UIButton* startDateButton;
@property (nonatomic, strong) IBOutlet UIButton* endDateButton;
@property (nonatomic, strong) IBOutlet UITextField* projectNameTextField;
@property (nonatomic, strong) IBOutlet UITextField* companyNameTextField;
@property (nonatomic, strong) IBOutlet UITextField* addressTextField;

@property (nonatomic, weak) NSObject<OfferFormDelegate>* delegate;

- (IBAction)onStartDateButtonClicked:(id)sender;
- (IBAction)onEndDateButtonClicked:(id)sender;

- (void)setSelectedDate:(NSDate*)date;

- (NSDictionary*)getFormData;

@end
