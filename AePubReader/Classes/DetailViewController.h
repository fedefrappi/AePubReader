//
//  DetailViewController.h
//  AePubReader
//
//  Created by Federico Frappi on 04/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZipArchive.h"
#import "EPub.h"
#import "Chapter.h"

@class SearchResultsViewController;

@interface DetailViewController : UIViewController <UIWebViewDelegate, ChapterProtocol, UISearchBarDelegate> {
    
    UIToolbar *toolbar;
        
	UIWebView *webView;
    
    UIBarButtonItem* chapterListButton;
	
	UIBarButtonItem* prevSpineButton;
	UIBarButtonItem* nextSpineButton;
	
	UIBarButtonItem* prevPageButton;
	UIBarButtonItem* nextPageButton;
	
	UIBarButtonItem* decTextSizeButton;
	UIBarButtonItem* incTextSizeButton;
    
    UISlider* pageSlider;
    UILabel* currentPageLabel;
	
	EPub* loadedEpub;
	int currentSpineIndex;
	int currentPageInSpineIndex;
	int pagesInCurrentSpineCount;
	int currentTextSize;
	int totalPagesCount;
    
    BOOL epubLoaded;
    BOOL loading;
    
    UIPopoverController* chaptersPopover;
    UIPopoverController* searchResultsPopover;

    SearchResultsViewController* searchResViewController;
}

- (IBAction) showChapterIndex:(id)sender;
- (IBAction) nextButtonClicked:(id)sender;
- (IBAction) prevButtonClicked:(id)sender;
- (IBAction) nextPageClicked:(id)sender;
- (IBAction) prevPageClicked:(id)sender;
- (IBAction) increaseTextSizeClicked:(id)sender;
- (IBAction) decreaseTextSizeClicked:(id)sender;
- (IBAction) slidingStarted:(id)sender;
- (IBAction) slidingEnded:(id)sender;

- (void) gotoPageInCurrentSpine: (int)pageIndex;
- (void) updatePagination;
- (void) loadSpine:(int)spineIndex atPageIndex:(int)pageIndex;
- (void) webViewDidFinishLoad:(UIWebView *)theWebView;
- (void) loadEpub:(NSString*) epubName;

- (void) chapterDidFinishLoad:(Chapter *)chapter;

- (int) getGlobalPageCount;

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

@property (nonatomic, retain) EPub* loadedEpub;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *chapterListButton;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *prevSpineButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextSpineButton;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *prevPageButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextPageButton;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *decTextSizeButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *incTextSizeButton;

@property (nonatomic, retain) IBOutlet UISlider *pageSlider;
@property (nonatomic, retain) IBOutlet UILabel *currentPageLabel;


@end
