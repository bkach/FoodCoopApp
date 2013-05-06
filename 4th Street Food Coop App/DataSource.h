//
//  DataSource.h
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 4/25/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//

#import "Kal/Kal.h"

@class Delivery;


@interface DataSource : NSObject <KalDataSource>
{
    NSMutableArray *items;
    NSMutableArray *deliveries;
}

+ (DataSource *)dataSource;
- (Delivery *)deliveryAtIndexPath:(NSIndexPath *)indexPath;

@end
