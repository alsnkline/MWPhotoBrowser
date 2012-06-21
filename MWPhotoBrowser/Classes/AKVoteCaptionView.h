//
//  AKVoteCaptionView.h
//  MWPhotoBrowser
//
//  Created by Alison Kline on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MWCaptionView.h"

// creating a protocol to recieve reports of 'voting'
@class AKVoteCaptionView;

@protocol AKVoteCaptionViewDelegate <NSObject>
@optional
-(void)akVoteCaptionView:(AKVoteCaptionView *) sender 
   chosePhotoWithURL:(NSURL *)url;
@end

@interface AKVoteCaptionView : MWCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo andDelegate:(id <AKVoteCaptionViewDelegate>)delegate;

//overriding methods to create custom caption View containing a vote button
- (void)setupCaption;
- (CGSize)sizeThatFits:(CGSize)size;

@end

