//
//  FirstViewController.m
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 4/15/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//

#import "HomeViewController.h"
#import "QuartzCore/QuartzCore.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Kal/Kal.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    SystemSoundID winSoundID;
}


- (void)viewDidLoad
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:4];
    [UIView setAnimationCurve:1];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-50, -50);
    CGAffineTransform transform2 = CGAffineTransformMakeTranslation(50, -50);
    CGAffineTransform transform3 = CGAffineTransformMakeTranslation(20, 0);
    CGAffineTransform transform4 = CGAffineTransformMakeScale(4,4);

    _rightHand.transform = transform;
    _leftHand.transform = transform2;
    _logo.transform = transform3;
    _welcome.transform = transform4;
    
    // Commit the changes
    [UIView commitAnimations];
    
    // Play sound
    [self playWinSound];
}

- (void)playWinSound
{
    if (winSoundID == 0){
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"sound" withExtension:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(soundURL), &winSoundID);
    }
    AudioServicesPlaySystemSound(winSoundID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
