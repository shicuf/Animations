//
//  TableViewTapAnimationController.m
//  Animations
//
//  Created by YouXianMing on 15/11/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "TableViewTapAnimationController.h"
#import "TableViewTapAnimationCell.h"
#import "UITableView+CellClass.h"
#import "UIView+SetRect.h"
#import "TapAnimationModel.h"

@interface TableViewTapAnimationController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *dataArray;

@end

@implementation TableViewTapAnimationController

- (void)setup {
    
    [super setup];
    
    // Init dataArray.
    self.dataArray = [NSMutableArray array];
    NSArray *array = @[[TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                       [TapAnimationModel modelWithName:@"Animations" selected:NO]];
    
    for (int i = 0; i < array.count; i++) {
        
        [self.dataArray addObject:[TableViewTapAnimationCell dataAdapterWithCellReuseIdentifier:nil data:array[i] cellHeight:80 type:0]];
    }
    
    // Init TableView.
    self.tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds
                                                                 style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerCellsClass:@[cellClass(@"TableViewTapAnimationCell", nil)]];
    [self.contentView addSubview:self.tableView];
}

#pragma mark - UITableView's delegate.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewTapAnimationCell *cell = (TableViewTapAnimationCell *)[tableView dequeueAndLoadContentReusableCellFromAdapter:_dataArray[indexPath.row]
                                                                                                                 indexPath:indexPath];
    [cell changeStateAnimated:NO];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewTapAnimationCell *cell = (TableViewTapAnimationCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell showSelectedAnimation];
    [cell changeStateAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *dataAdapter = _dataArray[indexPath.row];
    
    return dataAdapter.cellHeight;
}

@end
