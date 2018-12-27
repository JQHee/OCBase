//
//  CategoryTitleModel.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryTitleModel : NSObject

extern NSString *const TTCategoryTitleModelMe;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, assign) NSInteger default_add;

@property (nonatomic, assign) NSInteger tip_new;

@property (nonatomic, copy) NSString *web_url;

@property (nonatomic, copy) NSString *concern_id;

@property (nonatomic, copy) NSString *icon_url;

@property (nonatomic, assign) NSInteger flags;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *name;

@end

/* WCD的使用
-(void)initDB{
    
    NSString *path = [TTDBPath stringByAppendingPathComponent:NSStringFromClass(self.class)];
    _database = [[WCTDatabase alloc] initWithPath:path];
    BOOL ret = [_database createTableAndIndexesOfName:TTCategoryTitleModelMe withClass:CategoryTitleModel.class];
}


-(void)getCacheData
{
    NSArray<CategoryTitleModel *> *datas=[_database getObjectsOfClass:CategoryTitleModel.class fromTable:TTCategoryTitleModelMe limit:20];
    
}

- (void) insert {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL result=[_database insertOrReplaceObjects:titlesArr into:TTCategoryTitleModelMe];
    });
}
 */
