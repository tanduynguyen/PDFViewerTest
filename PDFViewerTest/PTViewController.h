//
//  PTViewController.h
//  PDFViewerTest
//
//  Created by viet on 2/6/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReaderViewController.h"

@interface PTViewController : UIViewController <ReaderContentViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *pdfReader;

@end
