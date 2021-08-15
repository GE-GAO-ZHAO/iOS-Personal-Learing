//
//  ViewController.m
//  notification_test
//
//  Created by 葛高召 on 2021/8/11.
//

#import "ViewController.h"
#import "Test.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtview;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) Test *testObj;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.txtview.text = @"";
    self.testObj = [[Test alloc] init];
    
}

- (IBAction)registerNotify:(id)sender {
    [self.testObj registerNotify:nil];
}

- (IBAction)removeNotify:(id)sender {
    [self.testObj removeNotify:nil];
}

- (IBAction)push:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"xxx" object:nil];
}


@end
