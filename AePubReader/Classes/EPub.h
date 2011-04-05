//
//  EPubParser.h
//  AePubReader
//
//  Created by Federico Frappi on 05/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"


//TODO: parse author, title
//		save epubBasePath
		

@interface EPub : NSObject {
	NSString* title;
	NSString* author;
	NSArray* spineArray;
	NSString* epubBasePath;
	NSString* epubFilePath;
}

@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* author;
@property(nonatomic, retain) NSArray* spineArray;


- (id) initWithEPubPath:(NSString*)path;
- (void) parseEpub;
- (void) unzipAndSaveFileNamed:(NSString*)fileName;
- (NSString*) applicationDocumentsDirectory;
- (NSString*) parseManifestFile;
- (void) parseOPF:(NSString*)opfPath;

@end
