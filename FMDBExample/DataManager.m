//
//  DataManager.m
//  FMDBExample
//
//  Created by Thuy Copeland on 5/21/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import "DataManager.h"

DataManager *dMan;
static NSString *dbFileName = @"database.sqlite";

@implementation DataManager

// the point is to only run this init method once ever.
+ (id)sharedDataManager{
    @synchronized(self){
        if (dMan == nil) {
            dMan = [[self alloc] init];
        }
    }
    return dMan;
}
// to fire methods in a class without a ViewDidLoad,
// you add them to the init method.
- (id)init{
    self = [super init];
    if (self) {
        [self checkAndCreateDatabase];
    }
    return self;
}

- (void)checkAndCreateDatabase{
    // Create a bool to later check and see if the db is in the documents directory
    BOOL success;
    
    // Get the path to the documents directory and append the database name
    // 'we want the document directory inside the nsuserdomainmask'
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    /* It's unlikely you'll have more directories besides the document directory. This is how we know that it is located at the start of the array. */
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    // create your file's path
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:dbFileName];
    
    // create an instance of the file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // check to see if the db has already been created in the user's filesystem
    success = [fileManager fileExistsAtPath:dbPath];
    
    if (success) {
        // If file exists, then no action is required
    } else {
        // Get the path to the db in the application pkg
        // we're getting the path to the bundle and grabbing the file name from it.
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbFileName];
        
        // Copy the db from the pkg to the user's filesystem
        [fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
        
        NSLog(@"Finished copying from %@ to %@", databasePathFromApp, dbPath);
    }
    // the FMDatabase object is going to need to know the path to the db.
    self.database = [FMDatabase databaseWithPath:dbPath];
}

// method to create our UUID
- (NSString *)getNewUUID {
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    
    // convert CFStringRef to NSString directly by using __bridge
    // this is just memory management.
    return (__bridge NSString *)string;
}

- (BOOL)saveNewContact:(Contact *)newContact {
    BOOL success = NO;
    if (newContact) {
        newContact.contactID = [self getNewUUID];
        newContact.dateCreated = [NSDate date];
        newContact.lasteUpdated = [NSDate date];
        
        NSString *query = [newContact insertQuery];
        success = [self.database executeQuery:query];
    }
    return success;
}


@end
