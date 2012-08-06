//
//  JLPTSchedule.h
//  perKanjiBoard
//
//  Created by apple on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JLPTSchedule : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * jlpt1;
@property (nonatomic, retain) NSNumber * jlpt2;
@property (nonatomic, retain) NSNumber * jlpt3;
@property (nonatomic, retain) NSNumber * jlpt4;
@property (nonatomic, retain) NSNumber * jlpt5;
@property (nonatomic, retain) NSNumber * special;

@end
