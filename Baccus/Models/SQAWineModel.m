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

// Cuando creas una propiedad de solo lectura e implementas un getter personalizado,
// como estamos haciendo con photo, el compilador DA POR HECHO QUE NO VAS A NECESITAR
// UNA VARIABLE DE INSTANCIA.
// En este caso no es así, y si que necesitamos la variable de instancia, así que hay que
// obligarle a que la incluya. Esto se hace con @synthesize con la que le indicamos que
// queremos una propiedad llamada photo con una variable de instancia llamada _photo.
// @synthesize photo = _photo;

#pragma mark - Properties

-(UIImage *) photo {
    // Esto es bloqueante. Hay que usar blocks y Grand Central Dispatch (GCD) para
    // cargarlo en segundo plano.
    
    if (_photo == nil && _photoURL != nil) {
        _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
    }
    
    return _photo;
}

#pragma mark - Convenience constructors

+(id) wineWithName: (NSString *) name
              type: (NSString *) type
          photoURL: (NSURL *) photoURL
   wineCompanyName: (NSString *) wineCompanyName
    wineCompanyWeb: (NSURL *) wineCompanyWeb
             notes: (NSString *) notes
            origin: (NSString *) origin
            rating: (int) rating
            grapes: (NSArray<NSString *> *) grapes {
    
    return [[self alloc] initWithName:name
                                 type:type
                             photoURL:photoURL
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

#pragma mark - Designated Initalizers

-(id) initWithName: (NSString *) name
              type: (NSString *) type
          photoURL: (NSURL *) photoURL
   wineCompanyName: (NSString *) wineCompanyName
    wineCompanyWeb: (NSURL *) wineCompanyWeb
             notes: (NSString *) notes
            origin: (NSString *) origin
            rating: (int) rating
            grapes: (NSArray<NSString *> *) grapes {
    
    if (self = [super init]) {
        _name = name;
        _type = type;
        _photoURL = photoURL;
        _wineCompanyName = wineCompanyName;
        _wineCompanyWeb = wineCompanyWeb;
        _notes = notes;
        _origin = origin;
        _rating = rating;
        _grapes = grapes;
    }
    
    return self;
}

#pragma mark - Convenience Initializers

-(id) initWithName: (NSString *) name
              type: (NSString *) type
   wineCompanyName: (NSString *) wineCompanyName
            origin: (NSString *) origin {
    
    return [self initWithName:name
                         type:type
                     photoURL:nil
              wineCompanyName:wineCompanyName
               wineCompanyWeb:nil
                        notes:@""
                       origin:@""
                       rating:NO_RATING
                       grapes:nil];
}

-(id) initWithDictionary:(NSDictionary *)dic {
    return [self initWithName:[dic objectForKey:@"name"]
                         type:[dic objectForKey:@"type"]
                     photoURL:[NSURL URLWithString:[dic objectForKey:@"picture"]]
              wineCompanyName:[dic objectForKey:@"wineCompanyName"]
               wineCompanyWeb:[NSURL URLWithString:[dic objectForKey:@"wineCompanyWeb"]]
                        notes:[dic objectForKey:@"notes"]
                       origin:[dic objectForKey:@"origin"]
                       rating:[[dic objectForKey:@"rating"] intValue]
                       grapes:[self extractGrapesFromJSONArray:[dic objectForKey:@"grapes"]]];
}

-(NSDictionary*) proxyForJSON{
    return @{@"name"            : self.name,
             @"type"            : self.type,
             @"picture"         : [self.photoURL path],
             @"wineCompanyName" : self.wineCompanyName,
             @"wineCompanyWeb"  : self.wineCompanyWeb,
             @"notes"           : self.notes,
             @"origin"          : self.origin,
             @"rating"          : @(self.rating),
             @"grapes"          : self.grapes};
}

- (NSString *) description {
    return [NSString stringWithFormat:@"Name: %@\nCompany name: %@\nType: %@\nOrigin: %@", self.name, self.wineCompanyName, self.type, self.origin];
};

#pragma mark - Helpers

-(NSArray<NSString *> *) extractGrapesFromJSONArray: (NSArray *) JSONArray {
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for (NSDictionary *dic in JSONArray) {
        [grapes addObject:[dic objectForKey:@"grape"]];
    }
    
    return grapes;
}

-(NSArray *) packGrapesIntoJSONArray {
    NSMutableArray *jsonArray = [NSMutableArray arrayWithCapacity:[self.grapes count]];
    
    for (NSString *grape in self.grapes) {
        [jsonArray addObject:@{@"grape" : grape}];
    }
    
    return jsonArray;
}

@end
