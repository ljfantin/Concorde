//
//  CCBufferedImageView.m
//  Concorde
//
//  Created by Leandro Fantin on 19/6/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

#import "CCBufferedImageView.h"

static const NSInteger kDefaultContentLength = 5*1024*1024;

@interface CCBufferedImageView () <NSURLConnectionDataDelegate>

@property (nonatomic,weak) NSURLConnection* connection;
@property (nonatomic,strong) NSMutableData * data;
@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation CCBufferedImageView

- (id)initWithUrl:(NSURL*)url
{
    self = [self init];
    self.queue = dispatch_queue_create("com.contentful.Concorde", DISPATCH_QUEUE_SERIAL);
}

- (void)loadFromUrl:(NSURL*)url
{

}

#pragma mark - NSURLConnectionDataDelegate
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
 /*var contentLength = Int(response.expectedContentLength)
        if contentLength < 0 {
            contentLength = defaultContentLength
        }

        data = NSMutableData(capacity: contentLength)*/
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
 /*self.data?.appendData(data)

        dispatch_sync(queue) {
            let decoder = CCBufferedImageDecoder(data: self.data)
            decoder.decompress()
            let decodedImage = decoder.toImage()

            dispatch_async(dispatch_get_main_queue()) {
                self.image = decodedImage
            }
        }*/

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
 /*data = nil

        if let loadedHandler = loadedHandler {
            loadedHandler()
        }*/
}


@end
