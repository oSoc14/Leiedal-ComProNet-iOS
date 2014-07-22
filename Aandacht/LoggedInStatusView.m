//
//  LoggedInStatusView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 11/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "LoggedInStatusView.h"
#import "Constants.h"

@implementation LoggedInStatusView

@synthesize lblStatus = _lblStatus;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:headerBackgroundColor];
        self.layer.borderColor = defaultDarkGrayBorder.CGColor;
        self.layer.borderWidth = 1;

        //LOGGED IN STATUS
        NSString *sentence = [NSString stringWithFormat:@"%@",NSLocalizedString(@"profiel_logged_in_status", @"")];
        NSString *username = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
        NSString *status = [NSString stringWithFormat:@"%@ %@", sentence,username];
        self.lblStatus = [Constants createLabel:status andFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:[UIColor blackColor] andFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        NSLog(@"%lu", (unsigned long)[NSLocalizedString(@"profiel_logged_in_status", @"") length]);
        NSLog(@"[LoggedInStatusView] %lu",(unsigned long)[self.lblStatus.attributedText length]);
        NSLog(@"username length: %lu", (unsigned long)[sentence length]);
        NSLog(@"username length: %lu", (unsigned long)[username length]);
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.lblStatus.attributedText];
        /*[text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:(16/255.0) green:(135/255.0) blue:(218/255.0) alpha:1.00f] range: NSMakeRange([self.lblStatus.attributedText length]-[username length]-1,[self.lblStatus.attributedText length]-7)];
        [self.lblStatus setAttributedText: text];*/
        /*[text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:(16/255.0) green:(135/255.0) blue:(218/255.0) alpha:1.00f] range: NSMakeRange(0,38)];*/
        //SHOULD FORMAT RANGE TO NSINTEGER
        
        [self addSubview:self.lblStatus];
        [self.lblStatus setAttributedText: text];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
