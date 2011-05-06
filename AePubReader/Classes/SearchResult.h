//
//  SearchResult.h
//  AePubReader
//
//  Created by Federico Frappi on 05/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchResult : NSObject {
    int chapterIndex;
    int pageIndex;
    NSString* neighboringText;
}

- initWithChapterIndex:(int)theChapterIndex pageIndex:(int)thePageIndex neighboringText:(NSString*)theNeighboringText;

@property int chapterIndex, pageIndex;
@property (nonatomic, retain) NSString* neighboringText;

@end
