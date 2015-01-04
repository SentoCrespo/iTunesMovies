/******************************************************************************
 *
 * Categories
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import <Foundation/Foundation.h>

#define WEAKOBJECT(obj) __typeof (&*obj) __weak

#define WEAKSELF(var) WEAKOBJECT(self) var = self

@interface NSObject (WeakSelf)

@end
