//
//  CommonUtils.m
//  GitHubTips
//
//  Created by Yorke on 15/3/14.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "CommonUtils.h"
#import "KeychainItemWrapper.h"

@interface CommonUtils ()

@property (nonatomic, strong) OCTClient *client;

@end

@implementation CommonUtils

+ (instancetype)sharedInstance{
    static CommonUtils *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

+ (void)signInToServerUsingWebBrowserCompletion:(dispatch_block_t)completion failure:(dispatch_block_t)failure{
    [[OCTClient signInToServerUsingWebBrowser:OCTServer.dotComServer scopes:OCTClientAuthorizationScopesUser] subscribeNext:^(OCTClient *authenticatedClient) {
         [CommonUtils sharedInstance].client = authenticatedClient;
         [CommonUtils saveRawLogin:authenticatedClient.user.rawLogin token:authenticatedClient.token];
        
         [[WTCoreDataStack defaultStack] ensureInitialLoad];
        if(completion){
            completion();
        }
         // Authentication was successful. Do something with the created client.
     } error:^(NSError *error) {
         if(failure){
             failure();
         }
         // Authentication failed.
     }];
}

+ (void)saveRawLogin:(NSString *)rawLogin token:(NSString *)token{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc]initWithIdentifier:@"GitHubTips" accessGroup:nil];
    [keychain setObject:rawLogin forKey:(__bridge id)kSecAttrAccount];
    [keychain setObject:token forKey:(__bridge id)kSecValueData];
}

+ (void)startOCTClientServer{
    [OCTClient setClientID:ClientID clientSecret:ClientSecret];
    if([CommonUtils rawLogin] && ![[CommonUtils rawLogin]isEqualToString:@""]){
        OCTUser *user = [OCTUser userWithRawLogin:[CommonUtils rawLogin] server:[OCTServer dotComServer]];
        [CommonUtils sharedInstance].client = [OCTClient authenticatedClientWithUser:user token:[CommonUtils token]];
        
        [[WTCoreDataStack defaultStack] ensureInitialLoad];
    }
}

+ (OCTClient *)clientWithUser:(OCTUser *)user {
    return [OCTClient unauthenticatedClientWithUser:user];
}

+ (OCTClient *)clientWithLogin:(NSString *)login {
    OCTUser *user = [OCTUser userWithLogin:login];
    return [OCTClient unauthenticatedClientWithUser:user];
}

+ (OCTClient *)client{
    return [CommonUtils sharedInstance].client;
}

+ (NSString *)rawLogin{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc]initWithIdentifier:@"GitHubTips" accessGroup:nil];
    return [keychain objectForKey:(__bridge id)kSecAttrAccount];
}

+ (NSString *)token{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc]initWithIdentifier:@"GitHubTips" accessGroup:nil];
    return [keychain objectForKey:(__bridge id)kSecValueData];
}

@end
