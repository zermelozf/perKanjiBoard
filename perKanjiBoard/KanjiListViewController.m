//
//  KanjiListViewController.m
//  KanjiBoard
//
//  Created by apple on 20/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KanjiListViewController.h"
#import "TableViewCellWithColumns.h"
#import "KanjiViewController.h"
#include "math.h"


@implementation KanjiListViewController

@synthesize managedObjectContext;

@synthesize kanjiList, jlptLevel, type, jlptSchedule;

- (id)initWithNibName:(NSString *)nibNameOrNil list:(NSMutableArray *)list jlptLevel:(NSInteger)lev
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        if (lev == 6){
            self.title = [NSString stringWithFormat:@"Bonus"];
        }
        else {
            self.title = [NSString stringWithFormat:@"JLPT %d",lev];
        }
        kanjiList = list;
        type = @"board";

        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Flip" style:UIBarButtonItemStylePlain target:self action:@selector(flip)];           
        self.navigationItem.rightBarButtonItem = anotherButton;
        hidden = false;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)flip {
    if ([type isEqualToString:@"board"]){
        type = @"list";
    }
    else {
        type = @"board";
    }
    NSArray *indexPathArray = [self.tableView indexPathsForVisibleRows];
    NSIndexPath *indexPath = [indexPathArray objectAtIndex:2];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
}

- (void)dealloc
{
    [kanjiList release];
    [jlptSchedule release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

-(NSInteger)numberOfDaysFor:(NSInteger)jlpt {
    switch (jlpt) {
        case 1:
            return [jlptSchedule.jlpt1 intValue];
        case 2:
            return [jlptSchedule.jlpt2 intValue];
        case 3:
            return [jlptSchedule.jlpt3 intValue];
        case 4:
            return [jlptSchedule.jlpt4 intValue];
        case 5:
            return [jlptSchedule.jlpt5 intValue];
        case 6:
            return [jlptSchedule.special intValue];
        default:
            NSLog(@"Wrong jlpt level");
            return -1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return [[optionsDictionary objectForKey:key] intValue];
    NSInteger nbDays = [self numberOfDaysFor:jlptLevel];
    NSInteger nbKanji = [kanjiList count];
    return (int)ceil(((double)nbKanji)/ceil((double)nbKanji/nbDays));

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [kanjiList count]/NB_COLUMNS+1;
    NSInteger nbDays = [self numberOfDaysFor:jlptLevel];
    NSInteger nbKanji = [kanjiList count];
    if ([type isEqualToString:@"board"]) {
        return (int)ceil((double)nbKanji/nbDays/NB_COLUMNS);
    }
    else {
        return (int)ceil((double)nbKanji/nbDays);;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Day %d", section+1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    TableViewCellWithColumns *cell = (TableViewCellWithColumns *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = (TableViewCellWithColumns *)[self tableViewCellWithReuseIdentifier:cellIdentifier];
    NSInteger nbDays = [self numberOfDaysFor:jlptLevel];
    NSInteger nbKanji = [kanjiList count];
    
    if ([type isEqualToString:@"board"]) {
        UIButton *label;
        NSString *labelText;
        for (int col=0; col<NB_COLUMNS; col++) {
            
            NSInteger offset = indexPath.section*(int)ceil((float)nbKanji/nbDays);
            NSInteger idx = indexPath.row*NB_COLUMNS+col;
            NSInteger status = 0;
            if (offset+idx < [kanjiList count] && idx < (int)ceil((float)nbKanji/nbDays)) 
            {
                labelText = [[kanjiList objectAtIndex:offset+idx] literal];
                status = [[[kanjiList objectAtIndex:offset+idx] status] integerValue];
            }
            else 
            {
                labelText = @" ";
            }
            label = (UIButton *)[cell viewWithTag:col+1];
            [label setTitle:labelText forState:UIControlStateNormal];
            [label setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [label addTarget:self action:@selector(toKanji:) forControlEvents:UIControlEventTouchUpInside];
            switch (status) {
                case -1:
                    [label setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.15]];
                    break;
                case 1:
                    [label setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.15]];
                    break;
                    
                default:
                    break;
            }
        }
    }
    else {
        NSInteger idx = indexPath.section*[self.tableView numberOfRowsInSection:indexPath.section]+indexPath.row;
        UILabel *label;
        if (idx < [kanjiList count]) {
            label = (UILabel *)[cell viewWithTag:1];
            label.text = [[kanjiList objectAtIndex:idx] literal];
            label = (UILabel *)[cell viewWithTag:3];
            label.text = [[[kanjiList objectAtIndex:idx] meaning] objectAtIndex:0];
        }
        else {
            cell.textLabel.text = @" ";
        }
    }
    return cell;
}

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier {
    
    TableViewCellWithColumns *cell=[[[TableViewCellWithColumns alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
    
    
    CGRect rect;
    if ([type isEqualToString:@"board"]) {
        UIButton *label;
        for (int col = 0; col<NB_COLUMNS; col++) {
            rect = CGRectMake(CELL_WIDTH/NB_COLUMNS*col, 0, CELL_WIDTH/NB_COLUMNS, self.tableView.rowHeight);
            label = [[UIButton alloc] initWithFrame:rect];
            label.tag = col+1;
            label.titleLabel.font = [UIFont systemFontOfSize:30];
            [cell.contentView addSubview:label];
            [cell bringSubviewToFront:label];
            label.backgroundColor = [UIColor clearColor];
            [label release];
        }
        
    }
    else {
        UILabel *mlabel;
        rect = CGRectMake(20, 0, 30, self.tableView.rowHeight);
        mlabel = [[UILabel alloc] initWithFrame:rect];
        mlabel.font = [UIFont systemFontOfSize:30];
        mlabel.adjustsFontSizeToFitWidth = YES;
        mlabel.tag = 1;
        [cell.contentView addSubview:mlabel];
        rect = CGRectMake(20+ mlabel.frame.size.width+10, 0, cell.frame.size.width - mlabel.frame.size.width -30, cell.frame.size.height);
        mlabel = [[UILabel alloc] initWithFrame:rect];
        mlabel.lineBreakMode = UILineBreakModeWordWrap;
        mlabel.numberOfLines = 0;
        mlabel.tag = 3;
        [cell addSubview:mlabel];
        [mlabel release];
    }
    return cell;
}

-(IBAction)toKanji:(id)sender {
    NSString *selectedKanjiTitle = [(UIButton *)sender currentTitle];
    NSString *kanjiLiteralAtIndexk;
    NSInteger idx;
    if ([selectedKanjiTitle isEqualToString:@" "]) {
        //pass
    }
    else 
    {
        for (int k=0;k<[kanjiList count]; k++) {
            //NSLog(selectedKanjiTitle);
            kanjiLiteralAtIndexk = [NSString stringWithString:[[kanjiList objectAtIndex:k] literal]];
            if ([kanjiLiteralAtIndexk isEqualToString:selectedKanjiTitle]) {
                idx = k;
                break;
            }
        }
        
        KanjiViewController *kanjiVC = [[KanjiViewController alloc] initWithNibName:@"KanjiViewController" bundle:nil];
        kanjiVC.kanji = [kanjiList objectAtIndex:idx];
        kanjiVC.managedObjectContext = managedObjectContext;
        [self.navigationController pushViewController:kanjiVC animated:YES];
        [kanjiVC release];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    if ([type isEqualToString:@"list"]) {
        NSInteger idx = indexPath.section*[self.tableView numberOfRowsInSection:indexPath.section]+indexPath.row;
        idx = MIN(idx, [kanjiList count]);
        KanjiViewController *kanjiVC = [[KanjiViewController alloc] initWithNibName:@"KanjiViewController" bundle:nil];
        kanjiVC.kanji = [kanjiList objectAtIndex:idx];
        [self.navigationController pushViewController:kanjiVC animated:YES];
        [kanjiVC release];
    }
}

@end
