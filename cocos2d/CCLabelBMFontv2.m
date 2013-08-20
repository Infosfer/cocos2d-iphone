/*
 * CocosBuilder: http://www.cocosbuilder.com
 *
 * Copyright (c) 2012 Zynga Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "CCLabelBMFontv2.h"

@implementation CCLabelBMFontv2

@synthesize horizontalAlignment;
@synthesize verticalAlignment;
@synthesize shrink;
@synthesize shrinkScale;
@synthesize fontScale;

- (id) init
{
    self = [super init];
    if (!self) return NULL;
    
    NSLog(@"CCLabelBMFontv2::initialize");
    
    shrink = FALSE;
    shrinkScale = 1;
    fontScale = 1;
    
    _helperLabel = [[[CCLabelBMFont alloc] init] autorelease];
    [_helperLabel setIgnoreAnchorPointForPosition:YES];
    [_helperLabel setAnchorPoint:CGPointMake(0, 0)];
    [super addChild:_helperLabel];
    
    [self setHorizontalAlignment:kCCTextAlignmentCenter];
    [self setVerticalAlignment:kCCVerticalTextAlignmentCenter];
    [self setAnchorPoint:CGPointMake(0.5, 0.5)];
    
    return self;
}

-(void) setContentSize:(CGSize) size
{
    NSLog(@"CCLabelBMFontv2::setDimensions: Width = %f Height = %f", size.width, size.height);
    
    super.contentSize = size;
    
    if(!shrink){
        [_helperLabel setWidth:self.contentSize.width];
    }
        
	[self refresh];
}

- (void) setString:(NSString*) newString {
    NSLog(@"CCLabelBMFontv2::setString");
    
    [_helperLabel setString:newString];
    
    [self refresh];
}

- (NSString*) string {
    NSLog(@"CCLabelBMFontv2::getString");
    
    return [_helperLabel string];
}

-(void) setHorizontalAlignment:(CCTextAlignment)alignment
{
    NSLog(@"CCLabelBMFontv2::setHorizontalAlignment");
        
    horizontalAlignment = alignment;
        
    [_helperLabel setAlignment:horizontalAlignment];
    
    switch (horizontalAlignment) {
        case kCCTextAlignmentLeft:
            [_helperLabel setPosition:CGPointMake(0, _helperLabel.position.y)];
            break;
        case kCCTextAlignmentCenter:
            [_helperLabel setPosition:CGPointMake(self.contentSize.width / 2 - ((_helperLabel.contentSize.width * _helperLabel.scale) / 2), _helperLabel.position.y)];
            break;
        case kCCTextAlignmentRight:
            [_helperLabel setPosition:CGPointMake(self.contentSize.width - (_helperLabel.contentSize.width * _helperLabel.scale), _helperLabel.position.y)];
            break;
        default:
            break;
    }
}

-(void) setVerticalAlignment:(CCVerticalTextAlignment)alignment
{
    NSLog(@"CCLabelBMFontv2::setVerticalAlignment");
        
    verticalAlignment = alignment;
        
    switch (verticalAlignment) {
        case kCCVerticalTextAlignmentBottom:
            [_helperLabel setPosition:CGPointMake(_helperLabel.position.x, 0)];
            break;
        case kCCVerticalTextAlignmentCenter:
            [_helperLabel setPosition:CGPointMake(_helperLabel.position.x, self.contentSize.height / 2 - (_helperLabel.contentSize.height * _helperLabel.scale) / 2)];
            break;
        case kCCVerticalTextAlignmentTop:
            [_helperLabel setPosition:CGPointMake(_helperLabel.position.x, self.contentSize.height - (_helperLabel.contentSize.height * _helperLabel.scale))];
            break;
        default:
            break;
    }
}

-(void) setShrink:(BOOL)value {
    if(shrink != value) {
        NSLog(@"CCLabelBMFontv2::setShrink");
        
        shrink = value;
        
        if(shrink){
            [_helperLabel setWidth:0];
        }
        
        [self refresh];
    }
}

-(void) refresh {
    [self updateTexture];
    [self setHorizontalAlignment:self.horizontalAlignment];
    [self setVerticalAlignment:self.verticalAlignment];
}

-(void) updateTexture {
    NSLog(@"CCLabelBMFontv2::updateTexture");
    
    if(shrink){
        [_helperLabel setContentSize:CGSizeMake(0, 0)];
        [_helperLabel setAlignment:horizontalAlignment];
    
        NSLog(@"CCLabelBMFontv2::RealContentSize: %f %f", _helperLabel.contentSize.width, _helperLabel.contentSize.height);

        float scaleFactor = self.contentSize.width / (_helperLabel.contentSize.width * fontScale);
        
        if(scaleFactor < 1){
            shrinkScale = scaleFactor;
        }
        else if(fontScale != 1){
            shrinkScale = 1;
        }
        
        NSLog(@"CCLabelBMFontv2::EditorScale: %f", fontScale);
        NSLog(@"CCLabelBMFontv2::ShrinkScale: %f", shrinkScale);
        NSLog(@"CCLabelBMFontv2::Scale: %f", [super scale]);
        
        [_helperLabel setScale:(fontScale * shrinkScale)];

    }
    else {
        [_helperLabel setScale:fontScale];
    }
}


-(void) setFontScale:(float) fontSc {
    NSLog(@"CCLabelBMFontv2::setScaleX %f", fontSc);
    
    fontScale = fontSc;
    [self refresh];
}

-(ccColor3B) color
{
	return [_helperLabel color];
}


-(void) setColor:(ccColor3B)color
{
	[_helperLabel setColor:color];
}

-(GLubyte) opacity
{
	return [_helperLabel opacity];
}

- (void) setOpacity:(GLubyte)opacity
{
	[_helperLabel setOpacity:opacity];
}

- (void) setFntFile:(NSString*) fntFile
{
    [_helperLabel setFntFile:fntFile];
    [self refresh];
}

- (NSString*) fntFile
{
    return [_helperLabel fntFile];
}

- (void) setBlendFunc:(ccBlendFunc) bldFunc
{
    [_helperLabel setBlendFunc:bldFunc];
}

- (ccBlendFunc) blendFunc
{
    return [_helperLabel blendFunc];
}

@end
