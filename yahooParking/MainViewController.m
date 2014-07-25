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
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *dLoader;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *cLoader;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *bLoader;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *eLoader;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *gLoader;
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
    self.cLabel.hidden = YES;
    self.bLabel.hidden = YES;
    self.dLabel.hidden = YES;
    self.eLabel.hidden = YES;
    self.gLabel.hidden = YES;
    self.cLoader.hidden = NO;
    self.bLoader.hidden = NO;
    self.dLoader.hidden = NO;
    self.eLoader.hidden = NO;
    self.gLoader.hidden = NO;
    
    NSURL *instagramUrl = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=06a132f82ae744fe9c48ff2258dbaaa8"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:instagramUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //NSLog(@"RESPONSE: %@", object[@"data"]);
        
        self.stats = @{
                       @"c": @23,
                       @"b": @78,
                       @"d": @121,
                       @"e": @3,
                       @"g": @12
                       };
        
        self.cLabel.hidden = NO;
        self.bLabel.hidden = NO;
        self.dLabel.hidden = NO;
        self.eLabel.hidden = NO;
        self.gLabel.hidden = NO;
        
        self.cLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"c"]];
        self.bLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"b"]];
        self.dLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"d"]];
        self.eLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"e"]];
        self.gLabel.text = [NSString stringWithFormat:@"%@", self.stats[@"g"]];
        self.cLoader.hidden = YES;
        self.bLoader.hidden = YES;
        self.dLoader.hidden = YES;
        self.eLoader.hidden = YES;
        self.gLoader.hidden = YES;
        //self.photos = object[@"data"];
        //[self.tableView reloadData];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; {
    [self updateStats];
}

@end
