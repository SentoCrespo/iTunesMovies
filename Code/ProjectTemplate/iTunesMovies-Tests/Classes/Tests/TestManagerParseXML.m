/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ManagerParseXML.h"

@interface TestManagerParseXML : XCTestCase

    @property (nonatomic, strong) NSData *dataMovies;
    @property (nonatomic, strong) ManagerParseXML *managerParseXML;

@end

@implementation TestManagerParseXML

- (void)setUp
{
    _dataMovies = [self loadTestXMLFile];
    _managerParseXML = [ManagerParseXML new];
    [super setUp];
}

- (void)tearDown
{
    _dataMovies = nil;
    _managerParseXML = nil;
    [super tearDown];
}


- (void) test_Local_Movies_XML_Exist
{
    // Given
    
    // When
    
    // Then
    XCTAssertNotNil(_dataMovies);
}


- (void) test_Parse_Success
{
    // Given
    XCTestExpectation *expectation = [self expectationWithDescription:
                                      @"Test parsing success"];

    
    // When
    [_managerParseXML parseMoviesXMLData:_dataMovies
                            successBlock:^(id data) {
                                XCTAssertNotNil(data,
                                                @"Parsing should success with data");
                                [expectation fulfill];
                            }
                            failureBlock:nil];
    
    // Then
    [self waitForExpectationsWithTimeout:0.2
                                 handler:^(NSError *error) {
                                     if (error) {
                                         XCTFail(@"Parsing should success: %@", error);
                                     }
                                 }];
}


- (void) test_Parse_Success_Contains_All_Objects
{
    // Given
    NSInteger numberOfObjects = 50;
    XCTestExpectation *expectation = [self expectationWithDescription:
                                      @"Test contains 50 objects"];
    
    // When
    [_managerParseXML parseMoviesXMLData:_dataMovies
                            successBlock:^(id data) {
                                NSArray *dataArray = (NSArray *) data;
                                XCTAssertEqual(dataArray.count, numberOfObjects,
                                @"Parse should contain %ld objects", (long)numberOfObjects);
                                [expectation fulfill];
                            }
                            failureBlock:nil];
    
    // Then
    [self waitForExpectationsWithTimeout:0.4
                                 handler:^(NSError *error) {
                                     if (error) {
                                         XCTFail(@"Parsing should contain objects: %@", error);
                                     }
                                 }];
}


- (void) test_Parse_Failures_Empty_Data
{
    // Given
    XCTestExpectation *expectation = [self expectationWithDescription:
                                      @"Test nil XML"];
    
    // When
    [_managerParseXML parseMoviesXMLData:nil
                            successBlock:nil
                            failureBlock:^(NSError *error) {
                                XCTAssert(YES, @"Nil data should fail");
                                [expectation fulfill];
                            }];
    
    // Then
    [self waitForExpectationsWithTimeout:0.4
                                 handler:^(NSError *error) {
                                     if (error) {
                                         XCTFail(@"Parsing should fail with nil data: %@", error);
                                     }
                                 }];
}




- (void) test_Parse_Success_Contains_All_Data
{
    // Given
    NSInteger identifier = 526323818;
    NSString *name = @"Apollo 13";
    NSString *summary = @"Varados a 330.000 kilómetros de la Tierra en una nave averiada, los astronautas Jim Lovell (Hanks), Fred Haise (Paxton) y Jack Swigert (Bacon) luchan desesperadamente por sobrevivir. Mientras tanto, en el centro de control, el astronauta Ken Mattingly (Sinise), el director de vuelo Gene Kranz (Harris) y el heroico personal de tierra pugnan por traerlos de vuelta.";
    NSString *artist = @"Ron Howard";
    NSString *image = @"http://a191.phobos.apple.com/us/r30/Video/v4/77/50/07/775007a0-d647-02c8-a86b-a243be475a22/apollo13spain.170x170-75.jpg";
    NSString *releaseDate = @"1995-09-06T00:00:00-07:00";
    NSString *categoryTerm = @"Drama";
    
    XCTestExpectation *expectation = [self expectationWithDescription:
                                      @"Test contains correct data"];
    
    // When
    [_managerParseXML parseMoviesXMLData:_dataMovies
                            successBlock:^(id data) {
                                NSArray *dataArray = (NSArray *) data;
                                NSDictionary *firstItem = [dataArray firstObject];
                                XCTAssertEqualObjects(firstItem[identifierAttr],
                                                      @(identifier),
                                                      @"Identifier should be parsed correctly");
                                XCTAssertEqualObjects(firstItem[titleTag],
                                                      name,
                                                      @"Title should be parsed correctly");
                                XCTAssertEqualObjects(firstItem[summaryTag],
                                                      summary,
                                                      @"Summary should be parsed correctly");
                                XCTAssertEqualObjects(firstItem[artistTag],
                                                      artist,
                                                      @"Artist should be parsed correctly");
                                XCTAssertEqualObjects(firstItem[imageTag],
                                                      image,
                                                      @"Image should be parsed correctly");
                                XCTAssertEqualObjects(firstItem[releaseDateTag],
                                                      releaseDate,
                                                      @"Release date should be parsed correctly");
                                XCTAssertEqualObjects(firstItem[categoryTag],
                                                      categoryTerm,
                                                      @"Category date should be parsed correctly");
                                [expectation fulfill];
                            }
                            failureBlock:nil];
    
    // Then
    [self waitForExpectationsWithTimeout:0.4
                                 handler:^(NSError *error) {
                                     if (error) {
                                         XCTFail(@"Parsing doesn't contain correct objects: %@", error);
                                     }
                                 }];
}



#pragma mark - Utils -


- (NSData *) loadTestXMLFile
{
    NSString *filePath = [[NSBundle bundleForClass:self.class]
                          pathForResource:@"movies"
                          ofType:@"xml"];
    
    NSData *fileContent = [NSData dataWithContentsOfFile:filePath];
    return fileContent;
}




@end
