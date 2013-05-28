//
//  AddEditContactViewController.h
//  FMDBExample
//
//  Created by Thuy Copeland on 5/28/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "Contact.h"

@interface AddEditContactViewController : UIViewController <UITextFieldDelegate> {
    BOOL editeMode;
}

@property (strong, nonatomic) Contact *aeContact;

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)saveButtonPressed:(id)sender;
- (void)setViewForEditMode;
- (IBAction)fieldUpdated:(UITextField*)updatedField;

@end
