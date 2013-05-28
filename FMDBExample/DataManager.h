//
//  DataManager.h
//  FMDBExample
//
//  Created by Thuy Copeland on 5/21/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"
#import "FMDatabase.h"

@interface DataManager : NSObject

@property (strong, nonatomic) FMDatabase *database;
+ (id)sharedDatabaseManager;
- (void)checkAndCreateDatabase;
- (NSString *)getNewUUID;
- (Contact *)fetchContactWithID:(NSString *)contactID;
- (NSArray *)fetchAllContacts;
- (BOOL)saveNewContact:(Contact *)newContact;
- (BOOL)updateExistingContact:(Contact *)existingContact;
- (BOOL)deleteContact:(Contact *)contactToDelete;
@end
