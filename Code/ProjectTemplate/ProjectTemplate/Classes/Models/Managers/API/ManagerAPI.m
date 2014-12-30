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


+ (void) getMovies: (void(^)(NSInteger numberItems)) successBlock
      failureBlock: (void(^)(NSError *error)) failureBlock
   completionBlock: (void(^)(void)) completionBlock
{
    [self getWithRestMethod:@"/es/rss/topmovies/limit=50/genre=4401/xml"
             WithParameters:nil
        withCompletionBlock:^(NSInteger statusCode, id data, NSError *error) {
           

#warning TODO-Parse 
//            NSXMLParser *XMLParser = (NSXMLParser *)data;
//            [XMLParser setShouldProcessNamespaces:YES];
            
// XMLParser.delegate = self;
// [XMLParser parse];
        }];
    
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



+ (AFHTTPRequestOperation *) postWithRestMethod: (NSString *) restMethod
                                 WithParameters: (NSDictionary *) parameters
                            withCompletionBlock: (void(^)(NSInteger statusCode, id data, NSError *error)) completionBlock
{
  
    ManagerAPI *apiManager = [self sharedInstance];
    
    AFHTTPRequestOperation *requestOperation =
    [apiManager.manager POST: restMethod
                  parameters: parameters
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         completionBlock(operation.response.statusCode, responseObject, nil);
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         completionBlock(operation.response.statusCode, nil, error);
                     }];
    return requestOperation;
}


+ (AFHTTPRequestOperation *) putWithRestMethod: (NSString *) restMethod
                                WithParameters: (NSDictionary *) parameters
                           withCompletionBlock: (void(^)(NSInteger statusCode, id data, NSError *error)) completionBlock
{
   
    ManagerAPI *apiManager = [self sharedInstance];
    
    AFHTTPRequestOperation *requestOperation =
    [apiManager.manager PUT: restMethod
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
