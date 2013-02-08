//
//  PTReadADateViewController.m
//  PDFViewerTest
//
//  Created by viet on 2/8/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "PTReadADateViewController.h"

@interface PTReadADateViewController () {

    UIScrollView *theScrollView;
    ReaderMainToolbar *mainToolbar;
    ReaderMainPagebar *mainPagebar;

}

@end

@implementation PTReadADateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
        
        for (UIView * subView in readerViewController.view.subviews) {
            if ([subView isKindOfClass:[UIScrollView class]]) {            
                theScrollView = (UIScrollView *)subView;
//                theScrollView addObserver:<#(NSObject *)#> forKeyPath:<#(NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>
            } else if ([subView isKindOfClass:[ReaderMainToolbar class]]) {
                mainToolbar = (ReaderMainToolbar *)subView;
            } else if ([subView isKindOfClass:[ReaderMainPagebar class]]) {
                mainPagebar = (ReaderMainPagebar *)subView;
            }
        }
    }
    
}

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    NSLog(@"Go Back");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)contentView:(ReaderContentView *)contentView touchesBegan:(NSSet *)touches
{
    
}

@end
