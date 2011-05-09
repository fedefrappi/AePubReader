//
//  SearchResult.m
//  AePubReader
//
//  Created by Federico Frappi on 05/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchResult.h"


@implementation SearchResult

@synthesize pageIndex, chapterIndex, neighboringText, hitIndex, originatingQuery;

- initWithChapterIndex:(int)theChapterIndex pageIndex:(int)thePageIndex hitIndex:(int)theHitIndex neighboringText:(NSString*)theNeighboringText originatingQuery:(NSString*)theOriginatingQuery{
    if((self=[super init])){
        chapterIndex = theChapterIndex;
        pageIndex = thePageIndex;
        hitIndex = theHitIndex;
        neighboringText = [[theNeighboringText stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] retain];
        originatingQuery = [theOriginatingQuery retain];
    }
    return self;
}

@end
