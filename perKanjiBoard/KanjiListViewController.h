//
//  KanjiListViewController.h
//  KanjiBoard
//
//  Created by apple on 20/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kanji.h"
#import "JLPTSchedule.h"


@interface KanjiListViewController : UITableViewController {
    BOOL hidden;
}

@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;

@property (nonatomic, retain) NSMutableArray *kanjiList;
@property (nonatomic, retain) JLPTSchedule * jlptSchedule;

@property NSInteger jlptLevel;
@property (nonatomic, retain) NSString *type;

- (NSInteger)numberOfDaysFor:(NSInteger)jlptLevel;
- (id)initWithNibName:(NSString *)nibNameOrNil list:(NSMutableArray *)list jlptLevel:(NSInteger)lev;
- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier;
- (IBAction)toKanji:(id)sender;
- (void)flip;

@end
