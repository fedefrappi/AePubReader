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

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UIWebViewDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    NSString *detailItem;
	
    UILabel *titleLabel;
	UILabel *authorLabel;
	UIWebView *webView;
	
	UIBarButtonItem* prevSpineButton;
	UIBarButtonItem* nextSpineButton;
	
	UIBarButtonItem* prevPageButton;
	UIBarButtonItem* nextPageButton;
	
	UIBarButtonItem* decTextSizeButton;
	UIBarButtonItem* incTextSizeButton;
	
	EPub* loadedEpub;
	int currentSpineIndex;
	int currentPageInSpineIndex;
	int pagesInCurrentSpineCount;
	int currentTextSize;
	int totalPagesCount;
}
- (IBAction) nextButtonClicked:(id)sender;
- (IBAction) prevButtonClicked:(id)sender;
- (IBAction) nextPageClicked:(id)sender;
- (IBAction) prevPageClicked:(id)sender;
- (IBAction) increaseTextSizeClicked:(id)sender;
- (IBAction) decreaseTextSizeClicked:(id)sender;

- (void) loadSpine:(int) spineIndex;
- (void) gotoPageInCurrentSpine: (int)pageIndex;
- (void) updatePageCount;
- (void) loadSpine:(int)spineIndex atPageIndex:(int)pageIndex;
- (int) getPageCountForSpineAtIndex:(int) spineIndex;
- (void) webViewDidFinishLoad:(UIWebView *)theWebView;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) NSString* detailItem;
@property (nonatomic, retain) EPub* loadedEpub;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UIWebView *webView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *prevSpineButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextSpineButton;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *prevPageButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextPageButton;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *decTextSizeButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *incTextSizeButton;



@end
