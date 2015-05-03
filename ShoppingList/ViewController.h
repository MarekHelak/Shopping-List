//
//  ViewController.h
//  ShoppingList
//
//  Created by Marek on 20.04.2015.
//  Copyright (c) 2015 Marek Helak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView *tableView;

- (IBAction)clickPlus:(id)sender;
- (IBAction)clickEdit:(id)sender;

@end

