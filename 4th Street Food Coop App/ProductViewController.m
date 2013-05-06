//
//  ProductViewController.m
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 5/3/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//

#import "ProductViewController.h"
#import "DetailViewController.h"

@interface ProductViewController ()
{
    NSMutableArray *contentArray;
    int currentIndex;
}
@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //Loading data from the property list
    NSString *path = [[NSBundle mainBundle] pathForResource:@"products" ofType:@"plist"];
    contentArray = [NSArray arrayWithContentsOfFile:path];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
//We only have one section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

//The number of rows is the number of products in the property list
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Return the number of rows in the section.
    return contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Sets the title of the cell to the name of the product
    cell.textLabel.text = [[contentArray objectAtIndex:indexPath.row] objectAtIndex:0];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //When user selects an item, we segue to its detail view
    currentIndex = indexPath.row;
  
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailVC = segue.destinationViewController;
    NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
    [detailVC setIndex:currentIndex];
}

@end
