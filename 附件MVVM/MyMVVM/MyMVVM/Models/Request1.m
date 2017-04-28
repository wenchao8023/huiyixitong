//
//  Request1.m
//  MyMVVM
//
//  Created by chao on 2017/4/27.
//  Copyright © 2017年 ibuildtek. All rights reserved.
//

#import "Request1.h"

@implementation Request1

- (void)smk_requestConfigures {
    
    self.smk_scheme = @"https";
    self.smk_host   = @"api.douban.com";
    self.smk_path   = @"/v2/book/search";
    self.smk_method = SMKRequestMethodGET;
}

- (id)smk_requestParameters {
    return @{@"q" : @"基础"};
}

@end
