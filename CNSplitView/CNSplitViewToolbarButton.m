//
//  CNSplitViewToolBarButton.m
//
//  Created by cocoa:naut on 27.07.12.
//  Copyright (c) 2012 cocoa:naut. All rights reserved.
//

/*
 The MIT License (MIT)
 Copyright © 2012 Frank Gregor, <phranck@cocoanaut.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the “Software”), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */


#import "CNSplitViewToolbarButton.h"
#import "CNSplitViewToolbarButtonCell.h"


static CGFloat kDefaultButtonWidth = 28.0;

@implementation CNSplitViewToolbarButton
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Initialzation
+ (Class)cellClass
{
    return [CNSplitViewToolbarButtonCell class];
}

- (id)init
{
    self = [super init];
    if (self) {
        _toolbarButtonAlign = CNSplitViewToolbarButtonAlignLeft;
        [(CNSplitViewToolbarButtonCell *)[self cell] setAlign:_toolbarButtonAlign];
        
        _toolbarButtonType = CNSplitViewToolbarButtonTypePlain;
        _toolbarButtonWidth = kDefaultButtonWidth;

        [self setAutoresizingMask:NSViewNotSizable];
        [self setImagePosition:NSImageLeft];
        [self setButtonType:NSMomentaryPushInButton];
        [self setBezelStyle:NSSmallSquareBezelStyle];
        [self setTitle:@""];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableMe) name:kEnableToolbarItemsNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableMe) name:kDisableToolbarItemsNotification object:nil];
    }
    return self;
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Notifications

- (void)enableMe
{
    [self setEnabled:YES];
}

- (void)disableMe
{
    [self setEnabled:NO];
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Accessors

- (void)setTitle:(NSString *)aString
{
    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [textStyle setAlignment: NSCenterTextAlignment];

    NSFont *font = [NSFont fontWithName:@"Helvetiva Neue" size:11.0];

    NSColor *textColor = [[NSColor blackColor] colorWithAlphaComponent:0.9];
    NSShadow* textShadow = [[NSShadow alloc] init];
    [textShadow setShadowColor: [[NSColor whiteColor] colorWithAlphaComponent:0.75]];
    [textShadow setShadowOffset: NSMakeSize(0, -1)];
    [textShadow setShadowBlurRadius: 0];

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                textShadow, NSShadowAttributeName,
                                textColor,  NSForegroundColorAttributeName,
                                textStyle,  NSParagraphStyleAttributeName,
                                font,       NSFontAttributeName,
                                nil];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:aString attributes:attributes];
    [self setAttributedTitle:attributedTitle];
}

- (void)setToolbarButtonAlign:(CNSplitViewToolbarButtonAlign)align
{
    _toolbarButtonAlign = align;
    [(CNSplitViewToolbarButtonCell *)[self cell] setAlign:_toolbarButtonAlign];
}

- (void)setImagePosition:(NSCellImagePosition)aPosition
{
    [super setImagePosition:aPosition];
    [(CNSplitViewToolbarButtonCell *)[self cell] setImagePosition:aPosition];
}

- (void)setToolbarButtonType:(CNSplitViewToolbarButtonType)toolbarButtonType
{
    _toolbarButtonType = toolbarButtonType;
    switch (_toolbarButtonType) {
        case CNSplitViewToolbarButtonTypeAdd:           self.image = [NSImage imageNamed:NSImageNameAddTemplate]; break;
        case CNSplitViewToolbarButtonTypeRemove:        self.image = [NSImage imageNamed:NSImageNameRemoveTemplate]; break;
        case CNSplitViewToolbarButtonTypeQuickLook:     self.image = [NSImage imageNamed:NSImageNameQuickLookTemplate]; break;
        case CNSplitViewToolbarButtonTypeAction:        self.image = [NSImage imageNamed:NSImageNameActionTemplate]; break;
        case CNSplitViewToolbarButtonTypeShare:         self.image = [NSImage imageNamed:NSImageNameShareTemplate]; break;
        case CNSplitViewToolbarButtonTypeIconView:      self.image = [NSImage imageNamed:NSImageNameIconViewTemplate]; break;
        case CNSplitViewToolbarButtonTypeListView:      self.image = [NSImage imageNamed:NSImageNameListViewTemplate]; break;
        case CNSplitViewToolbarButtonTypeLockLocked:    self.image = [NSImage imageNamed:NSImageNameLockLockedTemplate]; break;
        case CNSplitViewToolbarButtonTypeLockUnlocked:  self.image = [NSImage imageNamed:NSImageNameLockUnlockedTemplate]; break;
        case CNSplitViewToolbarButtonTypeGoRight:       self.image = [NSImage imageNamed:NSImageNameGoRightTemplate]; break;
        case CNSplitViewToolbarButtonTypeGoLeft:        self.image = [NSImage imageNamed:NSImageNameGoLeftTemplate]; break;
        case CNSplitViewToolbarButtonTypeStopProgress:  self.image = [NSImage imageNamed:NSImageNameStopProgressTemplate]; break;
        case CNSplitViewToolbarButtonTypeRefresh:       self.image = [NSImage imageNamed:NSImageNameRefreshTemplate]; break;
        default: break;
    }
}


@end
