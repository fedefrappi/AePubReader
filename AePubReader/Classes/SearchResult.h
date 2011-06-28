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
    int hitIndex;
    int pageIndex;
    NSString* neighboringText;
    NSString* originatingQuery;
}

@property int chapterIndex, pageIndex, hitIndex;
@property (nonatomic, retain) NSString *neighboringText, *originatingQuery;

- initWithChapterIndex:(int)theChapterIndex pageIndex:(int)thePageIndex hitIndex:(int)theHitIndex neighboringText:(NSString*)theNeighboringText originatingQuery:(NSString*)theOriginatingQuery;


@end
