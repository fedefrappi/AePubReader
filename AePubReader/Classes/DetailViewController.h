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

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    NSString *detailItem;
	
    UILabel *titleLabel;
	UILabel *authorLabel;
	UIWebView *webView;
	
	UIBarButtonItem* prevSpineButton;
	UIBarButtonItem* nextSpineButton;
	
	EPub* loadedEpub;
	int currentSpineIndex;
}
- (IBAction)nextButtonClicked:(id)sender;
- (IBAction)prevButtonClicked:(id)sender;
- (void) loadSpine:(int) spineIndex;


@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) NSString* detailItem;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *prevSpineButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextSpineButton;


@end
