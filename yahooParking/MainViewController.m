//
//  MainViewController.m
//  yahooParking
//
//  Created by Derrick Or on 7/24/14.
//  Copyright (c) 2014 derrickor. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSDictionary *stats;
@property (strong, nonatomic) IBOutlet UILabel *cLabel;
@property (strong, nonatomic) IBOutlet UILabel *bLabel;
@property (strong, nonatomic) IBOutlet UILabel *dLabel;
@property (strong, nonatomic) IBOutlet UILabel *eLabel;
@property (strong, nonatomic) IBOutlet UILabel *gLabel;
@property (strong, nonatomic) IBOutlet UIImageView *smCar;
@property (strong, nonatomic) IBOutlet UIImageView *mdCar;
@property (strong, nonatomic) IBOutlet UIImageView *bgCarImage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;
@property (strong, nonatomic) IBOutlet UIView *refreshingView;

@property (strong, nonatomic) IBOutlet UIView *cBubbleView;
@property (strong, nonatomic) IBOutlet UIView *dBubbleView;
@property (strong, nonatomic) IBOutlet UIView *bBubbleView;
@property (strong, nonatomic) IBOutlet UIView *eBubbleView;
@property (strong, nonatomic) IBOutlet UIView *gBubbleView;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.cLabel.hidden = YES;
    self.bLabel.hidden = YES;
    self.dLabel.hidden = YES;
    self.eLabel.hidden = YES;
    self.gLabel.hidden = YES;
    
    [self.scrollView setDelegate:self];
    
    //CGSize sz = CGSizeMake(320, 500);
    //self.scrollView.contentSize = sz;
    
    [self updateStats];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateStats
{
    /*
    NSURL *requestUrl = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=06a132f82ae744fe9c48ff2258dbaaa8"];
    */

    NSURL *requestUrl = [NSURL URLWithString:@"http://ymsegads-01.ops.corp.gq1.yahoo.com/projects/hack/ycanpark/get/index.php"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        //NSLog(@"url %@",requestUrl);
        //NSLog(@"response: %@", response);
        //NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        //NSLog(@"statusCode: %d", statusCode);
        //NSLog(@"data: %@", data);
        
        NSString *json = [NSString stringWithContentsOfURL:requestUrl
                                 encoding:NSASCIIStringEncoding
                                    error:nil];
        NSRange rangeOfSubstring = [json rangeOfString:@"}"];
        json = [json substringToIndex:rangeOfSubstring.location+1];
        
        NSDictionary *JSON =
        [NSJSONSerialization JSONObjectWithData: [json dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        
        NSLog(@"json: %@", json);
        NSLog(@"JSON: %@", JSON);
        
        self.stats = JSON;
        
        /*
        NSDictionary *object = [NSJSONSerialization
                                JSONObjectWithData: data
                                options: NSJSONReadingMutableContainers
                                error: nil];
        */
        
        
        //id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //self.stats = object;
        
        /*
         self.stats = @{
         @"c": @"",
         @"b": @78,
         @"d": @9,
         @"e": @3,
         @"g": @12
         };
         */
        
        self.cLabel.text = @"?";
        self.bLabel.text = @"?";
        self.dLabel.text = @"?";
        self.eLabel.text = @"?";
        self.gLabel.text = @"?";
        
        self.cLabel.hidden = NO;
        self.bLabel.hidden = NO;
        self.dLabel.hidden = NO;
        self.eLabel.hidden = NO;
        self.gLabel.hidden = NO;
        
        self.loader.hidden = YES;
        self.refreshingView.hidden = YES;
        
        if([self.stats[@"c"] integerValue] > 0) {
            self.cLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"c"]];
        }
        if([self.stats[@"b"] integerValue] > 0) {
            self.bLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"b"]];
        }
        if([self.stats[@"d"] integerValue] > 0) {
            self.dLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"d"]];
        }
        if([self.stats[@"e"] integerValue] > 0) {
            self.eLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"e"]];
        }
        if([self.stats[@"g"] integerValue] > 0) {
            self.gLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"g"]];
        }
        

    }];
    
    [self performSelector:@selector(updateStats) withObject:nil afterDelay:30];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; {
    self.bgCarImage.image = [UIImage imageNamed:@"big_car"];
    [self updateStats];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //Hide labels
    self.cLabel.hidden = YES;
    self.bLabel.hidden = YES;
    self.dLabel.hidden = YES;
    self.eLabel.hidden = YES;
    self.gLabel.hidden = YES;
    self.refreshingView.hidden = NO;
    self.loader.hidden = NO;
    
    //NSLog(@"scrolling %f", scrollView.contentOffset.y);
    
    self.bgCarImage.image = [UIImage imageNamed:@"big_car2"];
    
    CGRect bubbleFrame = self.cBubbleView.frame;
    bubbleFrame.origin.y = 52-(scrollView.contentOffset.y*.6);
    self.cBubbleView.frame = bubbleFrame;
    
    CGRect dBubbleFrame = self.dBubbleView.frame;
    dBubbleFrame.origin.y = 233-(scrollView.contentOffset.y*.80);
    self.dBubbleView.frame = dBubbleFrame;
    
    CGRect bBubbleFrame = self.bBubbleView.frame;
    bBubbleFrame.origin.y = 115-(scrollView.contentOffset.y*.70);
    self.bBubbleView.frame = bBubbleFrame;

    CGRect eBubbleFrame = self.eBubbleView.frame;
    eBubbleFrame.origin.y = 338-(scrollView.contentOffset.y*.90);
    self.eBubbleView.frame = eBubbleFrame;
    
    CGRect gBubbleFrame = self.gBubbleView.frame;
    gBubbleFrame.origin.y = 313-(scrollView.contentOffset.y*.90);
    self.gBubbleView.frame = gBubbleFrame;
    
    CGRect smCarFrame = self.smCar.frame;
    smCarFrame.origin.y = 170-(scrollView.contentOffset.y*.91);
    self.smCar.frame = smCarFrame;
    
    CGRect mdCarFrame = self.mdCar.frame;
    mdCarFrame.origin.y = 165-(scrollView.contentOffset.y*.94);
    self.mdCar.frame = mdCarFrame;
}

@end
