//
//  HWHTTPRequestOperationManager.m
//  Haowu_3.0
//
//  Created by PengHuang on 13-12-2.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import "HWHTTPRequestOperationManager.h"
#import "AppDelegate.h"

@implementation HWHTTPRequestOperationManager

+ (instancetype)manager
{
    return [[HWHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kUrlBase]];
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self)
    {
        
    }
    
    return self;
}

+ (NSString *)encryptParameter:(NSMutableDictionary *)parDict
{
    //    NSString *timestamp = [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970] * 1000];
    //    [parDict setPObject:timestamp forKey:@"timestamp"];
    //    [parDict removeObjectForKey:@"digest"];
    
    NSMutableString *sign = [NSMutableString string];
    NSArray* arr = [parDict allKeys];
    NSMutableSet *mutArr = [NSMutableSet set];
    for (int i = 0; i < arr.count; i++) {
        NSString *key = [arr objectAtIndex:i];
        NSString *value = [parDict stringObjectForKey:key];
        
        // 去掉空格
//        NSString *operateStr = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //        if (operateStr.length == 0)
        //        {
        ////            [parDict removeObjectForKey:key];
        //            continue;
        //        }
        
        [mutArr addObject:key];
        [mutArr addObject:value];
    }
    //    [mutArr sortedArrayUsingDescriptors:nil];
    
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
    NSArray *sortArr = [mutArr sortedArrayUsingDescriptors:sortDesc];
    
    
    for (int i = 0 ; i < sortArr.count ; i++)
    {
        [sign appendFormat:@"%@", [sortArr objectAtIndex:i]];
    }
    [sign appendString:@"999a7a5593324cdb889d9d679d1c5745"];
    
    
    NSString *str = [sign md5:(NSString *)sign];
    NSData *data = [[str uppercaseString] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *codestr = [MF_Base64Codec base64StringFromData:data];
    
    return codestr;
}


- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSString *code, NSString *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析返回数据
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    //  未登录
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict stringObjectForKey:@"status"], [dict stringObjectForKey:@"detail"]);
                    }
                    else
                    {
                        failure([dict stringObjectForKey:@"status"], kNetworkFailedMessage);
                    }
                }
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure([NSString stringWithFormat:@"%d", kStatusNetworkFailed], kNetworkFailedMessage);
    }];
    
    [self.operationQueue addOperation:operation];
        
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}
- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           queue:(NSOperationQueue *)queue
                         success:(void (^)(id responese))success
                         failure:(void (^)(NSString *code, NSString *error))failure
{
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]parameters:parDict error:nil];
    [request setTimeoutInterval:15.0f];
    NSLog(@"request:%@ \n %@",request,parDict);
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        //解析返回数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([[dict objectForKey:@"status"] intValue]==kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    //  未登录
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict stringObjectForKey:@"status"], [dict stringObjectForKey:@"detail"]);
                    }
                    else
                    {
                        failure([dict stringObjectForKey:@"status"], kNetworkFailedMessage);
                    }
                }
                
                
            }
            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure([NSString stringWithFormat:@"%d", kStatusNetworkFailed], kNetworkFailedMessage);
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    return operation;
}

- (AFHTTPRequestOperation *)POSTImage:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                                queue:(NSOperationQueue *)queue
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSString *error))failure {
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
//    URLString = [NSString stringWithFormat:@"%@?&key=%@",URLString, [HWUserLogin currentUserLogin].key];
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *dictKey in [parameters allKeys])
        {
            if ([dictKey isEqualToString:@"pubFile"] || [dictKey isEqualToString:@"file"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSData *imageData = [parameters objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
            }
        }
    } error:nil];
    
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析返回数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    //  未登录
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict objectForKey:@"detail"]);
                    }
                    else
                    {
                        failure(kNetworkFailedMessage);
                    }
                }
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(kNetworkFailedMessage);
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    
    return operation;
}


@end
