/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/


#import "ManagerAPI.h"


#define API_BASE_URL @"https://itunes.apple.com"

// API Methods

@interface ManagerAPI()

@end

#pragma mark - Init


@implementation ManagerAPI


+ (ManagerAPI *) sharedInstance
{
    static dispatch_once_t pred;
    static ManagerAPI *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[ManagerAPI alloc] init];
        [shared initialize];
    });
    
    return shared;
}




- (void) initialize
{
    _manager = [[AFHTTPRequestOperationManager alloc]
                initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];

    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyNever];
    [ManagerAPI clearCookies];
    
    
    // Configure reachability to base URL
    NSOperationQueue *operationQueue = _manager.operationQueue;
    [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    // Configure for XML response
    [_manager setResponseSerializer:[AFXMLParserResponseSerializer serializer]];
    NSSet *contentTypes = [NSSet setWithObject:@"application/atom+xml"];
    _manager.responseSerializer.acceptableContentTypes = contentTypes;
    
    // Configure for HTTP requests
    [_manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    
}




#pragma mark - API Methods -


+ (void) getMoviesXML: (void(^)(id data)) successBlock
         failureBlock: (void(^)(NSError *error)) failureBlock
{
    
    NSString *languageISO =[[NSLocale preferredLanguages] objectAtIndex:0];
    if (![languageISO isEqualToString:@"en"] &&
        ![languageISO isEqualToString:@"es"]) {
        languageISO = @"en";
    } 
    NSString *urlWithLanguage = [NSString stringWithFormat:@"/%@/%@",
                                 languageISO,
                                 @"rss/topmovies/limit=50/genre=4401/xml"];
    
    [self getWithRestMethod:urlWithLanguage
             WithParameters:nil
        withCompletionBlock:^(NSInteger statusCode, id data, NSError *error) {
            
            if (error || statusCode!=200 || !data) {
                failureBlock? failureBlock(error) : nil;
                return;
            }
            
            successBlock? successBlock(data) : nil;
            return;
        }];
    
}



#pragma mark - RAW Data Download
    
+ (void) downloadDataFromURL: (NSString *) urlString
                successBlock: (void (^)(id data)) successBlock
                failureBlock: (void (^)(NSError *error)) failureBlock
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        failureBlock? failureBlock([NSError errorWithDomain:@"Invalid url"
                                                       code:404
                                                   userInfo:nil]) : nil;
        return;
    }
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // Check for error
        if (error != nil) {
            failureBlock? failureBlock(error) : nil;
            return;
        }
        
        // Check for status different than 200
        
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode != 200) {
            failureBlock? failureBlock([NSError errorWithDomain:@"Not 200 OK"
                                                           code:statusCode
                                                       userInfo:nil]) : nil;
            return;
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            successBlock? successBlock(data) : nil;
            return;
        }];
        
        
    }];
    [task resume];
}



#pragma mark - General operations

+ (void) clearCookies
{
    NSArray *cookieArr = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookieArr) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}


+ (void) cancelAllOperations
{
    ManagerAPI *apiManager = [self sharedInstance];
    [apiManager.manager.operationQueue cancelAllOperations];
}



#pragma mark - Wrapper for requests -

+ (AFHTTPRequestOperation *) getWithRestMethod: (NSString *) restMethod
                                WithParameters: (NSDictionary *) parameters
                           withCompletionBlock: (void(^)(NSInteger statusCode, id data, NSError *error)) completionBlock
{
    
    ManagerAPI *apiManager = [self sharedInstance];
    AFHTTPRequestOperation *requestOperation =
    [apiManager.manager GET: restMethod
                 parameters: parameters
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        completionBlock(operation.response.statusCode, responseObject, nil);
                        
                    }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        completionBlock(operation.response.statusCode, nil, error);
                    }];
    return requestOperation;
}






@end
