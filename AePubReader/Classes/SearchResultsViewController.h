//
//  SearchResultsViewController.h
//  AePubReader
//
//  Created by Federico Frappi on 05/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPubViewController.h"

@interface SearchResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate> {
    UITableView* resultsTableView;
    NSMutableArray* results;
    EPubViewController* epubViewController;
    
    int currentChapterIndex;
    NSString* currentQuery;
}

@property (nonatomic, retain) IBOutlet UITableView* resultsTableView;
@property (nonatomic, assign) EPubViewController* epubViewController;
@property (nonatomic, retain) NSMutableArray* results;
@property (nonatomic, retain) NSString* currentQuery;

- (void) searchString:(NSString*)query;

@end
