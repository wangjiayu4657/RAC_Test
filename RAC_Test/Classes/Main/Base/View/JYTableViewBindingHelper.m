//
//  JYTableViewBindingHelper.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/30.
//

#import "JYTableViewBindingHelper.h"
#import "JYReactiveViewDelegate.h"

@interface JYTableViewBindingHelper()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSArray *sources;
/** 选中时的命令 */
@property (nonatomic,strong) RACCommand *didSelectedCommand;
/** cell重用标识 */
@property (nonatomic,strong) NSString *cellIdentifier;
/** 视图模型 */
@property (nonatomic,strong) id viewModel;

@end


@implementation JYTableViewBindingHelper

#pragma mark - init

- (instancetype)initWithTable:(UITableView *)tableView sourceSignal:(RACSignal *)source selectedCommand:(RACCommand *)didSelectedCommand cellParam:(NSDictionary *)cellParam withViewModel:(id)viewModel {
  if (self = [super init]) {
    _tableView = tableView;
    _sources = [NSArray array];
    _didSelectedCommand = didSelectedCommand;
    _viewModel = viewModel;
  }
  
  @weakify(self)
  [source subscribeNext:^(id  _Nullable x) {
    @strongify(self)
    self.sources = x;
    [self.tableView reloadData];
  }];
  
  _tableView.delegate = self;
  _tableView.dataSource = self;
  
  NSString *cellType = cellParam[@"cellType"];
  _cellIdentifier = cellParam[@"cellName"];
  
  if ([cellType isEqualToString:@"codeType"]) {
    Class cell = NSClassFromString(_cellIdentifier);
    [_tableView registerClass:cell forCellReuseIdentifier:_cellIdentifier];
  } else {
    UINib *templateCellNib = [UINib nibWithNibName:_cellIdentifier bundle:nil];
    [_tableView registerNib:templateCellNib forCellReuseIdentifier:_cellIdentifier];
  }
  
  return self;
}

- (void)setReloadSignal:(RACSignal *)reloadSignal {
  _reloadSignal = reloadSignal;
  
  @weakify(self)
  [reloadSignal subscribeNext:^(id _Nullable x) {
    @strongify(self)
      [self.tableView reloadData];
  }];
}


+ (instancetype)bindingHelperForTableView:(UITableView *)tableView sourceSignale:(RACSignal *)source selectionCommand:(RACCommand *_Nullable)didSelectCommand templateCell:(NSString *)templateCell withViewModel:(id _Nullable)viewModel {
  NSDictionary *cellParam = @{@"cellType":@"codeType",@"cellName":templateCell};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                            sourceSignal:source
                                         selectedCommand:didSelectCommand
                                               cellParam:cellParam
                                           withViewModel:viewModel];
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView sourceSignale:(RACSignal *)source selectionCommand:(RACCommand *_Nullable)didSelectCommand templateCellWithNib:(NSString *)templateCell withViewModel:(id _Nullable)viewModel {
  NSDictionary *cellParam = @{@"cellType":@"nibType",@"cellName":templateCell};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                            sourceSignal:source
                                         selectedCommand:didSelectCommand
                                               cellParam:cellParam
                                           withViewModel:viewModel];
}


#pragma mark - UITableViewDataSource && UITableViewDelegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  id<JYReactiveViewDelegate> cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
  
  id model = self.sources[indexPath.row];
  [self handlerDelegate:cell sendModel:model indexPath:indexPath];
  
  return (UITableViewCell *)cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _sources.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  [self.didSelectedCommand execute:self.sources[indexPath.row]];
  
  if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
  }
}

#pragma mark - UITableViewDelegate forwarding

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
    [self.delegate scrollViewDidScroll:scrollView];
  }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
  if ([self.delegate respondsToSelector:aSelector]) {
    return YES;
  }
  return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
  if ([self.delegate respondsToSelector:aSelector]) {
    return self.delegate;
  }
  return [super forwardingTargetForSelector:aSelector];
}

- (void)handlerDelegate:(id<JYReactiveViewDelegate>)delegate sendModel:(id)model indexPath:(NSIndexPath *)indexPath {
  NSDictionary *param = @{ModelOfIndexPath:indexPath};
  
  if ([delegate respondsToSelector:@selector(bindModel:)]) {
    [delegate bindModel:model];
  }
  
  if ([delegate respondsToSelector:@selector(bindModel:withParam:)]) {
    [delegate bindModel:model withParam:param];
  }
  
  if ([delegate respondsToSelector:@selector(bindViewModel:model:withParam:)]) {
    [delegate bindViewModel:self.viewModel model:model withParam:param];
  }
}

@end
