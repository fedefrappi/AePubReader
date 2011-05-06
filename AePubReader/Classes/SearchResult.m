//
//  SearchResult.m
//  AePubReader
//
//  Created by Federico Frappi on 05/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchResult.h"


@implementation SearchResult

@synthesize pageIndex, chapterIndex, neighboringText;

- initWithChapterIndex:(int)theChapterIndex pageIndex:(int)thePageIndex neighboringText:(NSString*)theNeighboringText{
    if((self=[super init])){
        chapterIndex = theChapterIndex;
        pageIndex = thePageIndex;
        neighboringText = [theNeighboringText retain];
    }
    return self;
}

@end
