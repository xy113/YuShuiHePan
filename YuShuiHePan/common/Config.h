//
//  Config.h
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#define SWIDTH [UIScreen mainScreen].bounds.size.width
#define SHEIGHT [UIScreen mainScreen].bounds.size.height

#define BGCOLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"white.png"]]
#define BGCOLORGRAY [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray.png"]]
#define NAVBGCOLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink.png"]]
#define TABBGCOLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbg.png"]]
#define DSXCOLORWHITE [UIColor colorWithPatternImage:[UIImage imageNamed:@"white.png"]]
#define DSXCOLORGRAY [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray.png"]]
#define DSXCOLORPINK [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink.png"]]
#define DSXCOLORORANGE [UIColor colorWithPatternImage:[UIImage imageNamed:@"orange.png"]]

#define SITEAPI @"http://yushuihepan.com/?mod=app"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed: ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green: ((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue: ((float)(rgbValue & 0xFF)) / 255.0 alpha: 1.0]

//ShareSDK 接口配置
#define ShareAppName @"掌上黔南"
#define ShareAppKey @"9d158b5a6178"
#define ShareAppSecret @"59e46c696539877c9db235fae1a9253c"