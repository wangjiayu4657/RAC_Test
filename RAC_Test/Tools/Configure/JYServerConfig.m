//
//  JYServerConfig.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/1/10.
//

#import "JYServerConfig.h"
#import "JYConst.h"

//环境参数 00: 测试环境,01: 生产环境
static NSString *JYConfigEnv;

@implementation JYServerConfig

+ (void)setJYConfigEnv:(NSString *)value {
  JYConfigEnv = value;
  
  [JYNetWork configCommonHttpHeaders:[self initHttpHeaderConfig]];
}

+ (NSString *)JYConfigEnv {
  return JYConfigEnv;;
}

+ (NSString *)getJYServerAddr {
  return [JYConfigEnv isEqualToString:@"00"] ? JYURL_Test : JYURL;
}

+ (NSDictionary *)initHttpHeaderConfig {
  NSString *deviceId = [NSUUID UUID].UUIDString;
  NSString *appBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
  
  NSDictionary *headers = @{
    @"Jinmi-DeviceId" : deviceId,
    @"Jinmi-DeviceType" : @"ios",
//    @"Jinmi-Token" : @"",
//    @"Jinmi-SessionId" : @"",
//    @"Jinmi-Time" : @"1491981943",
//    @"Safe" : @"{\"value\":[1],\"expire\":1491986451}",
//    @"Cookie" : cookie,
    @"Jinmi-VersionCode" : appBuild
  };

  NSLog(@"headers == %@",headers);
  return headers;
}


@end
