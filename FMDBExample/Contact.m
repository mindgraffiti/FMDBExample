//
//  Contact.m
//  FMDBExample
//
//  Created by Thuy Copeland on 5/21/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import "Contact.h"

@implementation Contact
// weird...we're returning a string?
+ (NSString *)selectAllQuery {
    // write your sql command
    return @"SELECT * FROM Contacts ORDER BY Name ASC";
}

// not a class method (+), just an instance method (-) this time.
- (NSString *)selectByIDQuery {
    // this query is a little different, because we need to pass a property
    return [NSString stringWithFormat:@"SELECT * FROM Contacts WHERE ContactID = %@", self.contactID];
}

// insert a contact object
- (NSString *)insertQuery {
    // create a date formatter and save it as a string b/c that's what the sqlite accepts
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    NSString *dateAddedStr = [df stringFromDate:self.dateCreated];
    NSString *lastUpdatedStr = [df stringFromDate:self.lasteUpdated];
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO Contacts VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", self.contactID, self.name, self.phone, self.email, dateAddedStr, lastUpdatedStr];
    
    return query;
}

// update a contact object
- (NSString *)updateQuery {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *lastUpdatedStr = [df stringFromDate:self.lasteUpdated];
    
    NSString *query = [NSString stringWithFormat:@"UPDATE Contact SET Name = %@, Phone = %@, Email = %@, LastUpdate = %@, WHERE ContactID = %@", self.name, self.phone, self.email, lastUpdatedStr, self.contactID];
    
    return query;
}

- (NSString *)deleteQuery {
    return [NSString stringWithFormat:@"DELETE FROM Contacts WHERE ContactID = %@", self.contactID];
}
@end
