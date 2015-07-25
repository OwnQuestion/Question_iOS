//
//  HWPatchWidget.m
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/5/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWPatchWidget.h"
#import "lauxlib.h"
#import "wax.h"
#import "ZipArchive.h"

#define WAX_PATCH_URL @"http://127.0.0.1/patch/patch.zip"

@implementation HWPatchWidget

+ (void)loadPatch
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[HWPatchWidget loadPatchDir]];
    
    if (array.count != 0)
    {
        NSString *name = @"patch";
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *dir = [doc stringByAppendingPathComponent:@"lua"];
        
        NSString *pp = [[NSString alloc ] initWithFormat:@"%@/%@/?.lua;%@/%@/?/init.lua;", dir, name, dir, name];
        setenv(LUA_PATH, [pp UTF8String], 1);
        
        wax_start((char *)[name cStringUsingEncoding:NSUTF8StringEncoding], nil);
    }
}

+ (NSMutableArray *)loadPatchDir
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *array = [userdefault objectForKey:@"patch"];
    if (array == nil)
    {
        array = [NSMutableArray array];
        [userdefault setValue:array forKey:@"patch"];
    }
    return array;
}

+ (void)savePatchDir:(NSString *)dir
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[HWPatchWidget loadPatchDir]];
    [array addObject:dir];
    
    [userdefault setValue:array forKey:@"patch"];
}

+ (void)downloadPatch
{
    NSURL *patchUrl = [NSURL URLWithString:WAX_PATCH_URL];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:patchUrl] returningResponse:NULL error:NULL];
    
    if(data)
    {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *zipName = [[WAX_PATCH_URL componentsSeparatedByString:@"/"] lastObject];
        
        NSString *patchZip = [doc stringByAppendingPathComponent:zipName];
        [data writeToFile:patchZip atomically:YES];
        
        [self savePatchDir:zipName];
        
        NSString *dir = [doc stringByAppendingPathComponent:@"lua"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dir])
        {
            [[NSFileManager defaultManager] removeItemAtPath:dir error:NULL];
            [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        
        ZipArchive *zip = [[ZipArchive alloc] init];
        [zip UnzipOpenFile:patchZip];
        [zip UnzipFileTo:dir overWrite:YES];
        
        NSString *name = @"patch";
        
        NSString *pp = [[NSString alloc ] initWithFormat:@"%@/%@/?.lua;%@/%@/?/init.lua;", dir, name, dir, name];
        setenv(LUA_PATH, [pp UTF8String], 1);
        
        wax_end();
        wax_start((char *)[name cStringUsingEncoding:NSUTF8StringEncoding], nil);
        
    }
}

@end
