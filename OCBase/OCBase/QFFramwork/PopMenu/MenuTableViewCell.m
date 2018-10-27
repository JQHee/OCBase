//
//  MenuTableViewCell.m
//  PopMenuTableView
//
//  Created by hjq on 16/8/2.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell {
    UIView *_lineView;
    UIImageView *_iconImageView;
    UILabel *_titleTextLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    _lineView = lineView;
    [self addSubview:lineView];
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [UIFont systemFontOfSize:12];
    self.textLabel.textColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    _iconImageView  = iconImageView;
    [self addSubview:iconImageView];
    
    UILabel *titleTextLb = [[UILabel alloc]init];
    _titleTextLabel = titleTextLb;
    titleTextLb.textColor = [UIColor whiteColor];
    titleTextLb.font = [UIFont systemFontOfSize:15];
    [self addSubview:titleTextLb];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.height.width.mas_equalTo(30);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [_titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(5);
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(18);
    }];
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _lineView.frame = CGRectMake(4, self.bounds.size.height - 1, self.bounds.size.width - 8, 0.5);
}

- (void)setMenuModel:(MenuModel *)menuModel{
    _menuModel = menuModel;
//    self.imageView.image = [UIImage imageNamed:menuModel.imageName];
//    self.textLabel.text = menuModel.itemName;
    _iconImageView.image = [UIImage imageNamed:menuModel.imageName];
    _titleTextLabel.text = menuModel.itemName;
}

@end
