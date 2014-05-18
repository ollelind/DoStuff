//
//  CustomLabel.h
//  DoStuff
//
//  Created by Olle Lind on 28/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    FontSizeHeader_20 = 20,
    FontSizeText_16 = 16,
    FontSizeSmallText_14 = 14,
    FontSizeSmallText_12 = 12,
    
}FontSize;

@interface CustomLabel : UILabel

+(CustomLabel *)customRegularWithSize:(FontSize)size;
+(CustomLabel *)customMediumWithSize:(FontSize)size;
+(CustomLabel *)customBoldWithSize:(FontSize)size;


@end
