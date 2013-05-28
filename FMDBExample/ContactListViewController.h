//
//  ViewController.h
//  FMDBExample
//
//  Created by Thuy Copeland on 5/21/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "Contact.h"

@interface ContactListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    DataManager *dataMgr;
}

@property (nonatomic, retain) NSMutableArray *contactsArray;
@property (nonatomic, retain) IBOutlet UITableView *contactTable;
@property (nonatomic, retain) Contact *selectedContact;

@end
