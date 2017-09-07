//
//  ViewController.m
//  LCActionSheetDemo
//
//  Created by Leo on 16/7/15.
//  Copyright © 2016年 Leo（https://LeoDev.me）. All rights reserved.
//

#import "ViewController.h"
#import <LCActionSheet/LCActionSheet.h>
#import <Masonry/Masonry.h>

#define KEY_WINDOW  [UIApplication sharedApplication].keyWindow

@interface ViewController () <UIAlertViewDelegate, LCActionSheetDelegate>

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = ({
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 8.0, 0);
        view;
    });
    textField.placeholder = @"Tap screen to hide keyboard..";
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.cornerRadius = 4.0;
    textField.layer.shadowColor = [UIColor blackColor].CGColor;
    textField.layer.shadowRadius = 2;
    textField.layer.shadowOpacity = 0.3;
    textField.layer.shadowOffset = CGSizeMake(0, 1.2);
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10.0);
        make.right.equalTo(self.view).offset(-10.0);
        make.top.equalTo(self.view).offset(30.0);
        make.height.offset(44.0);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSLog(@"App's keyWindow: %p", KEY_WINDOW);
}

- (IBAction)showDefaultActionSheet {
//    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"Default LCActionSheet\n\n\n选择你想赠送甜甜圈的个数"
//                                                      delegate:self
//                                             cancelButtonTitle:@"Cancel\n取消"
//                                             otherButtonTitles:@"Button 1", @"Button 2", @"Button 3",@"Button 4 \n自定义", nil];
//    [actionSheet show];
    
    
    LCActionSheet *customViewActionSheet = [LCActionSheet sheetWithTitle:@"Default LCActionSheet\n\n\n选择你想赠送甜甜圈的个数"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel\n取消"
                                            otherCustomImgViews:@[[self otherCustomImgView:@"甜甜圈小"],[self otherCustomImgView:@"甜甜圈小"],[self otherCustomImgView:@"甜甜圈小"],[self otherCustomImgView:@"甜甜圈小"]]
                                                otherButtonTitles:@" X 1",@" X 5",@" X 10",@" X 自定义", nil];
    [customViewActionSheet show];
    
    
    
}

- (UIImage *)otherCustomImgView:(NSString *)imgName{
    UIImage *img = [UIImage imageNamed:imgName];
    return img;
}

- (UIView *)customViewWithStringLab:(NSString *)stringLab {
    
    UIView *customView = [[UIView alloc] init];//WithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 49)
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 16, 16)];
    imgView.backgroundColor = [UIColor grayColor];
    imgView.image = [UIImage imageNamed:@"甜甜圈小"];
    [customView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(126, 10, 100, 16)];
    label.text = [NSString stringWithFormat:@"X %@", stringLab];
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor greenColor];
    [customView addSubview:label];
    NSLog(@"customView:%@",customView);
    return customView;
    
}


- (IBAction)showCustomActionSheet {
    
    LCActionSheet *actionSheet     = [[LCActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                        otherButtonTitles:@"Button 1", @"Button 2", @"Button 3", @"This is a very very very very very very very very very very very long button title~", @"Button 5", nil];
    actionSheet.title              = @"This is a very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very long title~";
    actionSheet.cancelButtonTitle  = @"Close";
    [actionSheet appendButtonsWithTitles:@"Button 6", @"Button 7", nil];
    actionSheet.titleColor         = [UIColor orangeColor];
    actionSheet.buttonColor        = [UIColor greenColor];
    actionSheet.titleFont          = [UIFont boldSystemFontOfSize:15.0f];
    actionSheet.buttonFont         = [UIFont boldSystemFontOfSize:15.0f];
    actionSheet.buttonHeight       = 60.0f;
    actionSheet.scrolling          = YES;
    actionSheet.visibleButtonCount = 3.6f;
    actionSheet.darkViewNoTaped    = YES;
    actionSheet.unBlur             = YES;
    
    // V 2.1.0+ Use `destructiveButtonIndexSet` instead `redButtonIndexSet`.
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    [indexSet addIndex:0];
    [indexSet addIndex:2];
    actionSheet.destructiveButtonIndexSet = indexSet;
    actionSheet.destructiveButtonColor    = [UIColor blueColor];
    
    // V 2.7.0+
    actionSheet.titleEdgeInsets = UIEdgeInsetsMake(10, 20, 30, 40);
    
    // V 2.7.1+
    actionSheet.separatorColor = [UIColor orangeColor];
    
    // V 3.1.0+
    actionSheet.autoHideWhenDeviceRotated = YES;
    
    [actionSheet show];
}

- (IBAction)showBlockActionSheet {
//    LCActionSheetConfig *config = LCActionSheetConfig.config;
//    config.buttonColor = [UIColor orangeColor];
    
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"Block LCActionSheet" cancelButtonTitle:@"Cancel" clicked:^(LCActionSheet *actionSheet, NSUInteger buttonIndex) {
        
        NSLog(@"clickedButtonAtIndex: %d, keyWindow: %p", (int)buttonIndex, KEY_WINDOW);
        
    } otherButtonTitles:@"Button 1", @"Button 2", @"Button 3", @"Button 4", @"Button 5", @"Button 6", nil];
    
    // actionSheet.blurEffectStyle = UIBlurEffectStyleLight;
    
    actionSheet.scrolling          = YES;
    actionSheet.visibleButtonCount = 3.6f;
    
    actionSheet.willPresentHandler = ^(LCActionSheet *actionSheet) {
        NSLog(@"willPresentActionSheet, keyWindow: %p", KEY_WINDOW);
    };
    
    actionSheet.didPresentHandler = ^(LCActionSheet *actionSheet) {
        NSLog(@"didPresentActionSheet, keyWindow: %p", KEY_WINDOW);
    };
    
    actionSheet.willDismissHandler = ^(LCActionSheet *actionSheet, NSUInteger buttonIndex) {
        NSLog(@"willDismissWithButtonIndex: %d, keyWindow: %p", (int)buttonIndex, KEY_WINDOW);
    };
    
    actionSheet.didDismissHandler = ^(LCActionSheet *actionSheet, NSUInteger buttonIndex) {
        NSLog(@"didDismissWithButtonIndex: %d, keyWindow: %p", (int)buttonIndex, KEY_WINDOW);
    };
    
    [actionSheet show];
    
    
    // Append buttons methods
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [actionSheet appendButtonWithTitle:@"WoW" atIndex:7];
        
        NSMutableIndexSet *set = [[NSMutableIndexSet alloc] init];
        [set addIndex:1];
        [set addIndex:2];
        [actionSheet appendButtonsWithTitles:@[@"Hello", @"World"] atIndexes:set];
    });
}

#pragma mark - LCActionSheet Delegate

- (void)actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSUInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex: %d, keyWindow: %p", (int)buttonIndex, KEY_WINDOW);
}

- (void)willPresentActionSheet:(LCActionSheet *)actionSheet {
    NSLog(@"willPresentActionSheet, keyWindow: %p", KEY_WINDOW);
}

- (void)didPresentActionSheet:(LCActionSheet *)actionSheet {
    NSLog(@"didPresentActionSheet, keyWindow: %p", KEY_WINDOW);
}

- (void)actionSheet:(LCActionSheet *)actionSheet willDismissWithButtonIndex:(NSUInteger)buttonIndex {
    NSLog(@"willDismissWithButtonIndex: %d, keyWindow: %p", (int)buttonIndex, KEY_WINDOW);
}

- (void)actionSheet:(LCActionSheet *)actionSheet didDismissWithButtonIndex:(NSUInteger)buttonIndex {
    NSLog(@"didDismissWithButtonIndex: %d, keyWindow: %p", (int)buttonIndex, KEY_WINDOW);
}

@end
