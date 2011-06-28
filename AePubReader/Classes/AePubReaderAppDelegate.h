//
//  AePubReaderAppDelegate.h
//  AePubReader
//
//  Created by Federico Frappi on 04/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class EPubViewController;

@interface AePubReaderAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
        
    EPubViewController *detailViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet EPubViewController *detailViewController;

@end
