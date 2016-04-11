//
//  ViewController.m
//  SDStepper
//
//  Created by shansander on 16/4/10.
//  Copyright © 2016年 shansander. All rights reserved.
//

#import "ViewController.h"
#import "SDStepper.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    SDStepper * stepper = [[SDStepper alloc] init];
    
    CGRect selfRect = [[UIScreen mainScreen] bounds];
    stepper.center = CGPointMake(selfRect.size.width/2.0f, selfRect.size.height/2.0f);
    [self.view addSubview:stepper];
    [stepper setLeftText:@"消息" rightText:@"联系人"];
    [stepper setStepperBackColor:[UIColor blueColor]];
    [self.view setBackgroundColor:[UIColor blueColor]];
    [stepper addTarget:self action:@selector(stepAction:)];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)stepAction:(id)sender
{
    SDStepper * sd = (SDStepper*)sender;
    NSLog(@"这个是动作判断 %d",sd.currentSideModel);
    
}

@end
