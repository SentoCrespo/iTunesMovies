/******************************************************************************
 *
 * Categories
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import "NSString+NSStringExtensions.h"

@implementation NSString (NSStringExtensions)

#pragma mark - Contains substrings

- (NSString *) stringBetweenString: (NSString*) start
                         andString: (NSString *)end
{

    NSScanner* scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];

    if ([scanner scanString:start intoString:NULL]) {
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result]) {
            return result;
        }
    }
    return nil;
}

- (BOOL) contains: (NSString *) string
{
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

- (BOOL) containsCaseInsensitive: (NSString *) string
{
    
    NSRange range = [self rangeOfString:string options:NSCaseInsensitiveSearch];
    return (range.location != NSNotFound);
}

- (NSMutableArray *) splitOnChar: (char) ch
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    int start = 0;
    for(int i=0; i<[self length]; i++) {
        
        BOOL isAtSplitChar = [self characterAtIndex:i] == ch;
        BOOL isAtEnd = i == [self length] - 1;
        
        if(isAtSplitChar || isAtEnd) {
            //take the substring and add it to the array
            NSRange range;
            range.location = start;
            range.length = i - start + 1;
            
            if(isAtSplitChar)
                range.length -= 1;
            
            [results addObject:[self substringWithRange:range]];
            start = i + 1;
        }
        
        //handle the case where the last character was the split char.  we need an empty trailing element in the array.
        if(isAtEnd && isAtSplitChar)
            [results addObject:@""];
    }
    
    return results;
}

- (NSMutableArray *) splitWithStringInC: (char *) separator
{
    
    const char *cInfo = [self UTF8String];
    NSMutableArray *words = [[NSMutableArray alloc] init];
    

    char *pch;
    pch = strtok ((char *)cInfo,separator);
    while (pch != NULL) {
        
        NSString *temp = [NSString stringWithUTF8String:pch];
        
        [words addObject:temp];
        
        pch = strtok (NULL, separator);
    }
    
    return words;
}




- (NSString *) removeCharactersFromStart: (NSInteger) numberOfCharacters
{
    return [self substringFrom:numberOfCharacters
                            to:[self length]];
}


- (NSString *) removeCharactersFromEnd: (NSInteger) numberOfCharacters
{
    return [self substringFrom:0
                            to:[self length] - numberOfCharacters];
}


- (NSString *) substringFrom:(NSInteger)from
                          to:(NSInteger)to
{
    NSString *rightPart = [self substringFromIndex:from];
    return [rightPart substringToIndex:to-from];
}


#pragma mark - Check Content

- (BOOL) isAllDigits
{
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    BOOL result = (r.location == NSNotFound);
    return result;
    
    
    // Another way of doing so...
//    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
//    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
//    return [_NumericOnly isSupersetOfSet: myStringSet];
}



- (BOOL) isEqualToStringCaseInsensitive:(NSString *)aString
{
    
    if (!aString) {
        if (!self) {
            return YES;
        }
        return NO;
    }

    
    if ([self caseInsensitiveCompare:aString] == NSOrderedSame)
        return YES;
    return NO;
}


#pragma mark - Blank Spaces

- (BOOL) isBlank
{
    NSString *stringNoBlanks = [self stringByStrippingWhitespace];
    if([stringNoBlanks isEqualToString:@""] || stringNoBlanks.length == 0 || stringNoBlanks == nil || [stringNoBlanks isEqual:[NSNull null]])
        return YES;
    return NO;
}

- (NSString *) stringByStrippingWhitespace
{
    NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    result = [result stringByReplacingOccurrencesOfString:@" "
                                               withString:@""];
    return result;
}

- (NSString *) stringByCollapsingBlankSpaces
{
    NSString *clean = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *squashed = [clean stringByReplacingOccurrencesOfString:@"[ ]+"
                                                             withString:@" "
                                                                options:NSRegularExpressionSearch
                                                                  range:NSMakeRange(0, clean.length)];
    
    NSString *result = [squashed stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return result;
}

// Collapse contiguous blank spaces
// [NSCharacterSet whitespaceAndNewlineCharacterSet] and ' ' to the two arguments
- (NSString *) stringCollapsingCharacterSet: (NSCharacterSet *) characterSet toCharacter: (unichar) ch
{
    NSInteger fullLength = [self length];
    int length = 0;
    unichar *newString = malloc(sizeof(unichar) * (fullLength + 1));
    
    BOOL isInCharset = NO;
    for (int i = 0; i < fullLength; i++) {
        unichar thisChar = [self characterAtIndex: i];
        
        if ([characterSet characterIsMember: thisChar]) {
            isInCharset = YES;
        }
        else {
            if (isInCharset) {
                newString[length++] = ch;
            }
            
            newString[length++] = thisChar;
            isInCharset = NO;
        }
    }
    
    newString[length] = '\0';
    
    NSString *result = [NSString stringWithCharacters: newString length: length];
    
    free(newString);
    
    return result;
}

#pragma mark - Formatting

// Just for numbers and formatting them
- (NSString *) processAndFormatStringwithDecimals: (NSInteger) decimalNumbers
                                        withLimit: (NSInteger) limit
{
    
    NSInteger length = self.length;
    NSString *textResult = self;
    
    if (length == 0) {
        return @"";
    }
    
    
    // Trim Whitespaces
    textResult = [textResult stringByStrippingWhitespace];
    
    // Remove commas and points
    textResult = [textResult stringByReplacingOccurrencesOfString:@","
                                                       withString:@""];
    
    textResult = [textResult stringByReplacingOccurrencesOfString:@"."
                                                       withString:@""];
    
    // Convert to all digits just in case
    if (![textResult isAllDigits]){
        textResult = [textResult stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    }
    
    // Trim if it's longer than the maximum allowed
    if (length > limit) {
        textResult = [textResult substringToIndex:limit];
    }
    
    
    
    NSMutableString *textResultMutable = [textResult mutableCopy];
    if (decimalNumbers > 0 && textResultMutable.length > decimalNumbers) {
        [textResultMutable insertString: @","
                                atIndex: (textResultMutable.length - decimalNumbers)];
    }
    
    return textResultMutable;
}

- (NSString *) capitalizeFirstLetter
{

    if (self.length > 0)
    {
        NSString *tempString = [self lowercaseString];
        return [tempString stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                   withString:[[self substringToIndex:1] capitalizedString]];
    }
    
    return self;
}
#pragma mark - Email Validation


- (BOOL) validateEmail
{
    return [self validateEmailStrict:YES];
}


- (BOOL) validateEmailStrict:(BOOL) strictFilter
{
    
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = strictFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}



#pragma mark - Regular expressions

- (NSString *) stringByReplacingWithRegExpString: (NSString *) pattern
                         withTemplateReplacement: (NSString *) replacement
                                 caseInsensitive: (BOOL) isCaseInsensitive
{
    
    NSError *error = nil;
    NSInteger flagInsensitive = isCaseInsensitive ? NSRegularExpressionCaseInsensitive : 0;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:pattern
                                  options:flagInsensitive
                                  error:&error];
    if(error)
    {
        NSLog(@"Error (RegExp): %@",error);
        return nil;
    }
    
    if (!self)
    {
        return nil;
    }
    
    NSString *replaced = [regex stringByReplacingMatchesInString:self
                                                         options:0
                                                           range:NSMakeRange(0, [self length])
                                                    withTemplate:replacement];
    return replaced;
    
}




@end
