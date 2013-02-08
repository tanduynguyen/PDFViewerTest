//
//	ReaderMainToolbar.m
//	Reader v2.5.4
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2012 Julius Oklamcak. All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//	of the Software, and to permit persons to whom the Software is furnished to
//	do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ReaderConstants.h"
#import "ReaderMainToolbar.h"
#import "ReaderDocument.h"

#import <MessageUI/MessageUI.h>

@implementation ReaderMainToolbar

#pragma mark Constants

#define BUTTON_X 8.0f
#define BUTTON_Y 8.0f
#define BUTTON_SPACE 5.0f
#define BUTTON_HEIGHT 30.0f

#define DONE_BUTTON_WIDTH 100.0f
#define THUMBS_BUTTON_WIDTH 40.0f
#define PRINT_BUTTON_WIDTH 40.0f
#define EMAIL_BUTTON_WIDTH 40.0f
#define MARK_BUTTON_WIDTH 40.0f

#define TEXT_BUTTON_WIDTH 60.0f //customized by tanduy
#define SHARE_BUTTON_WIDTH 35.0f //customized by tanduy

#define TITLE_HEIGHT 28.0f

#pragma mark Properties

@synthesize delegate;

#pragma mark ReaderMainToolbar instance methods

- (id)initWithFrame:(CGRect)frame
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	return [self initWithFrame:frame document:nil];
}

- (id)initWithFrame:(CGRect)frame document:(ReaderDocument *)object
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	assert(object != nil); // Check

	if ((self = [super initWithFrame:frame]))
	{
		CGFloat viewWidth = self.bounds.size.width;

		UIImage *imageH = [UIImage imageNamed:@"Reader-Button-H.png"];
		UIImage *imageN = [UIImage imageNamed:@"Reader-Button-N.png"];

		UIImage *buttonH = [imageH stretchableImageWithLeftCapWidth:5 topCapHeight:0];
		UIImage *buttonN = [imageN stretchableImageWithLeftCapWidth:5 topCapHeight:0];

		CGFloat titleX = BUTTON_X; CGFloat titleWidth = (viewWidth - (titleX + titleX));

		CGFloat leftButtonX = BUTTON_X; // Left button start X position

#if (READER_STANDALONE == FALSE) // Option

		UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];

		doneButton.frame = CGRectMake(leftButtonX, BUTTON_Y, DONE_BUTTON_WIDTH, BUTTON_HEIGHT);
//		[doneButton setTitle:NSLocalizedString(@"Done", @"button") forState:UIControlStateNormal]; //customized by tanduy
        [doneButton setImage:[UIImage imageNamed:@"bt_backtolib"] forState:UIControlStateNormal]; //customized by tanduy
		[doneButton setTitleColor:[UIColor colorWithWhite:0.0f alpha:1.0f] forState:UIControlStateNormal];
		[doneButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forState:UIControlStateHighlighted];
		[doneButton addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//		[doneButton setBackgroundImage:buttonH forState:UIControlStateHighlighted]; //customized by tanduy
//		[doneButton setBackgroundImage:buttonN forState:UIControlStateNormal]; //customized by tanduy
		doneButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
		doneButton.autoresizingMask = UIViewAutoresizingNone;

		[self addSubview:doneButton]; leftButtonX += (DONE_BUTTON_WIDTH + BUTTON_SPACE);

		titleX += (DONE_BUTTON_WIDTH + BUTTON_SPACE); titleWidth -= (DONE_BUTTON_WIDTH + BUTTON_SPACE);

#endif // end of READER_STANDALONE Option

        
        // BEGIN OF customized by tanduy
		textButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
		textButton.frame = CGRectMake(leftButtonX, BUTTON_Y, TEXT_BUTTON_WIDTH, BUTTON_HEIGHT);
        [textButton setImage:[UIImage imageNamed:@"bt_text"] forState:UIControlStateNormal];
		[textButton setTitleColor:[UIColor colorWithWhite:0.0f alpha:1.0f] forState:UIControlStateNormal];
		[textButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forState:UIControlStateHighlighted];
        //		[textButton addTarget:self action:@selector(textButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		textButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
		textButton.autoresizingMask = UIViewAutoresizingNone;
        
		[self addSubview:textButton]; leftButtonX += (TEXT_BUTTON_WIDTH + BUTTON_SPACE);
        
		shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
		shareButton.frame = CGRectMake(leftButtonX, BUTTON_Y, SHARE_BUTTON_WIDTH, BUTTON_HEIGHT);
        [shareButton setImage:[UIImage imageNamed:@"bt_share"] forState:UIControlStateNormal];
		[shareButton setTitleColor:[UIColor colorWithWhite:0.0f alpha:1.0f] forState:UIControlStateNormal];
		[shareButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forState:UIControlStateHighlighted];
        //		[textButton addTarget:self action:@selector(shareButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		shareButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
		shareButton.autoresizingMask = UIViewAutoresizingNone;
        
		[self addSubview:shareButton]; leftButtonX += (SHARE_BUTTON_WIDTH + BUTTON_SPACE);
        // END OF customized by tanduy
        
#if (READER_ENABLE_THUMBS == TRUE) // Option

		thumbsButton = [UIButton buttonWithType:UIButtonTypeCustom];

		thumbsButton.frame = CGRectMake(leftButtonX, BUTTON_Y, THUMBS_BUTTON_WIDTH, BUTTON_HEIGHT);
		[thumbsButton setImage:[UIImage imageNamed:@"Reader-Thumbs.png"] forState:UIControlStateNormal];
		[thumbsButton addTarget:self action:@selector(thumbsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		[thumbsButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
		[thumbsButton setBackgroundImage:buttonN forState:UIControlStateNormal];
		thumbsButton.autoresizingMask = UIViewAutoresizingNone;

		[self addSubview:thumbsButton]; //leftButtonX += (THUMBS_BUTTON_WIDTH + BUTTON_SPACE);

		titleX += (THUMBS_BUTTON_WIDTH + BUTTON_SPACE); titleWidth -= (THUMBS_BUTTON_WIDTH + BUTTON_SPACE);

#endif // end of READER_ENABLE_THUMBS Option

		CGFloat rightButtonX = viewWidth; // Right button start X position
        
        // BEGIN OF customized by tanduy
        UIButton *moreButton;
        
        if (!IS_IPAD) {
            rightButtonX -= (PRINT_BUTTON_WIDTH + BUTTON_SPACE);
            
            moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            moreButton.frame = CGRectMake(rightButtonX, BUTTON_Y, PRINT_BUTTON_WIDTH, BUTTON_HEIGHT);
            [moreButton setTitle:NSLocalizedString(@"More", @"button") forState:UIControlStateNormal];
            moreButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [moreButton setTitleColor:[UIColor colorWithWhite:0.0f alpha:1.0f] forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forState:UIControlStateHighlighted];
            [moreButton addTarget:self action:@selector(moreButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [moreButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
            [moreButton setBackgroundImage:buttonN forState:UIControlStateNormal];
            moreButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            
            [self addSubview:moreButton]; titleWidth -= (PRINT_BUTTON_WIDTH + BUTTON_SPACE);
        }
        // END OF customized by tanduy
        
#if (READER_BOOKMARKS == TRUE) // Option

		rightButtonX -= (MARK_BUTTON_WIDTH + BUTTON_SPACE);

		flagButton = [UIButton buttonWithType:UIButtonTypeCustom];

		flagButton.frame = CGRectMake(rightButtonX, BUTTON_Y, MARK_BUTTON_WIDTH, BUTTON_HEIGHT);
		//[flagButton setImage:[UIImage imageNamed:@"Reader-Mark-N.png"] forState:UIControlStateNormal];
		[flagButton addTarget:self action:@selector(markButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		[flagButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
		[flagButton setBackgroundImage:buttonN forState:UIControlStateNormal];
		flagButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

		[self addSubview:flagButton]; titleWidth -= (MARK_BUTTON_WIDTH + BUTTON_SPACE);

		markButton = flagButton; markButton.enabled = NO; markButton.tag = NSIntegerMin;

		markImageN = [UIImage imageNamed:@"Reader-Mark-N.png"]; // N image
		markImageY = [UIImage imageNamed:@"Reader-Mark-Y.png"]; // Y image

#endif // end of READER_BOOKMARKS Option
        
        
#if (READER_ENABLE_MAIL == TRUE) // Option

		if ([MFMailComposeViewController canSendMail] == YES) // Can email
		{
			unsigned long long fileSize = [object.fileSize unsignedLongLongValue];

			if (fileSize < (unsigned long long)15728640) // Check attachment size limit (15MB)
			{
				rightButtonX -= (EMAIL_BUTTON_WIDTH + BUTTON_SPACE);

				emailButton = [UIButton buttonWithType:UIButtonTypeCustom];

				emailButton.frame = CGRectMake(rightButtonX, BUTTON_Y, EMAIL_BUTTON_WIDTH, BUTTON_HEIGHT);
				[emailButton setImage:[UIImage imageNamed:@"Reader-Email.png"] forState:UIControlStateNormal];
				[emailButton addTarget:self action:@selector(emailButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
				[emailButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
				[emailButton setBackgroundImage:buttonN forState:UIControlStateNormal];
				emailButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

				[self addSubview:emailButton]; titleWidth -= (EMAIL_BUTTON_WIDTH + BUTTON_SPACE);
			}
		}

#endif // end of READER_ENABLE_MAIL Option

#if (READER_ENABLE_PRINT == TRUE) // Option

		if (object.password == nil) // We can only print documents without passwords
		{
			Class printInteractionController = NSClassFromString(@"UIPrintInteractionController");

			if ((printInteractionController != nil) && [printInteractionController isPrintingAvailable])
			{
				rightButtonX -= (PRINT_BUTTON_WIDTH + BUTTON_SPACE);

				printButton = [UIButton buttonWithType:UIButtonTypeCustom];

				printButton.frame = CGRectMake(rightButtonX, BUTTON_Y, PRINT_BUTTON_WIDTH, BUTTON_HEIGHT);
				[printButton setImage:[UIImage imageNamed:@"Reader-Print.png"] forState:UIControlStateNormal];
				[printButton addTarget:self action:@selector(printButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
				[printButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
				[printButton setBackgroundImage:buttonN forState:UIControlStateNormal];
				printButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

				[self addSubview:printButton]; titleWidth -= (PRINT_BUTTON_WIDTH + BUTTON_SPACE);
			}
		}

#endif // end of READER_ENABLE_PRINT Option

		titleX += (DONE_BUTTON_WIDTH + BUTTON_SPACE); titleWidth -= (DONE_BUTTON_WIDTH + BUTTON_SPACE);
        
		if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
		{
			CGRect titleRect = CGRectMake(titleX, BUTTON_Y, titleWidth, TITLE_HEIGHT);

			UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleRect];

			titleLabel.textAlignment = NSTextAlignmentCenter;
			titleLabel.font = [UIFont systemFontOfSize:19.0f]; // 19 pt
			titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
			titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			titleLabel.textColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
			titleLabel.shadowColor = [UIColor colorWithWhite:0.65f alpha:1.0f];
			titleLabel.backgroundColor = [UIColor clearColor];
			titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
			titleLabel.adjustsFontSizeToFitWidth = YES;
			titleLabel.minimumScaleFactor = 14.0f;
			titleLabel.text = [object.fileName stringByDeletingPathExtension];

			[self addSubview:titleLabel]; 
		}
        
        if (!IS_IPAD) {
            [self moreButtonTapped:moreButton];
        }
	}

	return self;
}

- (void)dealloc
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	markButton = nil;

	markImageN = nil;
	markImageY = nil;

}

- (void)setBookmarkState:(BOOL)state
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

#if (READER_BOOKMARKS == TRUE) // Option

	if (state != markButton.tag) // Only if different state
	{
		if (self.hidden == NO) // Only if toolbar is visible
		{
			UIImage *image = (state ? markImageY : markImageN);

			[markButton setImage:image forState:UIControlStateNormal];
		}

		markButton.tag = state; // Update bookmarked state tag
	}

	if (markButton.enabled == NO) markButton.enabled = YES;

#endif // end of READER_BOOKMARKS Option
}

- (void)updateBookmarkImage
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

#if (READER_BOOKMARKS == TRUE) // Option

	if (markButton.tag != NSIntegerMin) // Valid tag
	{
		BOOL state = markButton.tag; // Bookmarked state

		UIImage *image = (state ? markImageY : markImageN);

		[markButton setImage:image forState:UIControlStateNormal];
	}

	if (markButton.enabled == NO) markButton.enabled = YES;

#endif // end of READER_BOOKMARKS Option
}

- (void)hideToolbar
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	if (self.hidden == NO)
	{
		[UIView animateWithDuration:0.25 delay:0.0
			options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
			animations:^(void)
			{
				self.alpha = 0.0f;
			}
			completion:^(BOOL finished)
			{
				self.hidden = YES;
			}
		];
	}
}

- (void)showToolbar
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	if (self.hidden == YES)
	{
		[self updateBookmarkImage]; // First

		[UIView animateWithDuration:0.25 delay:0.0
			options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
			animations:^(void)
			{
				self.hidden = NO;
				self.alpha = 1.0f;
			}
			completion:NULL
		];
	}
}

#pragma mark UIButton action methods

- (void)moreButtonTapped:(UIButton *)button
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    bool isDisplay = markButton.hidden;
    markButton.hidden = flagButton.hidden = emailButton.hidden = printButton.hidden = !isDisplay;
    thumbsButton.hidden = textButton.hidden = shareButton.hidden = isDisplay;    
    
    [button setTitle:NSLocalizedString((isDisplay ? @"Hide" : @"More"), @"button") forState:UIControlStateNormal];
    
	//[delegate tappedInToolbar:self moreButton:button];
}

- (void)doneButtonTapped:(UIButton *)button
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	[delegate tappedInToolbar:self doneButton:button];
}

- (void)thumbsButtonTapped:(UIButton *)button
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	[delegate tappedInToolbar:self thumbsButton:button];
}

- (void)printButtonTapped:(UIButton *)button
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	[delegate tappedInToolbar:self printButton:button];
}

- (void)emailButtonTapped:(UIButton *)button
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	[delegate tappedInToolbar:self emailButton:button];
}

- (void)markButtonTapped:(UIButton *)button
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	[delegate tappedInToolbar:self markButton:button];
}

@end
