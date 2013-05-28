//
//  Contact.m
//  FMDBExample
//
//  Created by Thuy Copeland on 5/21/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import "Contact.h"

@implementation Contact

#pragma mark - Set Contact with FMResultSet
- (void)populateWithFMResultSet:(FMResultSet *)resultSet{
    self.contactID = [resultSet stringForColumn:@"ContactID"];
    self.name = [resultSet stringForColumn:@"Name"];
    self.phone = [resultSet stringForColumn:@"Phone"];
    self.email = [resultSet stringForColumn:@"Email"];
    self.dateCreated = [resultSet dateForColumn:@"DateCreated"];
    self.lastUpdated = [resultSet dateForColumn:@"LastUpdated"];
}


#pragma mark - Convenience Methods
// setting up queries

// weird...we're returning a string?
+ (NSString *)selectAllQuery {
    // write your sql command
    return @"SELECT * FROM Contacts ORDER BY Name ASC";
}

// not a class method (+), just an instance method (-) this time.
+ (NSString *)selectByIDQuery:(NSString *)cID {
    // this query is a little different, because we need to pass a property
    return [NSString stringWithFormat:@"SELECT * FROM Contacts WHERE ContactID = '%@'", cID];
}

// insert a contact object
- (NSString *)insertQuery {
    // create a date formatter and save it as a string b/c that's what the sqlite accepts
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    NSString *dateAddedStr = [df stringFromDate:self.dateCreated];
    NSString *lastUpdatedStr = [df stringFromDate:self.lastUpdated];
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO Contacts VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", self.contactID, self.name, self.phone, self.email, dateAddedStr, lastUpdatedStr];
    
    return query;
}

// update a contact object
- (NSString *)updateQuery {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *lastUpdatedStr = [df stringFromDate:self.lastUpdated];
    
    NSString *query = [NSString stringWithFormat:@"UPDATE Contact SET Name = %@, Phone = %@, Email = %@, LastUpdate = %@, WHERE ContactID = %@", self.name, self.phone, self.email, lastUpdatedStr, self.contactID];
    
    return query;
}

- (NSString *)deleteQuery {
    return [NSString stringWithFormat:@"DELETE FROM Contacts WHERE ContactID = %@", self.contactID];
}

#pragma mark fetch methods
// running the queries 
+ (NSArray *)fetchAllContacts:(FMDatabase *)database{
    NSMutableArray *results = [NSMutableArray new];
    
    if (database != nil) {
        // open the db
        [database open];
        
        // get the query
        NSString *query = [Contact selectAllQuery];
        
        // execute the query and get results
        FMResultSet *fetchResults = [database executeQuery:query];
        
        // iterate thru the results
        while ([fetchResults next]) {
            // create contact
            Contact *fetchedContact = [Contact new];
            
            // populate with result
            [fetchedContact populateWithFMResultSet:fetchResults];
            
            // add contact to results array
            [results addObject:fetchedContact];
        }
        // close db
        [database close];
    }
    return results;
}

+ (Contact *)fetchContactByID:(NSString *)cID dataBase:(FMDatabase *)database{
    Contact *fetchedContact = [Contact new];
    
    if (database != nil) {
        // open the db
        [database open];
        
        // get the query string
        NSString *query = [Contact selectByIDQuery:cID];
        
        //execute the query and get results
        FMResultSet *fetchResults = [database executeQuery:query];
        
        while ([fetchResults next]) {
            // populate with result
            [fetchedContact populateWithFMResultSet:fetchResults];
        }
        
        // close the db
        [database close];
    }
    return fetchedContact;
}

#pragma mark Data Manipulation Langauge (DML) query convenience methods
// Used for running Insert/Update/Delete
- (BOOL)runDMLQuery:(NSString*)query database:(FMDatabase*)database {
    BOOL success = NO;
    if (query != nil && database != nil) {
        // Open the database
        [database open];
        
        // Execute Query and get result
        success = [database executeUpdate:query];
        
        // Close the database
        [database close];
        
    }
    return success;
}

#pragma mark insert method
- (BOOL)insert:(FMDatabase *)database{
    BOOL inserted = NO;
    // get the query string
    NSString *query = [self insertQuery];
    // run the query
    inserted = [self runDMLQuery:query database:database];
    // return result
    return inserted;
}

#pragma mark update method
- (BOOL)update:(FMDatabase*)database{
    BOOL updated = NO;
    NSString *query = [self updateQuery];
    updated = [self runDMLQuery:query database:database];
    return updated;
}

#pragma mark delete method
- (BOOL)delete:(FMDatabase *)database{
    BOOL deleted = NO;
    NSString *query = [self deleteQuery];
    deleted = [self runDMLQuery:query database:database];
    return deleted;
}
@end
