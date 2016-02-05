//
//  OfferFormTableViewController.m
//  JobOffers
//
//  Created by Ricard Perez del Campo on 04/02/16.
//  Copyright © 2016 Ricard Perez del Campo. All rights reserved.
//

#import "OfferFormTableViewController.h"

@interface OfferFormTableViewController ()

@property (nonatomic, weak) UIButton* selectedDateButton;
@property (nonatomic, strong) NSMutableDictionary* formData;

- (void)updateFormInputs;

@end

@implementation OfferFormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputFields = [self.inputFields sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGFloat y1 = [obj1 convertPoint:self.view.frame.origin toView:nil].y;
        CGFloat y2 = [obj2 convertPoint:self.view.frame.origin toView:nil].y;
        
        return ((y1 < y2) ? NSOrderedDescending : NSOrderedAscending);
    }];
    
    self.formData = [NSMutableDictionary dictionaryWithDictionary:@{
                      @"title": @"",
                      @"description": @"",
                      @"category": @"category 1",
                      @"dateStart": [NSDate date],
                      @"dateEnd": [NSDate date],
                      @"projectName": @"",
                      @"company": @"",
                      @"address": @"",
                      }];
    [self updateFormInputs];
    
    self.descriptionTextView.layer.borderColor = [[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.delegate textInputDidBeginEditing:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSUInteger index = [self.inputFields indexOfObject:textField];
    if (index != NSNotFound)
    {
        if (index < ([self.inputFields count] - 1))
        {
            [[self.inputFields objectAtIndex:index+1] becomeFirstResponder];
        }
        else
        {
            [textField resignFirstResponder];
        }
    }
    
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString* key;
    if (textField == self.titleTextField)
    {
        key = @"title";
    }
    else if (textField == self.projectNameTextField)
    {
        key = @"projectName";
    }
    else if (textField == self.companyNameTextField)
    {
        key = @"company";
    }
    else if (textField == self.addressTextField)
    {
        key = @"address";
    }
    [self.formData setObject:[textField text] forKey:key];
    [self.delegate onFormValuesChanged:self];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.delegate textInputDidBeginEditing:textView];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self.formData setObject:[textView text] forKey:@"description"];
    [self.delegate onFormValuesChanged:self];
}

#pragma mark - Implementation
- (IBAction)onStartDateButtonClicked:(id)sender
{
    self.selectedDateButton = sender;
    [self.delegate onOfferFormNeedsDatePickerView:self showingDate:[self.formData objectForKey:@"dateStart"]];
}

- (IBAction)onEndDateButtonClicked:(id)sender
{
    self.selectedDateButton = sender;
    [self.delegate onOfferFormNeedsDatePickerView:self showingDate:[self.formData objectForKey:@"dateEnd"]];
}

- (void)setSelectedDate:(NSDate*)date
{
    NSString* currentKey = (self.selectedDateButton == self.startDateButton ? @"dateStart" : @"dateEnd");
    [self.formData setValue:date forKey:currentKey];
    [self updateFormInputs];
    [self.delegate onFormValuesChanged:self];
}

- (NSDictionary*)getFormData
{
    return self.formData;
}

- (void)updateFormInputs
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [self.titleTextField setText:[self.formData objectForKey:@"title"]];
    [self.descriptionTextView setText:[self.formData objectForKey:@"description"]];
    [self.categoryButton setTitle:[self.formData objectForKey:@"category"] forState:UIControlStateNormal];
    [self.startDateButton setTitle:[dateFormatter stringFromDate:[self.formData objectForKey:@"dateStart"]] forState:UIControlStateNormal];
    [self.endDateButton setTitle:[dateFormatter stringFromDate:[self.formData objectForKey:@"dateEnd"]] forState:UIControlStateNormal];
    [self.projectNameTextField setText:[self.formData objectForKey:@"projectName"]];
    [self.companyNameTextField setText:[self.formData objectForKey:@"company"]];
    [self.addressTextField setText:[self.formData objectForKey:@"address"]];
}

@end
