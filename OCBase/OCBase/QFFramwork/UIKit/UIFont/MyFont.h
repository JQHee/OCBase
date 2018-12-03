//
//  MyFont.h
//  OCBase
//
//  Created by midland on 2018/12/3.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SizeScale (UIScreen.mainScreen.bounds.size.width != 414 ? 1 : 1.2)
#define kFont(value) [UIFont systemFontOfSize:value * SizeScale]


/**
 *  button
 */
@interface UIButton (MyFont)

@end


/**
 *  Label
 */
@interface UILabel (myFont)

@end

/**
 *  TextField
 */

@interface UITextField (myFont)

@end

/**
 *  TextView
 */
@interface UITextView (myFont)

@end

