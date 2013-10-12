//
//  IKViewController.m
//  DynamicsPlayground
//
//  Created by ilteris on 10/12/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "IKViewController.h"

@interface IKViewController () <UICollisionBehaviorDelegate>

@end

@implementation IKViewController

UIDynamicAnimator* _animator;
UIGravityBehavior* _gravity;
UICollisionBehavior* _collision;
BOOL _firstContact;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    square.backgroundColor = [UIColor grayColor];
    [self.view addSubview:square];
    
    UIView* barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
    barrier.backgroundColor = [UIColor redColor];
    [self.view addSubview:barrier];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    //This class keeps track of the various behaviors that you add to the engine, such as gravity, and provides the overall context. When you create an instance of an animator, you pass in a reference view that the animator uses to define its coordinate system.
    
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
    //models the behavior of gravity and exerts forces on one or more items, allowing you to model physical interactions. When you create an instance of a behavior, you associate it with a set of items — typically views. This way you can select which items are influenced by the behavior, in this case which items the gravitational forces affect.
    [_animator addBehavior:_gravity];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    //The above code creates a collision behavior, which defines one or more boundaries with which the associated items interact.
    _collision.collisionDelegate = self;
    
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x + barrier.frame.size.width,
                                    barrier.frame.origin.y);
    
    
    [_collision addBoundaryWithIdentifier:@"barrier"
                                fromPoint:barrier.frame.origin toPoint:rightEdge];
    // The above code adds an invisible boundary that coincides with the top edge of the barrier view.
    
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    //Rather than explicitly adding boundary co-ordinates, the above code sets the translatesReferenceBoundsIntoBoundary property to YES. This causes the boundary to use the bounds of the reference view supplied to the UIDynamicAnimator.
    [_animator addBehavior:_collision];
    
    UIDynamicItemBehavior* itemBehaviour =
    [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
    itemBehaviour.elasticity = 0.6; [_animator addBehavior:itemBehaviour];
}




- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSLog(@"Boundary contact occurred - %@", identifier);
//This delegate method is fired off when a collision occurs and prints out a log message to the console.
    
    UIView* view = (UIView*)item; view.backgroundColor = [UIColor yellowColor]; [UIView animateWithDuration:0.1 animations:^{
        view.backgroundColor = [UIColor grayColor];
    }];
    
    
    if (!_firstContact)
    {
        _firstContact = YES;
        UIView* square = [[UIView alloc] initWithFrame:CGRectMake(90, 0, 100, 100)];
        square.backgroundColor = [UIColor grayColor]; [self.view addSubview:square];
        [_collision addItem:square]; [_gravity addItem:square];
        
        UIDynamicItemBehavior* itemBehaviour =
        [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
        itemBehaviour.elasticity = 0.6; [_animator addBehavior:itemBehaviour];
        
        /*
        UIAttachmentBehavior* attach = [[UIAttachmentBehavior alloc] initWithItem:view attachedToItem:square];
        [_animator addBehavior:attach];
         */
        
        }
    
   // The above code detects the initial contact between the barrier and the square, creates a second square and adds it to the collision and gravity behaviors. In addition, you set up an attachment behavior to create the effect of attaching a pair of objects with a virtual spring.
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
