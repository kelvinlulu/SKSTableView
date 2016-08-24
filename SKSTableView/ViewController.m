//
//  ViewController.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "ViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *contents;

@end

@implementation ViewController

- (NSArray *)contents
{
    if (!_contents)
    {
        NSMutableArray *arraySection0Row0 = [NSMutableArray arrayWithArray:@[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"]];
        NSMutableArray *arraySection0Row1 = [NSMutableArray arrayWithArray:@[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2",@"Row1_Subrow3"]];
        NSMutableArray *arraySection0Row2 = [NSMutableArray arrayWithArray:@[@"Section0_Row2"]];
        NSMutableArray *arraySection0 = [NSMutableArray arrayWithArray:@[arraySection0Row0,arraySection0Row1,arraySection0Row2]];
        NSMutableArray *arraySection1Row0 = [NSMutableArray arrayWithArray:@[@"Section1_Row0", @"Row0_Subrow1",@"Row0_Subrow2"]];
        NSMutableArray *arraySection1Row1 = [NSMutableArray arrayWithArray:@[@"Section1_Row1", @"Row1_Subrow1", @"Row1_Subrow2",@"Row1_Subrow3"]];
        NSMutableArray *arraySection1Row2 = [NSMutableArray arrayWithArray:@[@"Section1_Row2"]];
        NSMutableArray *arraySection1 = [NSMutableArray arrayWithArray:@[arraySection1Row0,arraySection1Row1,arraySection1Row2]];
        _contents = [NSMutableArray arrayWithArray:@[arraySection0,arraySection1]];
    }
    return _contents;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.SKSTableViewDelegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Collapse" style:UIBarButtonItemStylePlain target:self action:@selector(collapseSubrows)];
    [self setDataManipulationButton:UIBarButtonSystemItemRefresh];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contents[indexPath.section][indexPath.row] count] - 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        return YES;
    }
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    if ([_contents[indexPath.section][indexPath.row] count]>1)
    {
        cell.expandable = YES;
    }
    else
    {
        cell.expandable = NO;
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"delete";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.subRow == 0)
    {
        [_contents[indexPath.section] removeObjectAtIndex:indexPath.row];
    }
    else
    {
        [_contents[indexPath.section][indexPath.row] removeObjectAtIndex:indexPath.subRow];
    }
    [_tableView sks_deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

#pragma mark - Actions

- (void)collapseSubrows
{
    [self.tableView collapseCurrentlyExpandedIndexPaths];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Expand" style:UIBarButtonItemStylePlain target:self action:@selector(expandSubrows)];
}

- (void)expandSubrows
{
    [self.tableView expandAllSubrows];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Collapse" style:UIBarButtonItemStylePlain target:self action:@selector(collapseSubrows)];
}

- (void)refreshData
{
    NSMutableArray *arraySection0Row0 = [NSMutableArray arrayWithArray:@[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"]];
    NSMutableArray *arraySection0Row1 = [NSMutableArray arrayWithArray:@[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6"]];
    NSMutableArray *arraySection0Row2 = [NSMutableArray arrayWithArray:@[@"Section0_Row2"]];
    NSMutableArray *arraySection0 = [NSMutableArray arrayWithArray:@[arraySection0Row0,arraySection0Row1,arraySection0Row2]];
    
    NSMutableArray *arraySection1Row0 = [NSMutableArray arrayWithArray:@[@"Section1_Row0", @"Row0_Subrow1",@"Row0_Subrow2"]];
    NSMutableArray *arraySection1Row1 = [NSMutableArray arrayWithArray:@[@"Section1_Row1", @"Row1_Subrow1"]];
    NSMutableArray *arraySection1Row2 = [NSMutableArray arrayWithArray:@[@"Section1_Row2"]];
    NSMutableArray *arraySection1 = [NSMutableArray arrayWithArray:@[arraySection1Row0,arraySection1Row1,arraySection1Row2]];
    [self reloadTableViewWithData:[NSMutableArray arrayWithArray:@[arraySection0,arraySection1]]];
    [self setDataManipulationButton:UIBarButtonSystemItemUndo];
}

- (void)undoData
{
    [self reloadTableViewWithData:nil];
    [self setDataManipulationButton:UIBarButtonSystemItemRefresh];
}

- (void)reloadTableViewWithData:(NSMutableArray *)array
{
    self.contents = array;
    [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

#pragma mark - Helpers

- (void)setDataManipulationButton:(UIBarButtonSystemItem)item
{
    switch (item)
    {
        case UIBarButtonSystemItemUndo:
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                                                                                                  target:self
                                                                                                  action:@selector(undoData)];
            break;
        default:
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                                  target:self
                                                                                                  action:@selector(refreshData)];
            break;
    }
}

@end
