//
//  NSURL+Query.m
//  NSURL+Query
//
//  Created by Jon Crooke on 10/12/2013.
//  Copyright (c) 2013 Jonathan Crooke. All rights reserved.
//

#import "NSURL+TXQueryDictionary.h"

static NSString *const tx_URLReservedChars  = @"￼=,!$&'()*+;@?\r\n\"<>#\t :/";
static NSString *const kQuerySeparator      = @"&";
static NSString *const kQueryDivider        = @"=";
static NSString *const kQueryBegin          = @"?";
static NSString *const kFragmentBegin       = @"#";

@implementation NSURL (tx_URLQuery)

- (NSDictionary*) tx_queryDictionary {
  return self.query.tx_URLQueryDictionary;
}

- (NSURL*) tx_URLByAppendingQueryDictionary:(NSDictionary*) queryDictionary {
  return [self tx_URLByAppendingQueryDictionary:queryDictionary withSortedKeys:NO];
}

- (NSURL *)tx_URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary
                          withSortedKeys:(BOOL)sortedKeys
{
  NSMutableArray *queries = [self.query length] > 0 ? @[self.query].mutableCopy : @[].mutableCopy;
  NSString *dictionaryQuery = [queryDictionary tx_URLQueryStringWithSortedKeys:sortedKeys];
  if (dictionaryQuery) {
    [queries addObject:dictionaryQuery];
  }
  NSString *newQuery = [queries componentsJoinedByString:kQuerySeparator];

  if (newQuery.length) {
    NSArray *queryComponents = [self.absoluteString componentsSeparatedByString:kQueryBegin];
    if (queryComponents.count) {
      return [NSURL URLWithString:
              [NSString stringWithFormat:@"%@%@%@%@%@",
               queryComponents[0],                      // existing url
               kQueryBegin,
               newQuery,
               self.fragment.length ? kFragmentBegin : @"",
               self.fragment.length ? self.fragment : @""]];
    }
  }
  return self;
}

- (NSURL*) tx_URLByRemovingQuery {
  NSArray *queryComponents = [self.absoluteString componentsSeparatedByString:kQueryBegin];
  if (queryComponents.count) {
    return [NSURL URLWithString:queryComponents.firstObject];
  }
  return self;
}

- (NSURL *)tx_URLByReplacingQueryWithDictionary:(NSDictionary *)queryDictionary {
  return [self tx_URLByReplacingQueryWithDictionary:queryDictionary withSortedKeys:NO];
}

- (NSURL*) tx_URLByReplacingQueryWithDictionary:(NSDictionary*) queryDictionary
                                 withSortedKeys:(BOOL) sortedKeys
{
  NSURL *stripped = [self tx_URLByRemovingQuery];
  return [stripped tx_URLByAppendingQueryDictionary:queryDictionary withSortedKeys:sortedKeys];
}

@end

#pragma mark -

@implementation NSString (URLQuery)

- (NSDictionary*) tx_URLQueryDictionary {
  NSMutableDictionary *mute = @{}.mutableCopy;
  for (NSString *query in [self componentsSeparatedByString:kQuerySeparator]) {
    NSArray *components = [query componentsSeparatedByString:kQueryDivider];
    if (components.count == 0) {
      continue;
    }
    NSString *key = [components[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    id value = nil;
    if (components.count == 1) {
      // key with no value
      value = [NSNull null];
    }
    if (components.count == 2) {
      value = [components[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      // cover case where there is a separator, but no actual value
      value = [value length] ? value : [NSNull null];
    }
    if (components.count > 2) {
      // invalid - ignore this pair. is this best, though?
      continue;
    }
    mute[key] = value ?: [NSNull null];
  }
  return mute.count ? mute.copy : nil;
}

@end

#pragma mark -

@implementation NSDictionary (URLQuery)

static inline NSString *tx_URLEscape(NSString *string);

- (NSString *)tx_URLQueryString {
  return [self tx_URLQueryStringWithSortedKeys:NO];
}

- (NSString*) tx_URLQueryStringWithSortedKeys:(BOOL)sortedKeys {
  NSMutableString *queryString = @"".mutableCopy;
  NSArray *keys = sortedKeys ? [self.allKeys sortedArrayUsingSelector:@selector(compare:)] : self.allKeys;
  for (NSString *key in keys) {
    id rawValue = self[key];
    NSString *value = nil;
    // beware of empty or null
    if (!(rawValue == [NSNull null] || ![rawValue description].length)) {
      value = tx_URLEscape([self[key] description]);
    }
    [queryString appendFormat:@"%@%@%@%@",
     queryString.length ? kQuerySeparator : @"",    // appending?
     tx_URLEscape(key),
     value ? kQueryDivider : @"",
     value ? value : @""];
  }
  return queryString.length ? queryString.copy : nil;
}

static inline NSString *tx_URLEscape(NSString *string) {
    return ((__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
        NULL,
        (__bridge CFStringRef)string,
        NULL,
        (__bridge CFStringRef)tx_URLReservedChars,
        kCFStringEncodingUTF8));
}

@end
