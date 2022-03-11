//
//  sceenpassex.mm
//  sceenpassex
//
//  Created by zzzyuanhu on 2021/10/1.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"
#include <notify.h> // not required; for examples only

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()


@interface sceenpassex : NSObject

@end

@implementation sceenpassex

-(id)init
{
	if ((self = [super init]))
	{
	}

    return self;
}

@end

CHDeclareClass(UITextInputTraits);

CHMethod(0, id, UITextInputTraits, isSecureTextEntry) {
    
    NSLog(@"PreferencesAppController");
    
    return false;
}

CHConstructor // code block that runs immediately upon load
{
	@autoreleasepool
	{
        CHLoadLateClass(UITextInputTraits);
        CHClassHook0(UITextInputTraits, isSecureTextEntry);
	}
}
