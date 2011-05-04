//
//  ChapterListViewController.h
//  AePubReader
//
//  Created by Federico Frappi on 04/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface ChapterListViewController : UITableViewController {
    DetailViewController* epubViewController;
}

@property(nonatomic, retain) DetailViewController* epubViewController;

@end
