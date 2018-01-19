//
//  MenuViewCell.m
//  TheWeather
//
//  Created by shenjie on 2018/1/10.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "MenuViewCell.h"
#import "GlobalDefine.h"

@implementation MenuViewCell
@synthesize textLabel1 = _textLabel1;
@synthesize imgView = _imgView;
@synthesize sep = _sep;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        self.textLabel1 = [[UILabel alloc] init];
        [self.textLabel1 setTextColor:[UIColor blackColor]];
        [self.textLabel1 setFont:[UIFont systemFontOfSize:17]];
        [self.contentView addSubview:self.textLabel1];
        
//        self.imgView = [[UIImageView alloc] init];
//        [self.imgView setBackgroundColor:[UIColor clearColor]];
//        [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
//        self.imgView.clipsToBounds = YES;
//        [self.contentView addSubview:self.imgView];
        
//        self.sep = [[UIImageView alloc] init];
//        [self.sep setBackgroundColor:RGB(220, 220, 220)];
//        [self.sep setContentMode:UIViewContentModeBottom];
//        self.sep.clipsToBounds = YES;
//        [self.contentView addSubview:self.sep];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //两边边距 20 个像素
    CGFloat margin = 20.0f;
    
    CGRect rcCell = [self bounds];
    [self.textLabel1 sizeToFit];
    self.textLabel1.numberOfLines = 0;
    CGRect rcName = self.textLabel.frame;
    rcName.origin.x = margin;
    rcName.origin.y = 10;
    rcName.size.height = 30;
    rcName.size.width = rcCell.size.width - 2*margin;
    self.textLabel1.frame = rcName;
    
//    CGRect rcImg= CGRectMake(rcName.size.width + 2*margin, 15 , (rcCell.size.width - 3*margin)/3, 80);
//    self.imgView.frame = rcImg;
    
//    CGRect rcSep = CGRectMake(0, 1 , rcCell.size.width, 1);
//    self.sep.frame = rcSep;
}

@end
