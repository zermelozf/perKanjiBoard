//
//  TableViewCellWithColumns.m
//  KanjiBoard
//
//  Created by apple on 21/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewCellWithColumns.h"


@implementation TableViewCellWithColumns


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
}

-(void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0., 0., 0., 2);
    CGContextSetLineWidth(ctx, 0.1);
    
    for (int col=1; col<NB_COLUMNS; col++) {
        CGContextMoveToPoint(ctx, col*CELL_WIDTH/NB_COLUMNS, 0);
        CGContextAddLineToPoint(ctx, col*CELL_WIDTH/NB_COLUMNS, 60);
    }
    CGContextStrokePath(ctx);
}

- (void)dealloc
{
    [super dealloc];
}

@end
