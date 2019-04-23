//
//  THUrl.m
//  ThinkHome
//
//  Created by ThinkHome on 2018/12/20.
//  Copyright © 2018 ThinkHome. All rights reserved.
//

#import "THUrl.h"
#import "MyMD5.h"
#import "AFHTTPSessionManager.h"
#import "MacroHeader.h"
@interface THUrl()

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@end

@implementation THUrl

+(instancetype)sharedInstance{
    static THUrl *url=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        url = [[THUrl alloc]init];
    });
    return url;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:REQUEST_POST_URL]];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.requestSerializer.timeoutInterval = 15;
    }
    return self;
}

+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    NSURL *url = [NSURL URLWithString:baseURL];
    if (isconfiguration) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

-(void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail{
//    [self.manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self responseConfiguration:responseObject]];
//        success(dict);
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        fail(error);
//    }];
}

-(void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail{
    NSDictionary *urlDict = @{
                              @"id":@"8888",
                              @"body": params,
                              @"system":[self urlSystemDictGet:params]
                              };
    [self.manager POST:url parameters:urlDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *returnDict =  [NSMutableDictionary dictionaryWithDictionary:[self responseConfiguration:responseObject]];
        success(returnDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error != nil && error.code != -999)
            fail(error);
//        if([error.localizedDescription isEqualToString:@"canceled"] || [error.localizedDescription isEqualToString:@"已取消"]){
//            [AppBaseData sharedInstance].isEnterFore = NO;
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateEnd" object:nil];
//        }
    }];
}

-(void)cancelUrlRequest{
    for(NSURLSessionDataTask *dataTasks in self.manager.dataTasks){
            [dataTasks cancel];
    }
}

-(id)responseConfiguration:(id)responseObject{
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

-(NSString *)bodyDictToStr:(NSDictionary *)bodyDict{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyDict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *dicString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    dicString = [dicString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    dicString = [dicString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    dicString = [dicString stringByReplacingOccurrencesOfString:@"\b" withString:@""];
    dicString = [dicString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    dicString = [dicString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    dicString = [dicString stringByReplacingOccurrencesOfString:@" " withString:@""];
    dicString = [dicString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return dicString;
}

-(NSDictionary *)urlSystemDictGet:(NSDictionary *)bodyDict{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%d",(int)time];
    
    NSString *dicString = [self bodyDictToStr:bodyDict];
    NSString *signStr = [MyMD5 md5:[NSString stringWithFormat:@"%@%@%@",dicString,TH_SECRET_KEY,timeStr]];
    
    NSDictionary *dict = @{
                           @"ver":@"1.0.0",
                           @"sign":signStr,
                           @"appKey":TH_APP_KEY,
                           @"time":timeStr,
                           @"clientSys":[NSString stringWithFormat:@"iOS-%@",[[UIDevice currentDevice] systemVersion]],
                           @"appVer":LOCATION_VERSION,
//                           @"clientModel":[THLibStaticDB iphoneType],
                           @"clientID":@"ThinkHome_Client_iOS"
                           };
    return dict;
}

@end
