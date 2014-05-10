//
//  ProfilePictureImageView.h
//  DoStuff
//
//  Created by Olle Lind on 01/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePictureImageView : UIImageView

-(id)initWithFrame:(CGRect)frame url:(NSString *)url;
-(void)setImageURL:(NSString *)url;

@end
