/******************************************************************************
 *
 * Categories
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import <Foundation/Foundation.h>

#define STR(var) NSLocalizedString(var, nil)

@interface NSString (NSStringExtensions)

#pragma mark -
#pragma mark Contains substrings

- (NSString *) stringBetweenString: (NSString*) start
                         andString: (NSString *)end;

- (BOOL) contains: (NSString *) string;
- (BOOL) containsCaseInsensitive: (NSString *) string;

- (NSMutableArray *) splitOnChar: (char) ch;

- (NSMutableArray *) splitWithStringInC: (char *) separator;

- (NSString *) removeCharactersFromStart: (NSInteger) numberOfCharacters;

- (NSString *) removeCharactersFromEnd: (NSInteger) numberOfCharacters;

- (NSString *) substringFrom:(NSInteger)from
                          to:(NSInteger)to;

#pragma mark - Check Content

- (BOOL) isAllDigits;
- (BOOL) isEqualToStringCaseInsensitive:(NSString *)aString;


#pragma mark - Blank Spaces

- (BOOL) isBlank;
- (NSString *) stringByStrippingWhitespace;
- (NSString *) stringByCollapsingBlankSpaces;
- (NSString *) stringCollapsingCharacterSet: (NSCharacterSet *) characterSet toCharacter: (unichar) ch;


#pragma mark - Formatting

- (NSString *) processAndFormatStringwithDecimals: (NSInteger) decimalNumbers
                                        withLimit: (NSInteger) limit;
- (NSString *) capitalizeFirstLetter;

#pragma mark - Email Validation

- (BOOL) validateEmail;
- (BOOL) validateEmailStrict:(BOOL) strictFilter;

#pragma mark - Regular expressions

- (NSString *) stringByReplacingWithRegExpString: (NSString *) pattern
                         withTemplateReplacement: (NSString *) replacement
                                 caseInsensitive: (BOOL) isCaseInsensitive;


@end
