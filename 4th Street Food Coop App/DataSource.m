//
//  DataSource.h
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 4/25/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//
#import "Kal/KalDataSource.h"
#import "Kal/KalPrivate.h"
#import "Kal/Kal.h"

#import <sqlite3.h>
#import "delivery.h"
#import "DataSource.h"
#import "DetailViewController.h"

static BOOL IsDateBetweenInclusive(NSDate *date, NSDate *begin, NSDate *end)
{
    return [date compare:begin] != NSOrderedAscending && [date compare:end] != NSOrderedDescending;
}

@interface DataSource (){
    NSMutableArray *contentArray;
}
- (NSArray *)deliveriesFrom:(NSDate *)fromDate to:(NSDate *)toDate;
@end

@implementation DataSource

+ (DataSource *)dataSource
{
    return [[[DataSource class] alloc] init];
}

- (id)init
{
    if ((self = [super init])) {
        items = [[NSMutableArray alloc] init];
        deliveries = [[NSMutableArray alloc] init];
    }
    return self;
}

- (Delivery *)deliveryAtIndexPath:(NSIndexPath *)indexPath
{
    // Returns a delivery at a given indexPath
    return [items objectAtIndex:indexPath.row];
}

// Table View Code
#pragma mark UITableViewDataSource protocol conformance

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Creates a cell that contains the name of the delivery item
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    Delivery *delivery = [self deliveryAtIndexPath:indexPath];
    cell.textLabel.text = delivery.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

// Kal Code
#pragma mark KalDataSource protocol conformance

- (void)presentingDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)delegate
{
    [deliveries removeAllObjects];
}

- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    return [[self deliveriesFrom:fromDate to:toDate] valueForKeyPath:@"date"];
}

- (void)addDeliveryItemsForDay:(int)day date:(NSDate *)date
{
    // Adds items from the P-List to the calendar on a given day
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSMutableArray *deliveryArray = [[NSMutableArray alloc] initWithCapacity:40];
    int dayOfMonth = [components day];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"products" ofType:@"plist"];
    contentArray = [NSArray arrayWithContentsOfFile:path];
    
    for(NSArray *product in contentArray){
        if( [[product objectAtIndex:1] intValue] == dayOfMonth)
            [deliveryArray addObject:[[Delivery alloc] initWithName:[product objectAtIndex:0] date:date]];
        else if([[product objectAtIndex:2] intValue] == day)
            [deliveryArray addObject:[[Delivery alloc] initWithName:[product objectAtIndex:0] date:date]];
    }
    
    if([deliveryArray count] == 0)
        [deliveryArray addObject:[[Delivery alloc] initWithName:@"No Deliveries Today" date:date]];
    
    [deliveries addObjectsFromArray:deliveryArray];
}

- (void)loadItemsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    // Loads items in the entire month that's displayed
    //      Called when switching months
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:fromDate];
    int weekday = [comps weekday];
        
    [self addDeliveryItemsForDay:weekday date:fromDate];
    
    [items addObjectsFromArray:[self deliveriesFrom:fromDate to:toDate]];
    [deliveries removeAllObjects];
}

- (void)removeAllItems
{
    [items removeAllObjects];
}

#pragma mark -

- (NSArray *)deliveriesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    // Used to narrow down which items are to be displayed
    NSMutableArray *matches = [NSMutableArray array];
    for (Delivery *delivery in deliveries)
        if (IsDateBetweenInclusive(delivery.date, fromDate, toDate))
            [matches addObject:delivery];
    return matches;
}

@end