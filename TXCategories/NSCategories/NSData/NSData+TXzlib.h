//
//  NSData+TXzlib.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

@interface NSData (TXzlib)

/**
 ZLib error domain
 */
extern NSString *const TXZlibErrorDomain;
/**
 When a zlib error occurs, querying this key in the @p userInfo dictionary of the
 @p NSError object will return the underlying zlib error code.
 */
extern NSString *const TXZlibErrorInfoKey;

typedef NS_ENUM(NSUInteger, TXZlibErrorCode) {
    TXZlibErrorCodeFileTooLarge = 0,
    TXZlibErrorCodeDeflationError = 1,
    TXZlibErrorCodeInflationError = 2,
    TXZlibErrorCodeCouldNotCreateFileError = 3,
};

/**
 Apply zlib compression.

 @param error If an error occurs during compression, upon return contains an
 NSError object describing the problem.

 @returns An NSData instance containing the result of applying zlib
 compression to this instance.
 */
- (NSData *)tx_dataByDeflatingWithError:(NSError *__autoreleasing *)error;

/**
 Apply zlib decompression.

 @param error If an error occurs during decompression, upon return contains an
 NSError object describing the problem.

 @returns An NSData instance containing the result of applying zlib
 decompression to this instance.
 */
- (NSData *)tx_dataByInflatingWithError:(NSError *__autoreleasing *)error;

/**
 Apply zlib compression and write the result to a file at path

 @param path The path at which the file should be written

 @param error If an error occurs during compression, upon return contains an
 NSError object describing the problem.

 @returns @p YES if the compression succeeded; otherwise, @p NO.
 */
- (BOOL)tx_writeDeflatedToFile:(NSString *)path
                          error:(NSError *__autoreleasing *)error;

/**
 Apply zlib decompression and write the result to a file at path

 @param path The path at which the file should be written

 @param error If an error occurs during decompression, upon return contains an
 NSError object describing the problem.

 @returns @p YES if the compression succeeded; otherwise, @p NO.
 */
- (BOOL)tx_writeInflatedToFile:(NSString *)path
                          error:(NSError *__autoreleasing *)error;
@end
