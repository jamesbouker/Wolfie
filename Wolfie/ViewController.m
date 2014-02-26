//
//  ViewController.m
//  Wolfie
//
//  Created by Jimmy on 2/26/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Category.h"

//
// The code below contains 4 approaches to moving the image
// To turn the differnt parts on, Change the variable below from PART4 to PART1, PART2, or PART3
//
// PART1: Shows creating random numbers
// PART2: Shws if else logic
// PART3: Shows switch statement - Also Introduces Categories(Advanced)
// PART4: Shows array

#define PART4

@implementation ViewController {
    int screenWidth, screenHeight;
    int wolfWidth, wolfHeight;

    CGPoint topLeft;
    CGPoint topRight;
    CGPoint bottomLeft;
    CGPoint bottomRight;
    
    NSArray *locations;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    screenWidth = self.view.frame.size.width;
    screenHeight = self.view.frame.size.height;
    
    wolfWidth = _wolf.frame.size.width;
    wolfHeight = _wolf.frame.size.height;
    
    topLeft = CGPointMake(-wolfWidth,-wolfHeight);
    topRight = CGPointMake(screenWidth, -wolfHeight);
    bottomLeft = CGPointMake(-wolfWidth, screenHeight);
    bottomRight = CGPointMake(screenWidth, screenHeight);
    
    //NSArrays can only store objects. Since CGPoint is a struct it must first be wrapped into an object
    //You can do this using NSValue.
    //To wrap things such as int, float, bool. You can use the NSNumber class
    locations = @[[NSValue valueWithCGPoint:topLeft], [NSValue valueWithCGPoint:topRight], [NSValue valueWithCGPoint:bottomLeft], [NSValue valueWithCGPoint:bottomRight]];
}

-(void)viewDidLayoutSubviews {
    //this method may be called multiple times, we only want to create the timer once.
    static NSTimer *timer = nil;
    if(timer == nil)
        timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(move) userInfo:nil repeats:YES];
}

#ifdef PART1
//random location

-(void)move {
    int x = arc4random()%(screenWidth - wolfWidth);
    int y = arc4random()%(screenHeight - wolfHeight);
    
    [UIView animateWithDuration:1.0 animations:^{
        _wolf.frame = CGRectMake(x, y, wolfWidth, wolfHeight);
    }];
}

#endif

#ifdef PART2
//random corner -
// *if-else logic*

-(void)move {
    int rand = arc4random()%4;
    CGPoint location;
    if(rand == 0) {
        //multiline is enclosed in brackets
        location = topLeft;
    }
    else if(rand == 1) {
        location = topRight;
    }
    else if(rand == 2)
        location = bottomLeft;  //single line does not use brackets
    else
        location = bottomRight;
    
    [UIView animateWithDuration:1.0 animations:^{
        _wolf.frame = CGRectMake(location.x, location.y, wolfWidth, wolfHeight);
    }];
}

#endif

#ifdef PART3
//move to center then off screen
// *switch statement*

-(void)move {
    [UIView animateWithDuration:0.5 animations:^{
        _wolf.frame = CGRectMake(screenWidth/2 - wolfWidth/2, screenHeight/2 - wolfHeight/2, wolfWidth, wolfHeight);
    } completion:^(BOOL finished) {
        
        int rand = arc4random()%4;
        CGPoint location;
        
        switch (rand) {
            case 0: location = topLeft;     break;
            case 1: location = topRight;    break;
            case 2: location = bottomLeft;  break;
            case 3: location = bottomRight; break;
        }
        
        
        //Note here that we are using a property named 'origin' that normally do not exist.
        //We have added it to the UIView class by creating a Category
        //Hold down 'Command' and click on the 'origin' property to see where it is defined
        [UIView animateWithDuration:0.5 animations:^{
            _wolf.origin = location;
        }];
    }];

}

#endif

#ifdef PART4
//move to center then off screen
// *array*

-(void)move {
    [UIView animateWithDuration:0.5 animations:^{
        _wolf.frame = CGRectMake(screenWidth/2 - wolfWidth/2, screenHeight/2 - wolfHeight/2, wolfWidth, wolfHeight);
    } completion:^(BOOL finished) {
        
        int rand = arc4random()%4;
        CGPoint location = [locations[rand] CGPointValue];
        
        [UIView animateWithDuration:0.5 animations:^{
            _wolf.origin = location;
        }];
    }];
}

#endif

@end
