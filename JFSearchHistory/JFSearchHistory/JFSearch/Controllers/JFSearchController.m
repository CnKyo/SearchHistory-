//
//  JFSearchController.m
//  JFSearchHistory
//
//  Created by 张建飞 on 2018/4/12.
//  Copyright © 2018年 JeffinZhang. All rights reserved.
//

#import "JFSearchController.h"
#import "JFSearchCollectionCell.h"
#import "JFSearchHeaderReusableView.h"
#import "JFSearchModel.h"

#define cellHeight 25
#define cellSpace 13
#define headerHeight 40

#define  WIDTH  [UIScreen mainScreen].bounds.size.width
#define  HEIGHT  [UIScreen mainScreen].bounds.size.height

#define HistoryPath @"/searchItemHistory.txt"

@interface JFSearchController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>

@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView  *collectionV;
@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) NSMutableArray *totalArry;
@property (nonatomic,strong) NSMutableArray *historyArry;
@property (nonatomic,strong) NSArray *headerArry;

@end

@implementation JFSearchController

static NSString * const cellIdentifier = @"cellIdentifier";
static NSString * const headerIdentifier = @"headerIdentifier";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self getData];
    [self initNavigationBarSearchBar];
    
    //注册cell
    [self.collectionV registerClass:[JFSearchCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    [self.collectionV registerClass:[JFSearchHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    
    [self.view addSubview:self.collectionV];
}


#pragma mark - navigationBarSetting
- (void)initNavigationBarSearchBar {
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [leftButton setImage:[UIImage imageNamed:@"nav_back"]forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [rightButton setImage:[UIImage imageNamed:@"nav_search"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 100 , 30)];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"Enter keyword";
    //    self.textField.backgroundColor = [UIColor redColor];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.textColor = [UIColor blackColor];
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.delegate = self;
    
    self.textField.layer.borderColor=[UIColor blackColor].CGColor;
    
    
    self.navigationItem.titleView = self.textField;
    self.textField.returnKeyType = UIReturnKeyGo;
    
}

- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)searchClick{
    
    if (self.textField.text.length) {
        
        [self searchWeapons:self.textField.text];
    }else{
        
        NSLog(@"Please Enter keyword");
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self searchWeapons:textField.text];
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - initData
- (void)getData{
    
    //headerData
    NSDictionary *gunDic = @{@"labTitle":@"GUNS",@"btnTitle":@"Reload"};
    NSDictionary *partsDic = @{@"labTitle":@"PARTS",@"btnTitle":@""};
    NSDictionary *HistoryDic = @{@"labTitle":@"HISTORY",@"btnTitle":@"Clear"};
    
    NSArray *headerArry = @[gunDic, partsDic, HistoryDic];
    self.headerArry = headerArry;
    
    //gunsArry
    NSArray *gunsArry = @[@"GROZA", @"SCAR-L", @"M16A4", @"M416", @"AKM", @"VSS", @"MINI14", @"SKS", @"MK14", @"89K", @"M24", @"AWM", @"汤姆逊", @"Vector", @"UMP9", @"UZI", @"S1897", @"S686", @"S12K", @"P18C", @"P1895", @"P1911", @"P92"];
    
    NSArray *partsArry = @[@"红点瞄准镜", @"全息瞄准镜", @"2倍镜", @"4倍镜", @"8倍镜", @"15倍镜", @"步枪补偿器", @"步枪消焰器", @"步枪消音器", @"狙击枪补偿器", @"狙击枪消焰器", @"狙击枪消音器",@"冲锋枪补偿器", @"冲锋枪消焰器", @"冲锋枪消音器"];
    
    NSMutableArray *historyArry = [NSMutableArray array];
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *searchPath = [filePath stringByAppendingPathComponent:HistoryPath];
    NSArray *fileArray = [NSMutableArray arrayWithContentsOfFile:searchPath];
    
//    NSLog(@"path%@",searchPath);
    
    for (NSString *weapon in fileArray) {
        if (nil != weapon) {
            
            [historyArry addObject:weapon];
        }
    }
    
    NSMutableArray *totalArry = [@[gunsArry, partsArry, historyArry] mutableCopy];
    
    self.historyArry = historyArry;
    
    self.totalArry = totalArry;
    
}

#pragma mark - collectionViewMethon
// 设置item大小。
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *AA = self.totalArry[indexPath.section];
    
    return CGSizeMake([self calculateRowWidth:AA[indexPath.item]], cellHeight);
}

// 设置item间距。
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return cellSpace;
}

// 设置行间距。
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return cellSpace;
}

// 设置页边距。
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(cellSpace, cellSpace, cellSpace, cellSpace);
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.totalArry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  [self.totalArry[section] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JFSearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    JFSearchModel *model = [[JFSearchModel alloc]init];
    
    NSArray *AA = self.totalArry[indexPath.section];
    
    model.weapon = AA[indexPath.item];
    
    cell.object = model;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    JFSearchHeaderReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    
    reusableView.object = self.headerArry[indexPath.section];
    
    __weak typeof(self) weakSelf = self;
    
    reusableView.JFSearchHeaderBlock = ^(NSString *title) {
        
        [weakSelf HeaderBtnClick:title];
    };
    
    return reusableView;
}

// 设置header大小(不写,不加载header)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return (CGSize){WIDTH,headerHeight};
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *aa = self.totalArry[indexPath.section];
    NSString *selectedWeapon = aa[indexPath.item];
//    NSLog(@"%@",selectedWeapon);
    
    [self searchWeapons:selectedWeapon];
}


#pragma mark - otherMethod
- (CGFloat)calculateRowWidth:(NSString *)string {
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

- (void)searchWeapons:(NSString *)weapon {
    
    [self.historyArry insertObject:weapon atIndex:0];
    
    //remove identical string
    for (int i = 0; i < self.historyArry.count; i++) {
        
        if ([self.historyArry[i] isEqualToString:weapon]) {
            
            [self.historyArry removeObject:self.historyArry[i]];
            break;
        }
    }
    
    [self.historyArry insertObject:weapon atIndex:0];
    
    [self saveSearchHistory];
    
}


- (void)saveSearchHistory{
    
    NSMutableArray *fileArray = [[NSMutableArray alloc] init];
    
    for (NSString  *d in self.historyArry) {
        [fileArray addObject:d];
    }
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    filePath = [filePath stringByAppendingPathComponent:HistoryPath];
    
    [fileArray writeToFile:filePath atomically:YES];
    [self.collectionV reloadData];
    [self.textField resignFirstResponder];
}


//clickHeaderBtn
- (void)HeaderBtnClick:(NSString *)title{
    
    if ([title isEqualToString:@"Reload"]) {
        
        // get NetRequest  ->  reloadData
        NSLog(@"--reloadData--");
        
    }else if ([title isEqualToString:@"Clear"]){
        
        [self.historyArry removeAllObjects];
        [self saveSearchHistory];
        
        NSLog(@"clearHistory");
    }
    
}

#pragma mark - lazyLoad
- (UICollectionViewFlowLayout *)flowLayout{
    
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    }
    return _flowLayout;
}


- (UICollectionView *)collectionV{
    
    if (!_collectionV) {
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) collectionViewLayout:self.flowLayout];
        _collectionV.backgroundColor = [UIColor whiteColor];
        
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.showsVerticalScrollIndicator = NO;
        _collectionV.scrollEnabled = YES;
    }
    return _collectionV;
}


@end
