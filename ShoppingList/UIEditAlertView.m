//
//  UIEditAlertView.m
//  ShoppingList
//
//  Created by Marek on 23.04.2015.
//  Copyright (c) 2015 Marek Helak. All rights reserved.
//

#import "UIEditAlertView.h"

@implementation UIEditAlertView


-(void)viewWillAppear:(BOOL)animated
{
 
    
    
    //Set Button
    UIAlertAction *okActionButton = [UIAlertAction
                                     actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction *action)
                                     {
                                         UITextField *login = self.textFields.firstObject;
                                     }];
    UIAlertAction *cancelActionButton = [UIAlertAction
                                     actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction *action)
                                     {
                                         UITextField *login = self.textFields.firstObject;
                                     }];
    self.title = @"title";
    self.message =@"This is my message";

    //Merge Button with Alert Dialog
    [self addAction:okActionButton];
    [self addAction:okActionButton];
}

@end
