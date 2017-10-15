//
//  SQAWineryViewControllerTableViewController.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 07/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "SQAWineryTableViewController.h"
#import "SQAWineViewController.h"

@interface SQAWineryTableViewController ()

@end

@implementation SQAWineryTableViewController

#pragma mark - Designated Initializer

-(id) initWithModel: (SQAWineryModel*) model
              style: (UITableViewStyle) style {
    if (self = [super initWithStyle:style]) {
        _model = model;
        _model.delegate = self;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.model || !self.model.isLoaded) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.hidesWhenStopped = YES;
        indicator.frame = CGRectMake(self.view.frame.size.width / 2 - 37 / 2, self.view.frame.size.height / 2 - 37 / 2, 37, 37);
        [indicator startAnimating];
        
        // como descendemos de UITableViewController nos da muy poca flexibilidad a la hora de añadir subvistas, lo añadimos como cabecera de la tabla
        self.tableView.tableHeaderView = indicator;
        
        [self performSelector:@selector(loadModel) withObject:nil afterDelay:0.1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods

- (void)loadModel {
    self.model = [[SQAWineryModel alloc] init];
    self.model.delegate = self;
    
    [self.model load];
}

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
    
    SQAWineModel *wine = [self wineAtIndexPath:indexPath];
    
    UITableViewCell *wineCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UITableViewCell *cell =   [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (wineCell == nil) {
        // La creamos de cero
        wineCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // aplicamos diseño
        wineCell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
        wineCell.textLabel.backgroundColor = [UIColor clearColor];
        wineCell.detailTextLabel.backgroundColor = [UIColor clearColor];
        wineCell.textLabel.font = [UIFont fontWithName:@"Valentina-Regular" size:18];
        wineCell.detailTextLabel.font = [UIFont fontWithName:@"Valentina-Regular" size:16];
    }
    
    wineCell.imageView.image = [UIImage imageNamed:@"cell_icon_bg.png"];
    // Sincronizamos modelo con vista (celda)
    [wine photoWithBlock:^(UIImage *image) {
        if (image != nil) {
            wineCell.imageView.image = image;
        }
    }];
    
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
    [self saveLastSelectedWineAtSection:indexPath.section row:indexPath.row];
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
    }
    
    NSNotification *notification = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME
                                                                 object:self
                                                               userInfo:@{WINE_KEY: wine}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // devolvemos el tamaño al mismo que el background que hemos puesto
    return 72;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // devolvemos el tamaño de la imagen de la cabecera
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SQAWineModel *wine = [self wineAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    UIImageView *backgroundHeader = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"sectionBackground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
    [backgroundHeader setContentMode: UIViewContentModeScaleAspectFill];
    [headerView addSubview:backgroundHeader];
    [headerView setContentMode:UIViewContentModeScaleAspectFill];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width - 10, 30)];
    name.font = [UIFont fontWithName:@"Valentina-Regular" size:20];
    name.textColor = [UIColor whiteColor];
    name.text = wine.type;
    name.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:name];
    
    return headerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - WineryDelegate

-(void) wineryDidLoad:(SQAWineryModel *)winery {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableView.tableHeaderView = nil;
        [self.tableView reloadData];
        
        SQAWineModel *wine = [self lastSelectedWine];
        
        [self.delegate wineryTableViewController:self didSelectWine:wine];
                   
        NSNotification *notification = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME
                                                                    object:self
                                                                  userInfo:@{WINE_KEY: wine}];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    });    
}

#pragma mark - UISplitViewControllerDelegate

-(void)splitViewController:(UISplitViewController *)svc
   willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode {
    UINavigationController *nvc = (UINavigationController *)[[svc viewControllers] lastObject];
    
    switch (displayMode) {
            // The split view controller automatically decides the most appropriate
            // display mode based on the device and the current app size.
        case UISplitViewControllerDisplayModeAutomatic:
            break;
            
            // The primary view controller is hidden.
        case UISplitViewControllerDisplayModePrimaryHidden:
            nvc.navigationItem.rightBarButtonItem = svc.displayModeButtonItem;
            nvc.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
            break;
            
            // The primary and secondary view controllers are displayed side-by-side onscreen.
        case UISplitViewControllerDisplayModeAllVisible:
            nvc.navigationItem.rightBarButtonItem = nil;
            break;
            
            // The primary view controller is layered on top of the secondary
            // view controller, leaving the secondary view controller partially visible.
        case UISplitViewControllerDisplayModePrimaryOverlay:
            break;
    }
}

// Asks the delegate to adjust the primary view controller and to incorporate the secondary view controller into the collapsed interface. Returning NO tells the split view controller to use its default behavior to try and incorporate the secondary view controller into the collapsed interface.
-(BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
 ontoPrimaryViewController:(UIViewController *)primaryViewController {
    // Always collapse detail view
    return YES;
}

- (UIViewController *)splitViewController:(UISplitViewController *)svc
separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
    SQAWineViewController *wineVC = nil;
    SQAWineryTableViewController *wineryVC = nil;
    
    if ([primaryViewController isKindOfClass:[UINavigationController class]]) {
        for (UIViewController *controller in [(UINavigationController *)primaryViewController viewControllers]) {
            if ([controller isKindOfClass:[SQAWineryTableViewController class]]) {
                wineryVC = (SQAWineryTableViewController *)controller;
            }
            
            if ([controller isKindOfClass:[SQAWineViewController class]]) {
                wineVC = (SQAWineViewController *)controller;
            }
        }
    }
    
    if (wineVC == nil) {
        wineVC = [[SQAWineViewController alloc] initWithModel:[wineryVC lastSelectedWine]];
    }
    
    [(UINavigationController *)primaryViewController popToRootViewControllerAnimated:NO];
    
    // Set Delates
    [wineryVC setDelegate:wineVC];
    //[splitViewController setDelegate:wineVC];
    
    return [[UINavigationController alloc] initWithRootViewController:wineVC];
}

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
