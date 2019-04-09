//
//  ViewController.m
//  TestCollectionView
//
//  Created by David on 2019/4/9.
//  Copyright © 2019 a. All rights reserved.
//

#import "ViewController.h"
#define     VIEW_WIDTH      [UIScreen mainScreen].bounds.size.width
#define     VIEW_HEIGHT     [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)   UICollectionView *collectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
//// 返回Header的尺寸大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//
//    return CGSizeMake(VIEW_WIDTH, 20);
//}


// 返回cell的尺寸大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(50, 50);      // 让每个cell尺寸都不一样
}


//// 返回Footer的尺寸大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//
//    return CGSizeMake(VIEW_WIDTH, 33);
//}


// 返回cell之间行间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}


// 返回cell之间列间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}


// 设置上左下右边界缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - UICollectionViewDataSource

// 返回Section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}


// 返回cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell (重用)
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    // 设置cell
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor purpleColor];
    }else {
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Cell";
    label.textColor = [UIColor whiteColor];
    [cell addSubview:label];
    
    return cell;
}


//// 返回Header/Footer内容
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {          // Header视图
//        // 从复用队列中获取HooterView
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader" forIndexPath:indexPath];
//        // 设置HooterView
//        headerView.backgroundColor = [UIColor redColor];
//        UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = @"我是Header";
//        label.textColor = [UIColor whiteColor];
//        [headerView addSubview:label];
//        // 返回HooterView
//        return headerView;
//
//    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {    // Footer视图
//        // 从复用队列中获取FooterView
//        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyFooter" forIndexPath:indexPath];
//        // 设置FooterView
//        footerView.backgroundColor = [UIColor blueColor];
//        UILabel *label = [[UILabel alloc] initWithFrame:footerView.bounds];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = @"我是Footer";
//        label.textColor = [UIColor whiteColor];
//        [footerView addSubview:label];
//        // 返回FooterView
//        return footerView;
//    }
//
//    return nil;
//}


#pragma mark - UICollectionViewDelegate
// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选中cell: %ld", indexPath.row);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        // 创建FlowLayout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 垂直方向滑动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 创建collectionView
        CGRect frame = CGRectMake(0, 50, VIEW_WIDTH, 70);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 其他属性
        _collectionView.backgroundColor = [UIColor yellowColor];
        _collectionView.showsVerticalScrollIndicator = NO;          // 隐藏垂直方向滚动条
        // 注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
        //        // 注册Header
        //        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader"];
        //        // 注册Footer
        //        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyFooter"];
    }
    
    return _collectionView;
}
@end
