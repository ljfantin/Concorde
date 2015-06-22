//
//  CCBufferedImageView.m
//  Concorde
//
//  Created by Leandro Fantin on 19/6/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

#import "CCBufferedImageView.h"
#import "CCBufferedImageDecoder.h"

static const NSInteger kDefaultContentLength = 5*1024*1024;

@interface CCBufferedImageView () <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection* connection;
@property (nonatomic, strong) NSMutableData * data;
@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation CCBufferedImageView

- (void)dealloc {

    [self.connection cancel];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.queue = dispatch_queue_create("com.contentful.Concorde", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.queue = dispatch_queue_create("com.contentful.Concorde", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (id)initWithUrl:(NSURL*)url
{
    return [self initWithUrl:url andHeaderParameters:nil];
}

- (void)loadWithUrl:(NSURL*)url
{
    [self loadWithUrl:url andHeaderParameters:nil];
}

- (id)initWithUrl:(NSURL*)url andHeaderParameters:(NSDictionary*)headerParameters
{
    self = [super initWithImage:nil];
    if (self)   {
        self.backgroundColor = [UIColor grayColor];
        self.queue = dispatch_queue_create("com.contentful.Concorde", DISPATCH_QUEUE_SERIAL);
        [self loadWithUrl:url];
    }
    return self;
}

- (void)loadWithUrl:(NSURL*)url andHeaderParameters:(NSDictionary*)headerParameters
{
    if (self.connection!=nil)   {
        [self.connection cancel];
    }
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    if (headerParameters!=nil)  {
        for (NSString * keyHeaderParameter in headerParameters) {
            [request setValue:headerParameters[keyHeaderParameter] forKey:keyHeaderParameter];
        }
    }
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSInteger contentLength = response.expectedContentLength;
    if (response.expectedContentLength<0) {
        contentLength = kDefaultContentLength;
    }
    self.data = [[NSMutableData alloc] initWithCapacity:contentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (self.data!=nil) {
        [self.data appendData:data];
        __weak typeof(self) weakSelf = self;
        dispatch_async(self.queue,^{
            CCBufferedImageDecoder * decoder = [[CCBufferedImageDecoder alloc] initWithData:weakSelf.data];
            [decoder decompress];
            // TODO Podria retornar NSImage. Ver si usamos ese define
            UIImage * decoderImage = [decoder toImage];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.image = decoderImage;
            });
        });
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.data = nil;
    if (self.loadedHandler!=nil)    {
        self.loadedHandler();
    }
}


@end
