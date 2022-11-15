//
//  JYOptionModel.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/1.
//

#import "JYOptionModel.h"

@implementation JYOptionModel


- (void)setSelected:(BOOL)selected {
  _selected = selected;
  
  self.icon = selected ? BuilderImg(@"apply_add") : BuilderImg(@"apply_del");
}

@end
