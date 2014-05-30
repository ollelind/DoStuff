//
//  ProfilePictureImageView.m
//  DoStuff
//
//  Created by Olle Lind on 01/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "ProfilePictureImageView.h"
#import "SDWebImageManager.h"


@implementation ProfilePictureImageView{
    UIActivityIndicatorView *activityIndicator;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self pimpImage];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame url:(NSString *)url{
    self = [self initWithFrame:frame];
    [self setImageURL:url];
    return self;
}

-(void)setImageURL:(NSString *)url{
    [self startLoader];
    [self setImage:nil];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:url]
                     options:0
                    progress:nil
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL completed)
     {
         if (image)
         {
             [self stopLoader];
             [self setImage:image];
         }
         else{
             [self setImage:nil];
         }
     }];
}

-(void)startLoader{
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.frame = CGRectMake(self.frame.size.width/2 - activityIndicator.frame.size.width/2, self.frame.size.height/2 - activityIndicator.frame.size.height/2, activityIndicator.frame.size.height, activityIndicator.frame.size.height);
    activityIndicator.tintColor = COLOR_MAIN;
    activityIndicator.color = COLOR_MAIN;
    [activityIndicator startAnimating];
    [self addSubview:activityIndicator];
}
-(void)stopLoader{
    [activityIndicator stopAnimating];
}

-(void)awakeFromNib{
    [self pimpImage];
}

-(void)pimpImage{
    self.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = MAX(self.frame.size.width/2, self.frame.size.height/2);
    self.layer.shadowColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0].CGColor;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
}



@end
