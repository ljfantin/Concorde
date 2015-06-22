//
//  CCBufferedImageView.h
//  Concorde
//
//  Created by Leandro Fantin on 19/6/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^LoadedHandler)(void);

@interface CCBufferedImageView : UIImageView

@property (nonatomic, copy) LoadedHandler loadedHandler;

- (id)initWithUrl:(NSURL*)url;

- (void)loadWithUrl:(NSURL*)url;

@end
