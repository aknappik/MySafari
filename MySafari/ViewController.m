//
//  ViewController.m
//  MySafari
//
//  Created by Alison K. Knappik on 5/14/14.
//  Copyright (c) 2014 aknapp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;


@end

@implementation ViewController
- (IBAction)onBackButtonPressed:(id)sender {
    
    [self.myWebView goBack];
}
- (IBAction)onForwardButtonPressed:(id)sender {
    
    [self.myWebView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    
    [self.myWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    
    [self.myWebView reload];
}
- (IBAction)onPlusButtonPressed:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"Comming Soon";
    alert.delegate = self;
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.backButton setEnabled:YES];
    [self.forwardButton setEnabled:NO];
    self.myWebView.scrollView.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backButton.enabled = self.myWebView.canGoBack;
    self.forwardButton.enabled = self.myWebView.canGoForward;
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.myWebView.scrollView.contentOffset.y>0)
    {
        [self.myURLTextField setHidden:YES];
    }
    else {
        [self.myURLTextField setHidden:NO];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSString *urlString = textField.text;
    if (![urlString hasPrefix:@"http://"])
    {
        urlString = [@"http://" stringByAppendingString:urlString];
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    
    return YES;
}


@end
