//
//  XMLParser.m
//  KanjiBoard
//
//  Created by apple on 20/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser

@synthesize parser, currentElement, kanji, kanjiList, managedObjectContext;

-(XMLParser*) initialize {
    self = [super init];
    if ( self ) 
        NSLog(@"Custom init!");
    return self;
}

-(void)listFromXmlFile:(NSString *)path
{
    kanjiList = [[NSMutableArray alloc] init];
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:path ofType:@"xml"];
    NSURL *xmlURL = [NSURL fileURLWithPath:pathToFile];
    if (parser) 
        [parser release];
    parser =[[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [parser setDelegate:self];
    BOOL success = [parser parse];
    if (success) {
        NSLog(@"Parse OK.");
    }
    else NSLog(@"Parse Failure");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    currentElement = elementName;
    if ([elementName isEqualToString:@"character"]) {
        kanji = (Kanji *)[NSEntityDescription insertNewObjectForEntityForName:@"Kanji" inManagedObjectContext:managedObjectContext];
        kanji.meaning = [[NSMutableArray alloc] init];
        kanji.reading_on = [[NSMutableArray alloc] init];
        kanji.reading_kun = [[NSMutableArray alloc] init];
        kanji.reading = [[NSMutableArray alloc] init];
    }
}  

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([currentElement isEqualToString:@"literal"]) {
        kanji.literal = string;
    }
    else if ([currentElement isEqualToString:@"jlpt"]) {
        [kanji setLevel:[NSNumber numberWithInt:[string intValue]]];
    }
    else if ([currentElement isEqualToString:@"freq"]) {
        [kanji setFrequency:[NSNumber numberWithInt:[string intValue]]];
    }
    else if ([currentElement isEqualToString:@"ref"]) {
        if ([string intValue] != 0) {
            [kanji setHeisigFrequency:[NSNumber numberWithInt:[string intValue]]];

        }
    }
    else if ([currentElement isEqualToString:@"meaning"]) {
        [[kanji meaning] addObject:string];
    }
    else if ([currentElement isEqualToString:@"reading_on"]) {
        if ([string isEqualToString:@"-"]) {
            //Do nothing
        }
        else if ([[kanji reading] containsObject:string]) {
            //Do nothing
        }
        else {
            [[kanji reading] addObject:string];
            [[kanji reading_on] addObject:string];
        }
    }
    else if ([currentElement isEqualToString:@"reading_kun"]) {
        if ([string isEqualToString:@"-"]) {
            //Do nothing
        }
        else if ([[kanji reading] containsObject:string]) {
            //Do nothing
        }
        else {
            [[kanji reading] addObject:string];
            [[kanji reading_kun] addObject:string];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"character"]) {
        [kanji setIndex:[NSNumber numberWithInt:[kanjiList count]]];
        //NSLog([kanji.reading objectAtIndex:0]);
        [kanjiList addObject:kanji];
        [kanji.meaning release];
        [kanji.reading release];
        [kanji.reading_kun release];
        [kanji.reading_on release];
        [kanji release];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
	NSString * errorString = [NSString stringWithFormat:@"Error code %i ",[parseError code]];
    
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"An error occured" message:errorString 
														 delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[errorAlert show];
}
@end
