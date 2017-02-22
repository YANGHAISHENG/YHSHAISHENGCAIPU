//
//  NSURL+Query.m
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 4/19/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import "NSURL+Query.h"
#import "NSArray+Query.h"
#import "NSArray+SafeAccess.h"

@implementation NSURL (Query)

- (BOOL)hasScheme
{
    return ([self scheme]) ? YES : NO;
}

- (NSString *)noun
{
    for (NSString *pair in [self pairs]) {
        NSArray *elements = [pair componentsSeparatedByString:@"/"];
        return [elements objectWithIndex:0];
    }
    return nil;
}

- (NSString *)verb
{
    for (NSString *pair in [self pairs]) {
        NSArray *elements = [pair componentsSeparatedByString:@"/"];
        return [elements objectWithIndex:1];
    }
    return nil;
}

- (NSArray *)pairs
{
    NSString *body = [[self absoluteString] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@://",[self scheme]] withString:@""];
    return [body componentsSeparatedByString:@"?"];
}

- (NSDictionary *)parametersString
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *pairs = [[self query] componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectWithIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectWithIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [dict setObject:val forKey:key];
    }
    return dict;
#pragma clang diagnostic pop
}

@end



