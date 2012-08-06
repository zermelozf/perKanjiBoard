//
//  OptionsViewController.h
//  KanjiBoard
//
//  Created by apple on 22/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLPTSchedule.h"


@interface OptionsViewController : UIViewController {

}
@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;

@property (nonatomic, retain) IBOutlet UILabel *jlpt1ScheduleDisplay;
@property (nonatomic, retain) IBOutlet UILabel *jlpt2ScheduleDisplay;
@property (nonatomic, retain) IBOutlet UILabel *jlpt3ScheduleDisplay;
@property (nonatomic, retain) IBOutlet UILabel *jlpt4ScheduleDisplay;
@property (nonatomic, retain) IBOutlet UILabel *jlpt5ScheduleDisplay;
@property (nonatomic, retain) IBOutlet UILabel *jlpt6ScheduleDisplay;

@property (nonatomic, retain) IBOutlet UISlider *jlpt1Slider;
@property (nonatomic, retain) IBOutlet UISlider *jlpt2Slider;
@property (nonatomic, retain) IBOutlet UISlider *jlpt3Slider;
@property (nonatomic, retain) IBOutlet UISlider *jlpt4Slider;
@property (nonatomic, retain) IBOutlet UISlider *jlpt5Slider;
@property (nonatomic, retain) IBOutlet UISlider *jlpt6Slider;

@property (nonatomic, retain) JLPTSchedule * jlptSchedule;
@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;

-(IBAction)schedule:(id)sender;

@end
