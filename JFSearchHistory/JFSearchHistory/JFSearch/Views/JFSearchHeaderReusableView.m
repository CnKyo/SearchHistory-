//
//  JFSearchHeaderReusableView.m
//  JFSearchHistory
//
//  Created by 张建飞 on 2018/4/12.
//  Copyright © 2018年 JeffinZhang. All rights reserved.
//

#import "JFSearchHeaderReusableView.h"

#define  WIDTH  [UIScreen mainScreen].bounds.size.width
#define DefaultColor [UIColor colorWithWhite:0.95 alpha:1.0]

@interface JFSearchHeaderReusableView ()

@property (nonatomic,strong) UILabel *leftLab;
@property (nonatomic,strong) UIButton *rightBtn;

@end

@implementation JFSearchHeaderReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUpViews];
    }
    return self;
}


- (void)setObject:(id)object{
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        _object = object;
        [self setUpData];
        [self setUpLayout];
    }
}

- (void)setUpViews{
    
    self.backgroundColor = DefaultColor;
    
    [self addSubview:self.leftLab];
    [self addSubview:self.rightBtn];
}


- (void)setUpData{
    
    if (self.object) {
        
        NSDictionary *dict = self.object;
        
        self.leftLab.text = [dict objectForKey:@"labTitle"];
        
        if (![[dict objectForKey:@"btnTitle"] length]) {
            
            self.rightBtn.hidden = YES;
        }else{

            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:[dict objectForKey:@"btnTitle"] forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
}


- (void)setUpLayout{
    
    self.leftLab.frame = CGRectMake(20, 0, 80, 40 );
    
    self.leftLab.textAlignment = NSTextAlignmentLeft;
    self.leftLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    
//    self.leftLab.backgroundColor =[UIColor blueColor];
    self.leftLab.layer.cornerRadius = 5;
    self.leftLab.layer.masksToBounds = YES;
    
    self.rightBtn.frame = CGRectMake(WIDTH - 100, 0, 80, 40);
}

- (void)rightBtnClick:(UIButton *)btn{
    
    if (self.JFSearchHeaderBlock) {
        
        self.JFSearchHeaderBlock(btn.titleLabel.text);
    }
    
}


- (UILabel *)leftLab{
    
    if (!_leftLab ) {
        
        _leftLab = [[UILabel alloc] init];
        
    }
    return _leftLab;
}

- (UIButton *)rightBtn{
    
    if (!_rightBtn) {
        
        _rightBtn = [[UIButton alloc]init];
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightBtn;
}

@end
