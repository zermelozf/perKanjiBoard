//
//  KanjiViewController.h
//  KanjiBoard
//
//  Created by apple on 21/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kanji.h"


@interface KanjiViewController : UIViewController {

}

@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;

@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;

@property (nonatomic, retain) Kanji *kanji;
@property (nonatomic, retain) IBOutlet UILabel *kanjiLabel;
@property (nonatomic, retain) IBOutlet UILabel *frequencyLabel;

@property (nonatomic, retain) IBOutlet UIButton * masterdButton;
@property (nonatomic, retain) IBOutlet UIButton * reviewButton;
@property (nonatomic, retain) IBOutlet UIButton * resetButton;

-(IBAction)mastered;
-(IBAction)review;
-(IBAction)reset;

-(void)flip;

@end
