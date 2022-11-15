//
//  JYBaseCell.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import <UIKit/UIKit.h>
#import "JYReactiveViewDelegate.h"
#import "BuilderSubviewsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYBaseCell : UITableViewCell<JYReactiveViewDelegate,BuilderSubviewsProtocol>

@end

NS_ASSUME_NONNULL_END
