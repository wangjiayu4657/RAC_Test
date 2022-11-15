//
//  JYLocalStore.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/29.
//

#import "JYLocalStore.h"
#import "FastCoder.h"

static JYLocalStore *localStore = nil;
static NSString *const LocalStoreString = @"JYLocalStore";


@implementation JYLocalStore

+ (JYLocalStore *)sharedInstance {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        localStore = (JYLocalStore *)LocalStoreString;
        localStore = [[JYLocalStore alloc] init];
    });
  
    //防止子类使用
    if (![NSStringFromClass([self class]) isEqualToString:LocalStoreString]) {
        NSParameterAssert(nil);
    }

    return localStore;
}

- (void)serializeValue:(id)value withKey:(NSString *)key {
    NSParameterAssert(value);
    NSParameterAssert(key);
    //fastCoding是用来地点系统的NSCoding的协议 可以将对象序列化成NSData，也可以反序列化
    NSData *data = [FastCoder dataWithRootObject:value];
    if (data) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    }
}

- (id)deserializeValueWithKey:(NSString *)key {
    NSParameterAssert(key);
    
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return [FastCoder objectWithData:data];
}


#pragma mark - private

- (instancetype)init {
    NSString *string = (NSString *)localStore;
    if ([string isKindOfClass:[NSString class]] == YES && [string isEqualToString:LocalStoreString]) {
        self = [super init];
        if (self) {
            // 防止子类使用
            NSString *classString = NSStringFromClass([self class]);
            if (![classString isEqualToString:LocalStoreString]) {
                NSParameterAssert(nil);
            }
        }
        return self;
    } else {
        return nil;
    }
}

@end
