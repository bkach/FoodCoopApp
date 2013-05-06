//
//  delivery.m
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 5/1/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//

#import "Delivery.h"

@implementation Delivery

@synthesize date, name;

+ (Delivery*)deliveryNamed:(NSString *)aName date:(NSDate *)aDate;
{
    return [[Delivery alloc] initWithName:aName date:aDate];
}

- (id)initWithName:(NSString *)aName date:(NSDate *)aDate
{
    if ((self = [super init])) {
        name = [aName copy];
    }
    return self;
}

- (NSComparisonResult)compare:(Delivery *)otherDelivery
{
    NSComparisonResult comparison = [self.date compare:otherDelivery.date];
    if (comparison == NSOrderedSame)
        return [self.name compare:otherDelivery.name];
    else
        return comparison;
}

- (void)dealloc
{

}

@end
