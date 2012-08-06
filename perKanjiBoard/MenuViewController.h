//
//  MenuViewController.h
//  KanjiBoard
//
//  Created by apple on 20/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "JLPTSchedule.h"

@interface MenuViewController : UIViewController {

}

@property (nonatomic, retain) NSMutableArray * kanjiList;
@property (nonatomic, retain) JLPTSchedule * jlptSchedule;

@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;

@property (nonatomic, retain) UIActivityIndicatorView *spinner;


-(IBAction)toList: (NSInteger)level;
-(IBAction)toOptions;
-(IBAction)toAbout;
-(void)threadStartAnimating;

@end
