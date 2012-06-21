//
//  Menu.h
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 21/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//
//  Added to by Alison Kline 
//  Custom caption view created containing a single "Vote" button.
//  When pressed the button reports the current PhotoURL back to its delegate.
//  If the photo does not have a URL it reports 'nil'
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "AKVoteCaptionView.h"

@interface Menu : UITableViewController <MWPhotoBrowserDelegate, AKVoteCaptionViewDelegate> {
    NSArray *_photos;
    UISegmentedControl *_segmentedControl;
}
@property (nonatomic, retain) NSArray *photos;
@end
