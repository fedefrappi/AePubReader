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
	NSString* title;
	NSString* author;
	NSMutableArray* spineArray;
	NSString* epubPath;
}

- (id) initWithEPubPath:(NSString*)path;
- (void) parseEpub;
- (void) unzipAndSaveFileNamed:(NSString*)fileName;
- (NSString*) applicationDocumentsDirectory;
- (NSString*) parseManifestFile;
- (void) parseOPF:(NSString*)opfPath;

@end
