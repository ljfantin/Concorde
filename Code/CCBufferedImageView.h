//
//  CCBufferedImageView.h
//  Concorde
//
//  Created by Leandro Fantin on 19/6/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CCBufferedImageView : UIImageView 

- (id)initWithUrl:(NSURL*)url;

- (void)loadFromUrl:(NSURL*)url;

@end
