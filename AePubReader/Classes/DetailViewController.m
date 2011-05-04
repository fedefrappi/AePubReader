//
//  DetailViewController.m
//  AePubReader
//
//  Created by Federico Frappi on 04/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "Chapter.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
@end



@implementation DetailViewController

@synthesize toolbar, popoverController, webView, nextSpineButton, prevSpineButton, loadedEpub; 
@synthesize prevPageButton, nextPageButton, decTextSizeButton, incTextSizeButton;
@synthesize currentPageLabel, pageSlider;

#pragma mark -
#pragma mark Managing the detail item

- (void) loadEpub:(NSString*) epubName{
	if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
	currentSpineIndex = 0;
    currentPageInSpineIndex = 0;
    loadedEpub = [[EPub alloc] initWithEPubPath:[[NSBundle mainBundle] pathForResource:epubName ofType:@"epub"]];
    [self updatePagination];
    
}

- (void) chapterDidFinishLoad:(Chapter *)chapter{
    totalPagesCount+=chapter.pageCount;
    if(chapter.chapterIndex==currentSpineIndex){
        [self loadSpine:currentSpineIndex atPageIndex:currentPageInSpineIndex];
    }
	if(chapter.chapterIndex + 1 < [loadedEpub.spineArray count]){
		[[loadedEpub.spineArray objectAtIndex:chapter.chapterIndex+1] setDelegate:self];
		[[loadedEpub.spineArray objectAtIndex:chapter.chapterIndex+1] loadChapterWithWindowSize:webView.bounds fontPercentSize:currentTextSize];
		[currentPageLabel setText:[NSString stringWithFormat:@"?/%d", totalPagesCount]];
	} else {
		[currentPageLabel setText:[NSString stringWithFormat:@"%d/%d",[self getGlobalPageCount], totalPagesCount]];
		[pageSlider setValue:(float)100*(float)[self getGlobalPageCount]/(float)totalPagesCount animated:YES];
		loading = NO;
	}
}

- (int) getGlobalPageCount{
	int pageCount = 0;
	for(int i=0; i<currentSpineIndex; i++){
		pageCount+= [[loadedEpub.spineArray objectAtIndex:i] pageCount]; 
	}
	pageCount+=currentPageInSpineIndex+1;
	return pageCount;
}

- (void) loadSpine:(int)spineIndex atPageIndex:(int)pageIndex{
	
    NSLog(@"%d", [[loadedEpub.spineArray objectAtIndex:spineIndex] pageCount]);
	
	NSURL* url = [NSURL fileURLWithPath:[[loadedEpub.spineArray objectAtIndex:spineIndex] spinePath]];
	[webView loadRequest:[NSURLRequest requestWithURL:url]];
	currentPageInSpineIndex = pageIndex;
	currentSpineIndex = spineIndex;
	if(!loading){
		[currentPageLabel setText:[NSString stringWithFormat:@"%d/%d",[self getGlobalPageCount], totalPagesCount]];
		[pageSlider setValue:(float)100*(float)[self getGlobalPageCount]/(float)totalPagesCount animated:YES];	
	}
}

- (void) gotoPageInCurrentSpine:(int)pageIndex{
	if(pageIndex>=pagesInCurrentSpineCount){
		pageIndex = pagesInCurrentSpineCount - 1;
		currentPageInSpineIndex = pagesInCurrentSpineCount - 1;	
	}
	
	float pageOffset = pageIndex*webView.bounds.size.width;
	NSString* goToOffsetFunc = [NSString stringWithFormat:@" function pageScroll(xOffset){ window.scroll(xOffset,0); } "];
	NSString* goTo =[NSString stringWithFormat:@"pageScroll(%f)", pageOffset];
	
	[webView stringByEvaluatingJavaScriptFromString:goToOffsetFunc];
	[webView stringByEvaluatingJavaScriptFromString:goTo];	
	
	if(!loading){
		[currentPageLabel setText:[NSString stringWithFormat:@"%d/%d",[self getGlobalPageCount], totalPagesCount]];
		[pageSlider setValue:(float)100*(float)[self getGlobalPageCount]/(float)totalPagesCount animated:YES];	
	}
	
}

- (IBAction)nextButtonClicked:(id)sender {
	if(!loading){
		if(currentSpineIndex+1<[loadedEpub.spineArray count]){
			[self loadSpine:++currentSpineIndex atPageIndex:0];
		}	
	}
}

- (IBAction)prevButtonClicked:(id)sender {
	if(!loading){
		if(currentSpineIndex-1>=0){
			[self loadSpine:--currentSpineIndex atPageIndex:0];
		}	
	}
}

- (IBAction)nextPageClicked:(id)sender {
	if(!loading){
		if(currentPageInSpineIndex+1<pagesInCurrentSpineCount){
			[self gotoPageInCurrentSpine:++currentPageInSpineIndex];
		} else {
			[self nextButtonClicked:self];
		}		
	}
}

- (IBAction)prevPageClicked:(id)sender {
	if (!loading) {
		if(currentPageInSpineIndex-1>=0){
			[self gotoPageInCurrentSpine:--currentPageInSpineIndex];
		} else {
			if(currentSpineIndex!=0){
				int targetPage = [self getPageCountForSpineAtIndex:(currentSpineIndex-1)];
				[self loadSpine:--currentSpineIndex atPageIndex:targetPage-1];
				
			}
		}		
	}
}


- (IBAction) increaseTextSizeClicked:(id)sender{
	if(!loading){
		currentTextSize = currentTextSize+25<=200?currentTextSize+25:currentTextSize;
		[self updatePagination];	
	}
}
- (IBAction) decreaseTextSizeClicked:(id)sender{
	if(!loading){
		currentTextSize = currentTextSize-25>=50?currentTextSize-25:currentTextSize;	
		[self updatePagination];	
	}
}

- (IBAction) slidingStarted:(id)sender{
	[currentPageLabel setText:[NSString stringWithFormat:@"%d/%d", (int)(pageSlider.value*(float)totalPagesCount/(float)100), totalPagesCount]];
}

- (IBAction) slidingEnded:(id)sender{
	int targetPage = (int)(pageSlider.value*(float)totalPagesCount/(float)100);
	int pageSum = 0;
	int chapterIndex = 0;
	int pageIndex = 0;
	for(chapterIndex=0; chapterIndex<[loadedEpub.spineArray count]; chapterIndex++){
		pageSum+=[[loadedEpub.spineArray objectAtIndex:chapterIndex] pageCount];
		NSLog(@"Chapter %d, targetPage: %d, pageSum: %d, pageIndex: %d", chapterIndex, targetPage, pageSum, (pageSum-targetPage));
		if(pageSum>=targetPage){
			pageIndex = [[loadedEpub.spineArray objectAtIndex:chapterIndex] pageCount] - 1 - pageSum + targetPage;
			break;
		}
	}
	[self loadSpine:chapterIndex atPageIndex:pageIndex];
}


- (void)webViewDidFinishLoad:(UIWebView *)theWebView{
		
	NSString *varMySheet = @"var mySheet = document.styleSheets[0];";
	
	NSString *addCSSRule =  @"function addCSSRule(selector, newRule) {"
	"if (mySheet.addRule) {"
	"mySheet.addRule(selector, newRule);"								// For Internet Explorer
	"} else {"
	"ruleIndex = mySheet.cssRules.length;"
	"mySheet.insertRule(selector + '{' + newRule + ';}', ruleIndex);"   // For Firefox, Chrome, etc.
	"}"
	"}";
		
	NSString *insertRule1 = [NSString stringWithFormat:@"addCSSRule('html', 'padding: 0px; height: %fpx; -webkit-column-gap: 0px; -webkit-column-width: %fpx;')", webView.frame.size.height, webView.frame.size.width];
	NSString *insertRule2 = [NSString stringWithFormat:@"addCSSRule('p', 'text-align: justify;')"];
	NSString *setTextSizeRule = [NSString stringWithFormat:@"addCSSRule('body', '-webkit-text-size-adjust: %d%%;')", currentTextSize];
	
	[webView stringByEvaluatingJavaScriptFromString:varMySheet];
	
	[webView stringByEvaluatingJavaScriptFromString:addCSSRule];
	
	[webView stringByEvaluatingJavaScriptFromString:setTextSizeRule];
	
	[webView stringByEvaluatingJavaScriptFromString:insertRule1];
	
	[webView stringByEvaluatingJavaScriptFromString:insertRule2];
	
	int totalWidth = [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollWidth"] intValue];
	pagesInCurrentSpineCount = (int)((float)totalWidth/webView.bounds.size.width);
	
	[self gotoPageInCurrentSpine:currentPageInSpineIndex];
	
}

- (void) updatePagination{
	loading = YES;
//	int totalWidth = [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollWidth"] intValue];//
//	pagesInCurrentSpineCount = (int)((float)totalWidth/webView.bounds.size.width);
	
    totalPagesCount=0;
	[[loadedEpub.spineArray objectAtIndex:0] setDelegate:self];
	[[loadedEpub.spineArray objectAtIndex:0] loadChapterWithWindowSize:webView.bounds fontPercentSize:currentTextSize];
	[currentPageLabel setText:@"?/?"];
}

- (int) getPageCountForSpineAtIndex:(int) spineIndex{
    
	return [[loadedEpub.spineArray objectAtIndex:spineIndex] pageCount];

}

#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Root List";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark View lifecycle

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[webView setDelegate:self];
	
	UIScrollView* sv = nil;
	for (UIView* v in  webView.subviews) {
		if([v isKindOfClass:[UIScrollView class]]){
			sv = (UIScrollView*) v;
			sv.scrollEnabled = NO;
			sv.bounces = NO;
		}
	}
	currentTextSize = 100;
	
	UISwipeGestureRecognizer* rightSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextPageClicked:)] autorelease];
	[rightSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
	
	UISwipeGestureRecognizer* leftSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(prevPageClicked:)] autorelease];
	[leftSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	
	[webView addGestureRecognizer:rightSwipeRecognizer];
	[webView addGestureRecognizer:leftSwipeRecognizer];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Memory management

/*
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
*/

- (void)dealloc {
    [popoverController release];
    [toolbar release];
    [super dealloc];
}

@end
