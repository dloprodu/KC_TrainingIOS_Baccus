//
//  SQAWineryModel.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 07/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "SQAWineryModel.h"

@interface SQAWineryModel ()

@property (strong, nonatomic) NSArray *redWines;
@property (strong, nonatomic) NSArray *whiteWines;
@property (strong, nonatomic) NSArray *otherWines;

@end

@implementation SQAWineryModel

#pragma mark - Properties

-(NSUInteger) redWineCount {
    return [self.redWines count];
}

-(NSUInteger) whiteWineCount {
    return [self.whiteWines count];
}

-(NSUInteger) otherWineCount {
    return [self.otherWines count];
}

#pragma mark - Initializers

-(id)init {
    if (self = [super init]) {
        SQAWineModel *tintorro = [SQAWineModel wineWithName:@"Bembibre"
                                                       type:@"tinto"
                                                      photo:[UIImage imageNamed:@"bembibre.jpg"]
                                            wineCompanyName:@"Dominio de Tares"
                                             wineCompanyWeb:[NSURL URLWithString:@"https://www.dominiodetares.com/index.php/es/vinos/baltos/74-bembibrevinos"]
                                                      notes:@"Este vino muestra toda la complejidad y la elegancia de la variedad Mencía. En fase visual luce un color rojo picota muy cubierto con tonalidades violáceas en el menisco. En nariz aparecen recuerdos frutales muy intensos de frutas rojas (frambuesa, cereza) y una potente ciruela negra, así como tonos florales de la gama de las rosas y violetas, vegetales muy elegantes y complementarios, hojarasca verde, tabaco y maderas aromáticas (sándalo) que le brindan un toque ciertamente perfumado."
                                                     origin:@"El Bierzo"
                                                     rating:5
                                                     grapes:@[@"Mencía"]];
        
        SQAWineModel *albarinno = [SQAWineModel wineWithName:@"Zárate"
                                                        type:@"white"
                                                       photo:[UIImage imageNamed:@"zarate.gif"]
                                             wineCompanyName:@"Zárate"
                                              wineCompanyWeb:[NSURL URLWithString:@"http://www.albarino-zarate.com"]
                                                       notes:@"El albariño Zarate es un vino blanco monovarietal que pertenece a la Denominación de Origen Rías Baixas. Considerado por la crítica especializada como uno de los grandes vinos blancos del mundo, el albariño ya es todo un mito."
                                                      origin:@"Rias Bajas"
                                                      rating:4
                                                      grapes:@[@"Albariño"]];
        
        SQAWineModel *champagne = [SQAWineModel wineWithName:@"Comtes de Champagne"
                                                        type:@"other"
                                                       photo:[UIImage imageNamed:@"comtesDeChampagne.jpg"]
                                             wineCompanyName:@"Champagne Taittinger"
                                              wineCompanyWeb:[NSURL URLWithString:@"http://www.taittinger.fr"]
                                                       notes:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc purus. Curabitur eu velit mauris. Curabitur magna nisi, ullamcorper ac bibendum ac, laoreet et justo. Praesent vitae tortor quis diam luctus condimentum. Suspendisse potenti. In magna elit, interdum sit amet facilisis dictum, bibendum nec libero. Maecenas pellentesque posuere vehicula. Vivamus eget nisl urna, quis egestas sem. Vivamus at venenatis quam. Sed eu nulla a orci fringilla pulvinar ut eu diam. Morbi nibh nibh, bibendum at laoreet egestas, scelerisque et nisi. Donec ligula quam, semper nec bibendum in, semper eget dolor. In hac habitasse platea dictumst. Maecenas adipiscing semper rutrum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;"
                                                      origin:@"Champagne"
                                                      rating:5
                                                      grapes:@[@"Chardonnay"]];
        
        _redWines = @[tintorro];
        _whiteWines = @[albarinno];
        _otherWines = @[champagne];
    }
    
    return self;
}

#pragma mark - Methods

-(SQAWineModel*) redWineAtIndex: (int) index {
    return [self.redWines objectAtIndex:index];
}

-(SQAWineModel*) whiteWineAtIndex: (int) index {
    return [self.whiteWines objectAtIndex:index];
}

-(SQAWineModel*) otherWineAtIndex: (int) index {
    return [self.otherWines objectAtIndex:index];
}

@end
