//
//  CreateProductTableViewController.m
//  JobOffers
//
//  Created by Ricard Perez del Campo on 04/02/16.
//  Copyright © 2016 Ricard Perez del Campo. All rights reserved.
//

#import "CreateOfferViewController.h"

@interface CreateOfferViewController ()

typedef NS_ENUM(NSInteger, ShowingOption) {
    eShowingUndefined = 0,
    eShowingNone,
    eShowingKeyboard,
    eShowingDatePicker,
    eShowingCategoryPicker,
};

@property (nonatomic, assign) ShowingOption showingOption;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, weak) UIResponder* currentTextInput;
@property (nonatomic, weak) OfferFormTableViewController* formViewController;
@property (nonatomic, strong) UIBarButtonItem* saveButtonItem;

- (void)keyboardWillBeShown:(NSNotification*)notification;
- (void)keyboardWillBeHidden:(NSNotification*)notification;
- (void)adjustViewsForShowingOption:(ShowingOption)option animated:(BOOL)animate;

- (void)onDatePickerValueChanged:(id)sender;

- (void)onSaveButtonClicked:(id)sender;

@end

@implementation CreateOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"offer_save", nil) style:UIBarButtonItemStyleDone target:self action:@selector(onSaveButtonClicked:)];
    [self.saveButtonItem setEnabled:NO];
    [self.navigationItem setRightBarButtonItem:self.saveButtonItem animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.showingOption == eShowingUndefined)
    {
        [self adjustViewsForShowingOption:eShowingNone animated:NO];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"formViewControllerSegue"]) {
        OfferFormTableViewController* formViewController = [segue destinationViewController];
        [formViewController setDelegate:self];
        self.formViewController = formViewController;
    }
}


#pragma mark - OfferFormDelegate
- (void)onOfferFormNeedsDatePickerView:(OfferFormTableViewController *)form showingDate:(NSDate *)date
{
    [self.datePicker setDate:(date == nil ? [NSDate date] : date)];
    [self adjustViewsForShowingOption:eShowingDatePicker animated:YES];
}

-(void)textInputDidBeginEditing:(UIResponder *)responder
{
    self.currentTextInput = responder;
}

- (void)onFormValuesChanged:(OfferFormTableViewController *)form
{
    BOOL formCorrect = YES;
    NSDictionary* formData = [form getFormData];
    for (id value in [formData allValues])
    {
        if (value == nil)
        {
            formCorrect = NO;
        }
        else if ([value isKindOfClass:[NSString class]])
        {
            formCorrect = ([[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0);
        }
        
        if (!formCorrect)
        {
            break;
        }
    }
    
    [self.saveButtonItem setEnabled:formCorrect];
}


#pragma mark - Implementation
- (void)keyboardWillBeShown:(NSNotification*)notification
{
    self.keyboardHeight = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self adjustViewsForShowingOption:eShowingKeyboard animated:YES];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    [self adjustViewsForShowingOption:eShowingNone animated:YES];
}

- (void)adjustViewsForShowingOption:(ShowingOption)option animated:(BOOL)animate
{
    self.showingOption = option;
    
    CGFloat inputsViewHeightConstant = 0.0f;
    CGFloat datePickerTopConstant = self.datePicker.bounds.size.height;
    CGFloat categoryPickerViewTopConstant = self.categoryPickerView.bounds.size.height;
    
    switch (option)
    {
        case eShowingDatePicker:
            inputsViewHeightConstant = self.datePicker.bounds.size.height;
            datePickerTopConstant = 0.0f;
            [self.currentTextInput resignFirstResponder];
            self.currentTextInput = nil;
            break;
        case eShowingCategoryPicker:
            inputsViewHeightConstant = self.categoryPickerView.bounds.size.height;
            categoryPickerViewTopConstant = 0.0f;
            [self.currentTextInput resignFirstResponder];
            self.currentTextInput = nil;
            break;
        case eShowingKeyboard:
            inputsViewHeightConstant = self.keyboardHeight;
            break;
        default:
            break;
    }
    
    
    void (^animationsBlock)() = ^() {
        self.inputsViewHeightConstraint.constant = inputsViewHeightConstant;
        self.datePickerTopConstraint.constant = datePickerTopConstant;
        self.categoryPickerViewTopConstraint.constant = categoryPickerViewTopConstant;
    };
    
    if (animate)
    {
        [UIView animateWithDuration:0.5 animations:^{
            animationsBlock();
            [self.view layoutIfNeeded];
            [self.inputsView layoutIfNeeded];
        }];
    }
    else
    {
        animationsBlock();
    }
}

- (void)onDatePickerValueChanged:(id)sender
{
    [self.formViewController setSelectedDate:[self.datePicker date]];
}

- (void)onSaveButtonClicked:(id)sender
{
    NSLog(@"Save!");
}

@end
