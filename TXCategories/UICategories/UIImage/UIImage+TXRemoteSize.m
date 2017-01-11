//
//  UIImage+RemoteSize.m
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 15/1/27.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIImage+TXRemoteSize.h"

#import <objc/runtime.h>

static char *kSizeRequestDataKey = "NSURL.sizeRequestData";
static char *kSizeRequestTypeKey = "NSURL.sizeRequestType";
static char *kSizeRequestCompletionKey = "NSURL.sizeRequestCompletion";

typedef uint32_t dword;

@interface NSURL (TXRemoteSize)
@property (nonatomic, strong) NSMutableData *tx_sizeRequestData;
@property (nonatomic, strong) NSString *tx_sizeRequestType;
@property (nonatomic, copy) TXUIImageSizeRequestCompleted tx_sizeRequestCompletion;
@end

@implementation NSURL (RemoteSize)

- (void)setTx_sizeRequestCompletion: (TXUIImageSizeRequestCompleted) block {
    objc_setAssociatedObject(self, &kSizeRequestCompletionKey, block, OBJC_ASSOCIATION_COPY);
}

- (TXUIImageSizeRequestCompleted)tx_sizeRequestCompletion {
    return objc_getAssociatedObject(self, &kSizeRequestCompletionKey);
}

- (void)setTx_sizeRequestData:(NSMutableData *)sizeRequestData {
    objc_setAssociatedObject(self, &kSizeRequestDataKey, sizeRequestData, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableData*)tx_sizeRequestData {
    return objc_getAssociatedObject(self, &kSizeRequestDataKey);
}

- (void)setTx_sizeRequestType:(NSString *)sizeRequestType {
    objc_setAssociatedObject(self, &kSizeRequestTypeKey, sizeRequestType, OBJC_ASSOCIATION_RETAIN);
}

- (NSString*)tx_sizeRequestType {
    return objc_getAssociatedObject(self, &kSizeRequestTypeKey);
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
    [self.tx_sizeRequestData setLength: 0];    //Redirected => reset data
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data {
    NSMutableData* receivedData = self.tx_sizeRequestData;
    
    if( !receivedData ) {
        receivedData = [NSMutableData data];
        self.tx_sizeRequestData = receivedData;
    }
    
    [receivedData appendData: data];
    
    //Parse metadata
    const unsigned char* cString = [receivedData bytes];
    const NSInteger length = [receivedData length];
    
    const char pngSignature[8] = {137, 80, 78, 71, 13, 10, 26, 10};
    const char bmpSignature[2] = {66, 77};
    const char gifSignature[2] = {71, 73};
    const char jpgSignature[2] = {255, 216};
    
    if(!self.tx_sizeRequestType ) {
        if( memcmp(pngSignature, cString, 8) == 0 ) {
            self.tx_sizeRequestType = @"PNG";
        }
        else if( memcmp(bmpSignature, cString, 2) == 0 ) {
            self.tx_sizeRequestType = @"BMP";
        }
        else if( memcmp(jpgSignature, cString, 2) == 0 ) {
            self.tx_sizeRequestType = @"JPG";
        }
        else if( memcmp(gifSignature, cString, 2) == 0 ) {
            self.tx_sizeRequestType = @"GIF";
        }
    }
    
    if( [self.tx_sizeRequestType isEqualToString: @"PNG"] ) {
        char type[5];
        int offset = 8;
        
        dword chunkSize = 0;
        int chunkSizeSize = sizeof(chunkSize);
        
        if( offset+chunkSizeSize > length )
            return;
        
        memcpy(&chunkSize, cString+offset, chunkSizeSize);
        chunkSize = OSSwapInt32(chunkSize);
        offset += chunkSizeSize;
        
        if( offset + chunkSize > length )
            return;
        
        memcpy(&type, cString+offset, 4); type[4]='\0';
        offset += 4;
        
        if( strcmp(type, "IHDR") == 0 ) {   //Should always be first
            dword width = 0, height = 0;
            memcpy(&width, cString+offset, 4);
            offset += 4;
            width = OSSwapInt32(width);
            
            memcpy(&height, cString+offset, 4);
            offset += 4;
            height = OSSwapInt32(height);
            
            if( self.tx_sizeRequestCompletion ) {
                self.tx_sizeRequestCompletion(self, CGSizeMake(width, height));
            }
            
            self.tx_sizeRequestCompletion = nil;
            
            [connection cancel];
        }
    }
    else if( [self.tx_sizeRequestType isEqualToString: @"BMP"] ) {
        int offset = 18;
        dword width = 0, height = 0;
        memcpy(&width, cString+offset, 4);
        offset += 4;
        
        memcpy(&height, cString+offset, 4);
        offset += 4;
        
        if( self.tx_sizeRequestCompletion ) {
            self.tx_sizeRequestCompletion(self, CGSizeMake(width, height));
        }
        
        self.tx_sizeRequestCompletion = nil;
        
        [connection cancel];
    }
    else if( [self.tx_sizeRequestType isEqualToString: @"JPG"] ) {
        int offset = 4;
        dword block_length = cString[offset]*256 + cString[offset+1];
        
        while (offset<length) {
            offset += block_length;
            
            if( offset >= length )
                break;
            if( cString[offset] != 0xFF )
                break;
            if( cString[offset+1] == 0xC0 ||
               cString[offset+1] == 0xC1 ||
               cString[offset+1] == 0xC2 ||
               cString[offset+1] == 0xC3 ||
               cString[offset+1] == 0xC5 ||
               cString[offset+1] == 0xC6 ||
               cString[offset+1] == 0xC7 ||
               cString[offset+1] == 0xC9 ||
               cString[offset+1] == 0xCA ||
               cString[offset+1] == 0xCB ||
               cString[offset+1] == 0xCD ||
               cString[offset+1] == 0xCE ||
               cString[offset+1] == 0xCF ) {
                
                dword width = 0, height = 0;
                
                height = cString[offset+5]*256 + cString[offset+6];
                width = cString[offset+7]*256 + cString[offset+8];
                
                if( self.tx_sizeRequestCompletion ) {
                    self.tx_sizeRequestCompletion(self, CGSizeMake(width, height));
                }
                
                self.tx_sizeRequestCompletion = nil;
                
                [connection cancel];
                
            }
            else {
                offset += 2;
                block_length = cString[offset]*256 + cString[offset+1];
            }
            
        }
    }
    else if( [self.tx_sizeRequestType isEqualToString: @"GIF"] ) {
        int offset = 6;
        dword width = 0, height = 0;
        memcpy(&width, cString+offset, 2);
        offset += 2;
        
        memcpy(&height, cString+offset, 2);
        offset += 2;
        
        if( self.tx_sizeRequestCompletion ) {
            self.tx_sizeRequestCompletion(self, CGSizeMake(width, height));
        }
        
        self.tx_sizeRequestCompletion = nil;
        
        [connection cancel];
    }
}

-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error {
    if( self.tx_sizeRequestCompletion )
        self.tx_sizeRequestCompletion(self, CGSizeZero);
}

-(NSCachedURLResponse*)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}

- (void)connectionDidFinishLoading: (NSURLConnection *)connection {
    // Basically, we failed to obtain the image size using metadata and the
    // entire image was downloaded...
    
    if(!self.tx_sizeRequestData.length) {
        self.tx_sizeRequestData = nil;
    }
    else {
        //Try parse to UIImage
        UIImage* image = [UIImage imageWithData: self.tx_sizeRequestData];
        
        if( self.tx_sizeRequestCompletion && image) {
            self.tx_sizeRequestCompletion(self, [image size]);
            return;
        }
    }
    
    self.tx_sizeRequestCompletion(self, CGSizeZero);
}

@end

@implementation UIImage (RemoteSize)

+ (void)requestSizeNoHeader:(NSURL*)imgURL completion:(TXUIImageSizeRequestCompleted)completion{
    
    if([imgURL isFileURL] ) {
        //Load from file stream
    }
    else {
        imgURL.tx_sizeRequestCompletion = completion;
        
        NSURLRequest* request = [NSURLRequest requestWithURL:imgURL];
        NSURLConnection* conn = [NSURLConnection connectionWithRequest: request delegate: imgURL];
        [conn scheduleInRunLoop: [NSRunLoop mainRunLoop] forMode: NSDefaultRunLoopMode];
        [conn start];
    }
}


+ (void)requestSizeWithHeader:(NSURL*)imgURL completion:(TXUIImageSizeRequestCompleted)completion{
//        NSURLRequest* request = [NSURLRequest requestWithURL:imgURL];
//
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *resp, NSData *d, NSError *e) {
//            NSLog(@"respone%@", [(NSHTTPURLResponse*)resp allHeaderFields]);
//    
//            
//        }];
}

@end
