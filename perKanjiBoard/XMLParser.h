//
//  XMLParser.h
//  KanjiBoard
//
//  Created by apple on 20/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Kanji.h"


@interface XMLParser : NSObject <NSXMLParserDelegate> {
    
}

@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;

@property (nonatomic, retain) NSXMLParser *parser;
@property (nonatomic, retain) NSString *currentElement;
@property (nonatomic, retain) Kanji *kanji;
@property (nonatomic, retain) NSMutableArray *kanjiList;

-(XMLParser*)initialize;
-(void)listFromXmlFile:(NSString *)path;

@end
