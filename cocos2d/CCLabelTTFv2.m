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

#import "CCLabelTTFv2.h"

@implementation CCLabelTTFv2

@synthesize shrink;

- (id) init
{
    self = [super init];
    if (!self) return NULL;
    
    defaultFontSize = -1;
    shrink = true;
    
    return self;
}

// Override setString
- (void) setString:(NSString *)str {
    [super setString:str];
    [self updateFontSize];
}

// Override setDimensions
- (void) setDimensions:(CGSize)dimensions
{
    [super setDimensions:dimensions];
    [self updateFontSize];
}

// Override setFontSize
- (void) setFontSize:(float)fontSize
{
    defaultFontSize = fontSize;
    [super setFontSize:fontSize];
    [self updateFontSize];
}

- (void) setShrink:(BOOL)val
{
    shrink = val;
    [self updateFontSize];
}

- (int) getDefaultFontSize {
    if(defaultFontSize == -1){
        defaultFontSize = [super fontSize];
    }
    
    return defaultFontSize;
}

- (void) updateFontSize
{
    if (shrink) {
        float currentFontSize = [self getDefaultFontSize];
        [super setFontSize:currentFontSize];
        CGSize realTextSize = [self calculateRealTextSize];
        
        while (realTextSize.width > [super dimensions].width) {
            currentFontSize--;
            
            if(currentFontSize < 5){
                break;
            }
            
            [super setFontSize:currentFontSize];
            realTextSize = [self calculateRealTextSize];
        }
    }
}

- (CGSize) calculateRealTextSize
{
    float dimensionWidth = [super dimensions].width;
    float dimensionHeight = [super dimensions].height;
        
    [super setDimensions:CGSizeMake(0, 0)];
    
    CGSize realTextSize = CGSizeMake([super contentSize].width, [super contentSize].height);
        
    [super setDimensions:CGSizeMake(dimensionWidth, dimensionHeight)];
        
    return realTextSize;
}



@end
