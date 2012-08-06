//
//  Kanji.h
//  perKanjiBoard
//
//  Created by apple on 02/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Kanji : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * literal;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSNumber * frequency;
@property (nonatomic, retain) NSNumber * heisigFrequency;
@property (nonatomic, retain) NSMutableArray * reading_on;
@property (nonatomic, retain) NSMutableArray * reading_kun;
@property (nonatomic, retain) NSMutableArray * reading;
@property (nonatomic, retain) NSMutableArray * meaning;
@property (nonatomic, retain) NSNumber * status;

@end
