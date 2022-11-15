//
//  MessageProtocol.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//
				 
#import <Foundation/Foundation.h>

@protocol BookProtocol <NSObject>

- (RACSignal *)requestDomainDataSignalWithParam:(NSDictionary *)paran;

@end
