//
//  SQAWineryViewControllerTableViewController.h
//  Baccus
//
//  Created by David Lopez Rodriguez on 07/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQAWineryModel.h"

#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

@interface SQAWineryTableViewController : UITableViewController

#pragma mark - Properties

@property (strong, nonatomic) SQAWineryModel *model;

#pragma mark - Designated Initializer

-(id) initWithModel: (SQAWineryModel*) model
              style: (UITableViewStyle) style;

@end
