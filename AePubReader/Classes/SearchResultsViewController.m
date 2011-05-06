//
//  SearchResultsViewController.m
//  AePubReader
//
//  Created by Federico Frappi on 05/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "SearchResult.h"

#define NEIGHSIZE 40

@implementation SearchResultsViewController

@synthesize resultsTableView, epubViewController;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    SearchResult* hit = (SearchResult*)[results objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"...%@...", hit.neighboringText];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Chapter %d - page %d", hit.chapterIndex, hit.pageIndex];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [results count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResult* hit = (SearchResult*)[results objectAtIndex:[indexPath row]];

    [epubViewController loadSpine:hit.chapterIndex atPageIndex:0];
    
}

- (void) searchString:(NSString*)query{
    [results release];
    NSMutableArray* res = [[NSMutableArray alloc] init];
    int count = 0;
    for(Chapter* chapter in epubViewController.loadedEpub.spineArray){        
        NSRange range = NSMakeRange(0, chapter.text.length);
        range = [chapter.text rangeOfString:query options:NSCaseInsensitiveSearch range:range locale:nil];
        int hitCount=0;
        while (range.location != NSNotFound) {
            //do something
            int offsetSize = range.length>=NEIGHSIZE?0:(NEIGHSIZE-range.length)/2;
            
            int minLefPosition = (int)range.location-NEIGHSIZE>=0?(int)range.location-NEIGHSIZE:0;
            int sforoSX = NEIGHSIZE-(range.location - minLefPosition);
            int maxRightPosition = range.location+NEIGHSIZE+sforoSX>=[chapter.text length]?([chapter.text length] - 1):(range.location+NEIGHSIZE+sforoSX); 
            int sforoDX = range.location+NEIGHSIZE+sforoSX - maxRightPosition;
            minLefPosition = minLefPosition-sforoDX>=0?minLefPosition-sforoDX:0;
            
            NSRange cutRange = NSMakeRange(minLefPosition, (maxRightPosition-minLefPosition));
            
            
            SearchResult* result = [[SearchResult alloc] initWithChapterIndex:count 
                                                                    pageIndex:++hitCount 
                                                              neighboringText:[chapter.text substringWithRange:cutRange]];
            
            range = NSMakeRange(range.location+range.length, chapter.text.length-(range.location+range.length));
            range = [chapter.text rangeOfString:query options:NSCaseInsensitiveSearch range:range locale:nil];
            
            
            
            [res addObject:result];   
        }
        count++;
    }
    results = [[NSArray arrayWithArray:res] retain];
    [res release];
    [resultsTableView reloadData];
}
        
- (int)countString:(NSString *)stringToCount inText:(NSString *)text{
    int foundCount=0;
    NSRange range = NSMakeRange(0, text.length);
    range = [text rangeOfString:stringToCount options:NSCaseInsensitiveSearch range:range locale:nil];
    while (range.location != NSNotFound) {
        foundCount++;
        range = NSMakeRange(range.location+range.length, text.length-(range.location+range.length));
        range = [text rangeOfString:stringToCount options:NSCaseInsensitiveSearch range:range locale:nil];
    }
    return foundCount;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
