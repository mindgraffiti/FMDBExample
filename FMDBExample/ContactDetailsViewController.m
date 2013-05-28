//
//  ContactDetailsViewController.m
//  FMDBExample
//
//  Created by Thuy Copeland on 5/28/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import "ContactDetailsViewController.h"
#import "AddEditContactViewController.h"

@interface ContactDetailsViewController ()

@end

@implementation ContactDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setViewForContactDetails];
}

- (void)setViewForContactDetails {
    if (self.contact) {
        self.nameLabel.text = self.contact.name;
        self.numberLabel.text = self.contact.phone;
        self.emailLabel.text = self.contact.email;
        
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"MM/dd/yyyy 'at'  hh:mm"];
        
        self.dateCreatedLabel.text = [df stringFromDate:self.contact.dateCreated];
        self.lastUpdatedLabel.text = [df stringFromDate:self.contact.lastUpdated];
    }
}
#pragma mark - Seque Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditContactFromDetail"]) {
        AddEditContactViewController *addEditViewController = segue.destinationViewController;
        if (self.contact) {
            addEditViewController.aeContact = self.contact;
        }
    }
}


@end
