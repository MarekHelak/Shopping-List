//
//  ViewController.m
//  ShoppingList
//
//  Created by Marek on 20.04.2015.
//  Copyright (c) 2015 Marek Helak. All rights reserved.
//

#import "ViewController.h"
#import "UIEditAlertView.h"

@interface ViewController ()

@property NSMutableArray *items;
@property NSInteger selectedRowTemplate;

@end

@implementation ViewController
@synthesize items, selectedRowTemplate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=
    [UIColor colorWithPatternImage:
     [UIImage imageNamed:@"free-paper-texture-10.png"]];
    items = @[@"Apples", @"Eggs", @"Juice", @"Carrots"].mutableCopy;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //Save data for table if nessesary
}

#pragma mark - ProtocolMethods
-(NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
    {
    return [items count];
}

//Cell properties
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"cell"];
        }
    
    cell.textLabel.text = items[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//Edit cells
- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//Select row
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.selectedRowTemplate = indexPath.row;
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    } else {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
    NSLog(@"%@ was selected", @(selectedRowTemplate));
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
    {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
        [items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
        withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Dialog Body

//Add to table index
- (IBAction)clickPlus:(id)sender {
    
    //Alert Body
    UIAlertController* alert = [[UIAlertController
            alertControllerWithTitle:@"Add product"
            message:@"Enter product name"
            preferredStyle:UIAlertControllerStyleAlert]
            init];
    
    //Alert Button ok
    UIAlertAction* ok = [UIAlertAction
            actionWithTitle:@"OK"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * action)
               {
                //Get text from UIAlert array
                 NSString *text = ((UITextField* )[alert.textFields objectAtIndex:0]).text;
                   
                 //Check, if products not includes only space
                 if ([[text stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceCharacterSet]]
                    length] != 0)
                    {
                    //Insert to table
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    [items insertObject:text atIndex:0];
                
                    }
                 else {
                    //Dismiss
                    }
                    }];
    
    //Alert button cancel
    UIAlertAction* cancel = [UIAlertAction
               actionWithTitle:@"Cancel"
               style:UIAlertActionStyleDefault
               handler:^(UIAlertAction *action)
                   {
                      // Dismiss
                    }];
    
    //Set buttons and text for dialog
    [alert addAction:ok];
    [alert addAction:cancel];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){}];
    [self presentViewController:alert animated:true completion:nil];
    
}


//Edit current row
- (IBAction)clickEdit:(id)sender {
    
    //Check if list is empty
    if ([items count] == 0) {
        
        UIAlertController* alert = [[UIAlertController
                            alertControllerWithTitle:@"Edit"
                            message:@"List is empty"
                            preferredStyle:UIAlertControllerStyleAlert]
                           init];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:true completion:nil];
    
    //List is not empty
    } else {
    
    //Alert Body
    UIAlertController* alert = [[UIAlertController
                                 alertControllerWithTitle:@"Edit"
                                 message:@"Edit product name"
                                 preferredStyle:UIAlertControllerStyleAlert]
                                init];
    
    //Alert Button ok
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Get text from selected row
                             NSString *text = ((UITextField* )
                                               [alert.textFields objectAtIndex:0]).text;
                             
                             //Check, if products not includes only space
                             if ([[text stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]]
                                  length] != 0)
                             {
                                 //Replace items and reload
                                 [items replaceObjectAtIndex:selectedRowTemplate withObject:text];
                     
                                 
                             }
                             else {
                                 //Dismiss
                             }
                         }];
    
    //Alert button cancel
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault

                             {
                                 // Dismiss
                             }];
    
    //Set buttons and text for dialog
    [alert addAction:ok];
    [alert addAction:cancel];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.text = items[selectedRowTemplate];
    }];
    [self presentViewController:alert animated:true completion:nil];
    }
}


@end
