//
//  ViewController.m
//  FMDBExample
//
//  Created by Thuy Copeland on 5/21/13.
//  Copyright (c) 2013 ThuyCopeland. All rights reserved.
//

#import "ContactListViewController.h"
#import "AddEditContactViewController.h"
#import "ContactDetailsViewController.h"

@interface ContactListViewController ()

@end

@implementation ContactListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	dataMgr = [DataManager sharedDatabaseManager];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.contactsArray = [NSMutableArray arrayWithArray:[dataMgr fetchAllContacts]];
    [self.contactTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)editButtonPressed:(id)sender{
    if (self.contactTable.isEditing) {
        [self.contactTable setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStylePlain;
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
    } else {
        [self.contactTable setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleDone;
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
    }
}

#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contactsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // note: b/c we are using storyboards, we have to use UITableViewCellStyleSubtitle, not UITableViewStylDefault (which is for nib files).
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[self.contactsArray objectAtIndex:indexPath.row] name];
    cell.detailTextLabel.text = [[self.contactsArray objectAtIndex:indexPath.row] phone];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedContact = [self.contactsArray objectAtIndex:indexPath.row];
    if (self.contactTable.isEditing) {
        [self performSegueWithIdentifier:@"AddEditContact" sender:self];
    } else {
        [self performSegueWithIdentifier:@"ViwContactDetail" sender:self];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BOOL deleteResult = [dataMgr deleteContact:[self.contactsArray objectAtIndex:indexPath.row]];
        if (deleteResult) {
            self.contactsArray = [NSMutableArray arrayWithArray:[dataMgr fetchAllContacts]];
            [self.contactTable reloadData];
        }
    }
}

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddEditContact"]) {
        AddEditContactViewController *addEditViewController = segue.destinationViewController;
        if (self.selectedContact) {
            addEditViewController.aeContact = self.selectedContact;
        }
    } else if ([segue.identifier isEqualToString:@"ViewContactDetail"]) {
        ContactDetailsViewController *detailViewController = segue.destinationViewController;
        if (self.selectedContact) {
            detailViewController.contact = self.selectedContact;
        }
    }
}


@end
