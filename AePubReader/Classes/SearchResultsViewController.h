//
//  SearchResultsViewController.h
//  AePubReader
//
//  Created by Federico Frappi on 05/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface SearchResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate> {
    UITableView* resultsTableView;
    NSMutableArray* results;
    DetailViewController* epubViewController;
    
    int currentChapterIndex;
    NSString* currentQuery;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void) searchString:(NSString*)query;
- (void) searchString:(NSString *)query inChapterAtIndex:(int)index;

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (void) webViewDidFinishLoad:(UIWebView*)webView;

@property (nonatomic, retain) IBOutlet UITableView* resultsTableView;
@property (nonatomic, retain) DetailViewController* epubViewController;

@end
