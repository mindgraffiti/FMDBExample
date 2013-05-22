//
//  Contact.h
//  FMDBExample
//
//  Created by Thuy Copeland on 5/21/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (strong, nonatomic) NSString *contactID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSDate *dateCreated;
@property (strong, nonatomic) NSDate *lasteUpdated;

+ (NSString *)selectAllQuery;
- (NSString *)selectByIDQuery;
- (NSString *)insertQuery;
- (NSString *)updateQuery;
- (NSString *)deleteQuery;
@end
