//
//  ContactDetailsViewController.h
//  FMDBExample
//
//  Created by Thuy Copeland on 5/28/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactDetailsViewController : UIViewController
@property (strong, nonatomic) Contact *contact;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateCreatedLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastUpdatedLabel;
@end
