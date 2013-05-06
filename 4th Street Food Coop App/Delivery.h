//
//  delivery.h
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 5/1/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Delivery : NSObject
{
    NSDate *date;
    NSString *name;
}

@property (nonatomic, retain, readonly) NSDate *date;
@property (nonatomic, retain, readonly) NSString *name;

+ (Delivery*)deliveryNamed:(NSString *)name date:(NSDate *)date;
- (id)initWithName:(NSString *)name date:(NSDate *)date;
- (NSComparisonResult)compare:(Delivery *)otherDelivery;

@end
