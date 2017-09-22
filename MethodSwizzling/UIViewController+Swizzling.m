//
//  UIViewController+Swizzling.m
//  MethodSwizzling
//
//  Created by Kadir Kemal Dursun on 22/09/2017.
//  Copyright © 2017 Kadir Kemal Dursun. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h> // It is needed for method swizzling

@implementation UIViewController (Swizzling)

+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        SEL viewDidLoadSelector = @selector(viewDidLoad);
        SEL viewMethodDurationDidLoadSelector = @selector(methodDuration_viewDidLoad);
        Method originalMethod = class_getInstanceMethod(self, viewDidLoadSelector);
        Method customMethod = class_getInstanceMethod(self, viewMethodDurationDidLoadSelector);
        method_exchangeImplementations(originalMethod, customMethod);
    });
}

- (void) methodDuration_viewDidLoad {
    self.view.backgroundColor = [UIColor blueColor];
    NSLog(@"Some logs...");
    [self methodDuration_viewDidLoad];
}


@end
