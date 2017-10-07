//
//  SQAWineryModel.h
//  Baccus
//
//  Created by David Lopez Rodriguez on 07/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQAWineModel.h"

@interface SQAWineryModel : NSObject

@property (readonly, nonatomic) NSUInteger redWineCount;
@property (readonly, nonatomic) NSUInteger whiteWineCount;
@property (readonly, nonatomic) NSUInteger otherWineWineCount;

-(SQAWineModel*) redWineAtIndex: (int) index;
-(SQAWineModel*) whiteWineAtIndex: (int) index;
-(SQAWineModel*) otherWineAtIndex: (int) index;

@end
