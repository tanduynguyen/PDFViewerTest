//
//  PTViewController.m
//  PDFViewerTest
//
//  Created by viet on 2/6/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "PTViewController.h"

@interface PTViewController ()

@end

@implementation PTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"PDFs/Duet_Grandparents_Oct_Nov_Dec-2012" ofType:@"pdf"];  //Oct-Dec 2012-success story //Duet_Grandparents_Oct_Nov_Dec-2012
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:file password:nil];
    
    if (document != nil)
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
		readerViewController.delegate = (id) self;
        
		readerViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;        
        
        [self presentViewController:readerViewController animated:YES completion:nil];
    }

}

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    NSLog(@"Go Back");
}

- (void)contentView:(ReaderContentView *)contentView touchesBegan:(NSSet *)touches
{
    NSLog(@"Test");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
