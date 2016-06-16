//
//  UIViewController+addFresh.m
//  MakeMoney
//
//  Created by gitBurning on 15/9/15.
//  Copyright (c) 2015年 王坜. All rights reserved.
//

#import "UIViewController+addFresh.h"
#import <objc/runtime.h>
#import "MJRefresh.h"
static char const * const ObjectTagKey = "tablew";
@implementation UIViewController (addFresh)
-(void)addFreshPull:( id)tablew withBlock:(void (^)(id))pullBlock
{
    
    self.freshTablew=tablew;
    if (pullBlock) {
        
        WS(ws);
        self.freshTablew.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (![ws.freshTablew.mj_footer isRefreshing]) {
                pullBlock(nil);

            }else{
                [ws headerEndFreshPull];
            }
        }];
      
    }
}
-(void)headerEndFreshPull
{
    [OprationTools oprationOnMainBlock:^{
        
        [self.freshTablew.mj_header endRefreshing];
        [self.freshTablew.mj_footer endRefreshing];


    }];
}
-(void)headerBeginFreshPull
{
    [OprationTools oprationOnMainBlock:^{
        
        if (![self.freshTablew.mj_header isRefreshing]) {
            
            [self.freshTablew.mj_header beginRefreshing];
        }
        
    }];
    
}
-(void)removeHeader
{
    [OprationTools oprationOnMainBlock:^{
        
        [self.freshTablew.mj_header removeFromSuperview];

        
    }];
}

-(void)removeFooter
{
    [OprationTools oprationOnMainBlock:^{
        
        [self.freshTablew.mj_footer removeFromSuperview];
    
    }];


}
-(void)footerEndFreshPull{
    
    [OprationTools oprationOnMainBlock:^{
        
            [self.freshTablew.mj_footer endRefreshing];
            [self.freshTablew.mj_header endRefreshing];

        
    }];

}
-(void)footerBeginFreshPull
{
    [OprationTools oprationOnMainBlock:^{
        
        if (![self.freshTablew.mj_footer isRefreshing]) {
           [self.freshTablew.mj_footer beginRefreshing];
        }
        
    }];


}
-(void)addFooterFresh:(id )tablew withBlock:(void (^)(id))pullBlock
{
    self.freshTablew=tablew;
    if (pullBlock) {
        WS(ws);
        self.freshTablew.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            
            if (![ws.freshTablew.mj_header isRefreshing]) {
                pullBlock(nil);
                
            }else{
                [ws footerEndFreshPull];
            }
        }];
    }
}

-(UITableView *)freshTablew
{
    return objc_getAssociatedObject(self, ObjectTagKey);
}

-(void)setFreshTablew:(UITableView *)freshTablew
{
    objc_setAssociatedObject(self, ObjectTagKey, freshTablew, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

@end
