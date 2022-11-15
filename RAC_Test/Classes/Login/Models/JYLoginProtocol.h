//
//  JYLoginProtocol.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/1/11.
//

#import <Foundation/Foundation.h>

@protocol JYLoginProtocol <NSObject>

@optional

- (RACSignal *)loginRequestSignal:(NSDictionary *)param;

@end
