//
//  JFSearchHeaderReusableView.h
//  JFSearchHistory
//
//  Created by 张建飞 on 2018/4/12.
//  Copyright © 2018年 JeffinZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFSearchHeaderReusableView : UICollectionReusableView

/**
 *  设置数据属性
 */
@property (nonatomic, strong) id object;

@property (nonatomic,copy)  void (^JFSearchHeaderBlock)(NSString *title);

@end
