//
//  GreetingsView.h
//  DoStuff
//
//  Created by Olle Lind on 28/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@protocol GreetingsViewDelegate <NSObject>
-(void)showNextView;
@end

@interface GreetingsView : UIView <FBLoginViewDelegate>
@property (nonatomic, weak) id<GreetingsViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

- (IBAction)facebookButtonPressed:(id)sender;
@end
