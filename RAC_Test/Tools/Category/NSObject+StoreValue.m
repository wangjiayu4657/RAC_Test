//
//  NSObject+StoreValue.m
//  StoreValue
//
//  Created by wupeng on 2017/2/24.
//  Copyright © 2017年 wupeng. All rights reserved.
//

#import "NSObject+StoreValue.h"
#import "JYLocalStore.h"

@implementation NSObject (StoreValue)

- (void)serializeValueWithKey:(NSString *)key {
    [[JYLocalStore sharedInstance] serializeValue:self withKey:key];
}

+ (id)deserializeValueWithKey:(NSString *)key {
    return [[JYLocalStore sharedInstance] deserializeValueWithKey:key];
}


@end
