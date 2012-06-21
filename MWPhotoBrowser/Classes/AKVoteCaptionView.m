//
//  AKVoteCaptionView.m
//  MWPhotoBrowser
//
//  Created by Alison Kline on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AKVoteCaptionView.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat labelPadding = 10; //mirror of MWCaptionView implementation

@interface AKVoteCaptionView () 

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) id <MWPhoto> photo;  // needed to access photoURL property in super class

@end


@implementation AKVoteCaptionView {
    id <AKVoteCaptionViewDelegate> _delegate;
}

@synthesize button = _button;
@synthesize photo = _photo;

- (id)initWithPhoto:(id<MWPhoto>)photo andDelegate:(id <AKVoteCaptionViewDelegate>)delegate {
    if ((self = [self initWithPhoto:photo])) {
        _delegate = delegate;
	}
	return self;
}


// I overrode this method as I counldn't figure out how to directly access the _photo URL private ivar - this method sets the caption view to have the photo as a fully accesible property

- (id)initWithPhoto:(id<MWPhoto>)photo {  //probably should just over ride necessary line in main library
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]; // Random initial frame
    if (self) {
        //        _photo = [photo retain]; // from lib
        // _photo = photo; // from issue 55
        self.photo = photo;  //added by Alison to make it work with property
        self.opaque = NO;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self setupCaption];
    }
    return self;
}

#pragma mark - creating custom caption view

- (void)setupCaption {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    button.opaque = NO;
    button.backgroundColor = [UIColor clearColor];
    button.alpha = 0.6;
    
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:NSLocalizedString(@"Vote", @"") forState:UIControlStateNormal];
    
    // control of button color from http://stackoverflow.com/questions/2808888/is-it-even-possible-to-change-a-uibuttons-background-color
    [button setBackgroundImage:[AKVoteCaptionView imageFromColor:[UIColor grayColor]] forState:UIControlStateNormal];
    button.layer.cornerRadius = 8.0;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(1, 1);
    
    [button sizeToFit];
    //    NSLog(@"button.frame = %@", NSStringFromCGRect([button frame]));
    button.frame = CGRectMake((self.bounds.size.width-button.frame.size.width)/2, labelPadding, button.frame.size.width, button.frame.size.height);
    
    self.button = button;
    [self addSubview:button];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, self.button.frame.size.height + labelPadding * 2);
}

#pragma mark - button Action

- (void) buttonAction {
    NSLog(@"Button was pressed");
    NSURL *photoURL;
    if ([self.photo respondsToSelector:@selector(photoURL)]) {
        photoURL = [self.photo performSelector:@selector(photoURL)];
    }
    [_delegate akVoteCaptionView:self chosePhotoWithURL:photoURL];
    NSLog(@"photoURL = %@ sent to delegate", photoURL);
}

- (void)dealloc {
    [_delegate release];
    [_button release];
    [_photo release];
    [super dealloc];
}

#pragma mark - Utility method for creating color images - could be put elsewhere

+ (UIImage *) imageFromColor:(UIColor *)color 
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
