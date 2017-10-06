//
//  SQAWineModel.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 03/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "SQAWineModel.h"

#define NO_RATING -1

@implementation SQAWineModel

#pragma mark - Constructores de conveniencia

+(id) wineWithName: (NSString *) name
              type: (NSString *) type
             photo: (UIImage *) photo
   wineCompanyName: (NSString *) wineCompanyName
    wineCompanyWeb: (NSURL *) wineCompanyWeb
             notes: (NSString *) notes
            origin: (NSString *) origin
            rating: (int) rating
            grapes: (NSArray *) grapes {
    
    return [[self alloc] initWithName:name
                                 type:type
                                photo:photo
                      wineCompanyName:wineCompanyName
                       wineCompanyWeb:wineCompanyWeb
                                notes:notes
                               origin:origin
                               rating:rating
                               grapes:grapes];
}

+(id) wineWithName: (NSString *) name
              type: (NSString *) type
   wineCompanyName: (NSString *) wineCompanyName
            origin: (NSString *) origin {
    
    return [[self alloc] initWithName:name
                                 type:type
                      wineCompanyName:wineCompanyName
                               origin:origin];
}

#pragma mark - Init

// Designado
-(id) initWithName: (NSString *) name
              type: (NSString *) type
             photo: (UIImage *) photo
   wineCompanyName: (NSString *) wineCompanyName
    wineCompanyWeb: (NSURL *) wineCompanyWeb
             notes: (NSString *) notes
            origin: (NSString *) origin
            rating: (int) rating
            grapes: (NSArray *) grapes {
    
    if (self = [super init]) {
        _name = name;
        _type = type;
        _photo = photo;
        _wineCompanyName = wineCompanyName;
        _wineCompanyWeb = wineCompanyWeb;
        _notes = notes;
        _origin = origin;
        _rating = rating;
        _grapes = grapes;
    }
    
    return self;
}

-(id) initWithName: (NSString *) name
              type: (NSString *) type
   wineCompanyName: (NSString *) wineCompanyName
            origin: (NSString *) origin {
    
    return [self initWithName:name
                         type:type
                        photo:nil
              wineCompanyName:wineCompanyName
               wineCompanyWeb:nil
                        notes:@""
                       origin:@""
                       rating:NO_RATING
                       grapes:nil];
}

@end
