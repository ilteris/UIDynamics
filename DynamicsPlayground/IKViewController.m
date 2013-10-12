//
//  IKViewController.m
//  DynamicsPlayground
//
//  Created by ilteris on 10/12/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "IKViewController.h"

@interface IKViewController ()

@end

@implementation IKViewController

UIDynamicAnimator* _animator;
UIGravityBehavior* _gravity;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    square.backgroundColor = [UIColor grayColor];
    [self.view addSubview:square];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
    [_animator addBehavior:_gravity];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
