//
//  SQAWineryViewControllerTableViewController.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 07/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "SQAWineryTableViewController.h"
#import "SQAWineViewController.h"
#import "SQAWineModel.h"
#import "SQAWineryModel.h"

@interface SQAWineryTableViewController ()

@end

@implementation SQAWineryTableViewController

#pragma mark - Designated Initializer

-(id) initWithModel: (SQAWineryModel*) model
              style: (UITableViewStyle) style {
    if (self = [super initWithStyle:style]) {
        _model = model;
        self.title = @"Baccus";
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods

-(void) saveLastSelectedWineAtSection:(NSUInteger)section row:(NSUInteger)row {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{SECTION_KEY : @(section), ROW_KEY : @(row)} forKey:LAST_WINE_KEY];
    [defaults synchronize];
}

-(SQAWineModel *) lastSelectedWine {
    NSIndexPath *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_KEY];
    
    if (coords == nil) {
        coords = [self setDefaults];
    }
    
    indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey: ROW_KEY] integerValue]
                                   inSection:[[coords objectForKey: SECTION_KEY] integerValue]];
    
    return [self wineAtIndexPath: indexPath];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case RED_WINE_SECTION:
            return self.model.redWineCount;
        
        case WHITE_WINE_SECTION:
            return self.model.whiteWineCount;
            
        default:
            return self.model.otherWineCount;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"WineCell";
    
    UITableViewCell *wineCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UITableViewCell *cell =   [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (wineCell == nil) {
        wineCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    SQAWineModel *wine = [self wineAtIndexPath:indexPath];
    
    wineCell.imageView.image = wine.photo;
    wineCell.textLabel.text = wine.name;
    wineCell.detailTextLabel.text = wine.wineCompanyName;
    
    return wineCell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = nil;
    
    switch (section) {
        case RED_WINE_SECTION:
            sectionName = @"Tinto";
            break;
        case WHITE_WINE_SECTION:
            sectionName = @"Blanco";
            break;
        default:
            sectionName = @"Otros";
            break;
    }
    
    return sectionName;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SQAWineModel *wine = [self wineAtIndexPath:indexPath];
    
    // A Boolean value indicating whether only one of the child view
    // controllers is displayed.
    if (self.splitViewController.collapsed) {
        // Option 1: Own UINavigationController (Auto-Delegate)
        // Push the view controller.
        SQAWineViewController *wineVC = [[SQAWineViewController alloc] initWithModel:wine];
        [self.navigationController pushViewController:wineVC animated:YES];
    }
    else {
        // Option 2: iPad - UISplitViewController
        // Usually we send the message through delegate and a notification.
        // Send message to delegate
        [self.delegate wineryTableViewController:self didSelectWine:wine];
        [self saveLastSelectedWineAtSection:indexPath.section row:indexPath.row];
    }
    
    NSNotification *notification = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME
                                                                 object:self
                                                               userInfo:@{WINE_KEY: wine}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Helpers

-(SQAWineModel*) wineAtIndexPath:(NSIndexPath *)indexPath {
    SQAWineModel *wine = nil;
    switch (indexPath.section) {
        case RED_WINE_SECTION:
            wine = [self.model redWineAtIndex:indexPath.row];
            break;
        case WHITE_WINE_SECTION:
            wine = [self.model whiteWineAtIndex:indexPath.row];
            break;
        default:
            wine = [self.model otherWineAtIndex:indexPath.row];
            break;
    }
    return wine;
}

-(NSDictionary *)setDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *defaultWineCoords = @{SECTION_KEY : @(RED_WINE_SECTION), ROW_KEY : @0};
    
    [defaults setObject:defaultWineCoords forKey:LAST_WINE_KEY];
    [defaults synchronize];
    
    return defaultWineCoords;
}

@end
