//
//  SearchResultsViewController.h
//  AePubReader
//
//  Created by Federico Frappi on 05/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface SearchResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView* resultsTableView;
    NSArray* results;
    DetailViewController* epubViewController;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void) searchString:(NSString*)query;

- (int)countString:(NSString *)stringToCount inText:(NSString *)text;

@property (nonatomic, retain) IBOutlet UITableView* resultsTableView;
@property (nonatomic, retain) DetailViewController* epubViewController;

@end
