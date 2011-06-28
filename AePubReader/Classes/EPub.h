//
//  EPubParser.h
//  AePubReader
//
//  Created by Federico Frappi on 05/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"
		

@interface EPub : NSObject {
	NSArray* spineArray;
	NSString* epubFilePath;
}

@property(nonatomic, retain) NSArray* spineArray;

- (id) initWithEPubPath:(NSString*)path;


@end
