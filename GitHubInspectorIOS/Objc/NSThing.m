//
//  NSThing.m
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 1/9/19.
//  Copyright © 2019 Volodya wovan. All rights reserved.
//

#import "NSThing.h"
#import "GitHubInspectorIOS-Swift.h"
#import "ReallyStrangeType.h"

#define let const __auto_type
#define var __auto_type

@implementation NSThing

- (void)someStrangeActivity {
    var dependencies = [AppDependencies shared];
    dependencies.funnyArray = @[ReallyStrangeType.new];
}

@end
