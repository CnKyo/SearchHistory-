//
//  JFSearchCollectionCell.m
//  JFSearchHistory
//
//  Created by 张建飞 on 2018/4/12.
//  Copyright © 2018年 JeffinZhang. All rights reserved.
//

#import "JFSearchCollectionCell.h"
#import "JFSearchModel.h"

#define cellHeight 25

@interface JFSearchCollectionCell ()

@property (strong, nonatomic) UILabel *label;

@end

@implementation JFSearchCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUpViews];
    }
    return self;
}


- (void)setObject:(id)object{
    
    if ([object isKindOfClass:[JFSearchModel class]]) {
        _object = object;
        [self setUpData];
        [self setUpLayout];
    }
}


- (void)setUpData{
    
    if (self.object) {
        
        JFSearchModel *model = self.object;
        
        self.label.text = model.weapon;
    }
}

- (void)setUpViews{
    
    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
    //    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.label];
}


- (void)setUpLayout{
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
    CGRect rect = [self.label.text boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    self.label.frame = CGRectMake(0, 0, rect.size.width, cellHeight );
    
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];

    self.label.backgroundColor =[UIColor redColor];
    self.label.layer.cornerRadius = 5;
    self.label.layer.masksToBounds = YES;
}


- (UILabel *)label{
    
    if (!_label ) {
        
        _label = [[UILabel alloc] init];
    }
    return _label;
}

@end
