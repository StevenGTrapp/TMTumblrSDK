//
//  TMRequestParamaterizerTests.m
//  ExampleiOS
//
//  Created by Kenny Ackerson on 5/2/16.
//  Copyright © 2016 tumblr. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TMRequestParamaterizer.h"
#import "TMHTTPRequest.h"
#import "TMHTTPRequestMethod.h"
#import "TMJSONEncodedRequestBody.h"
#import "TMFormEncodedRequestBody.h"
#import "TMSDKFunctions.h"

@interface TMRequestParamaterizerTests : XCTestCase

@end

@implementation TMRequestParamaterizerTests


- (void)testGetMethod {
    XCTAssert([[self basicRequestWithMethod:TMHTTPRequestMethodGET].HTTPMethod isEqualToString:@"GET"]);
}

- (void)testPostMethod {
    XCTAssert([[self basicRequestWithMethod:TMHTTPRequestMethodPOST].HTTPMethod isEqualToString:@"POST"]);
}

- (void)testDeleteMethod {
    XCTAssert([[self basicRequestWithMethod:TMHTTPRequestMethodDELETE].HTTPMethod isEqualToString:@"DELETE"]);
}

- (void)testPatchMethod {
    XCTAssert([[self basicRequestWithMethod:TMHTTPRequestMethodPATCH].HTTPMethod isEqualToString:@"PATCH"]);
}

- (void)testHTTPBodyExistsJSONBody {
    NSURLRequest *paramedRequest = [self basicHTTPBodyRequestWithBody:[[TMJSONEncodedRequestBody alloc] initWithJSONDictionary:@{@"key" : @"value"}]];

    XCTAssert(paramedRequest.HTTPBody);
}

- (void)testHTTPBodyExistsFormEncodedBody {
    NSURLRequest *paramedRequest = [self basicHTTPBodyRequestWithBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]];

    XCTAssert(paramedRequest.HTTPBody);
}

- (void)testNoneRequestBodyRequestHasNoBody {
    XCTAssert(![self basicRequestWithMethod:TMHTTPRequestMethodGET].HTTPBody);
}

- (void)testHTTPBodyDataIsSet {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodPOST
                                                    additionalHeaders:nil
                                                          requestBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]
                                                             isSigned:NO
                                                             isUpload:NO];
    TMRequestParamaterizer *paramaterizer = [[TMRequestParamaterizer alloc] initWithApplicationCredentials:nil userCredentials:nil request:request additionalHeaders:@{}];


    XCTAssert([paramaterizer URLRequestWithRequest:request].HTTPBody);
}

- (void)testAdditionalHeadersWork {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodPOST
                                                    additionalHeaders:nil
                                                          requestBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]
                                                             isSigned:NO
                                                             isUpload:NO];
    TMRequestParamaterizer *paramaterizer = [[TMRequestParamaterizer alloc] initWithApplicationCredentials:nil userCredentials:nil request:request additionalHeaders:@{@"kenny-header" : @"hello"}];


    XCTAssert([[paramaterizer URLRequestWithRequest:request].allHTTPHeaderFields[@"kenny-header"] isEqualToString:@"hello"]);
}

-(void)testParametizerFalseForGET {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodGET
                                                    additionalHeaders:nil
                                                          requestBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]
                                                             isSigned:NO
                                                             isUpload:NO];
    XCTAssertFalse(postParametersForSignedRequests(request));
}

-(void)testParametizerFalseForHEAD {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodHEAD
                                                    additionalHeaders:nil
                                                          requestBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]
                                                             isSigned:NO
                                                             isUpload:NO];
    XCTAssertFalse(postParametersForSignedRequests(request));
}

-(void)testParametizerFalseForPUT {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodPUT
                                                    additionalHeaders:nil
                                                          requestBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]
                                                             isSigned:NO
                                                             isUpload:NO];
    XCTAssertFalse(postParametersForSignedRequests(request));
}

-(void)testParametizerFalseForDELETE {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodDELETE
                                                    additionalHeaders:nil
                                                          requestBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]
                                                             isSigned:NO
                                                             isUpload:NO];
    XCTAssertFalse(postParametersForSignedRequests(request));
}

-(void)testParametizerFalseForPATCHNoBody {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodPATCH
                                                    additionalHeaders:nil
                                                          requestBody:nil
                                                             isSigned:NO
                                                             isUpload:NO];
    XCTAssertFalse(postParametersForSignedRequests(request));
}

-(void)testParametizerTrueForPATCH {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodPATCH
                                                    additionalHeaders:nil
                                                          requestBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]
                                                             isSigned:NO
                                                             isUpload:NO];
    XCTAssertTrue(postParametersForSignedRequests(request));
}

-(void)testParametizerTrueForPOST {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodPOST
                                                    additionalHeaders:nil
                                                          requestBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]
                                                             isSigned:NO
                                                             isUpload:NO];
    XCTAssertTrue(postParametersForSignedRequests(request));
}

- (void)testHTTPBodyDataIsNotSet {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodPOST
                                                    additionalHeaders:nil
                                                          requestBody:[[TMFormEncodedRequestBody alloc] initWithBody:@{@"key" : @"value"}]
                                                             isSigned:NO
                                                             isUpload:YES];
    TMRequestParamaterizer *paramaterizer = [[TMRequestParamaterizer alloc] initWithApplicationCredentials:nil userCredentials:nil request:request additionalHeaders:@{}];


    XCTAssertNil([paramaterizer URLRequestWithRequest:request].HTTPBody);
}

#pragma mark - Helpers

- (NSURLRequest *)basicHTTPBodyRequestWithBody:(id <TMRequestBody>)body {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com"
                                                               method:TMHTTPRequestMethodPOST
                                                    additionalHeaders:nil
                                                          requestBody:body
                                                             isSigned:NO
                                                             isUpload:NO];

    TMRequestParamaterizer *paramaterizer = [[TMRequestParamaterizer alloc] initWithApplicationCredentials:nil userCredentials:nil request:request additionalHeaders:@{}];

    return [paramaterizer URLRequestWithRequest:request];
}

- (NSURLRequest *)basicRequestWithMethod:(TMHTTPRequestMethod)method {
    TMHTTPRequest *request = [[TMHTTPRequest alloc] initWithURLString:@"http://tumblr.com" method:method];

    TMRequestParamaterizer *paramaterizer = [[TMRequestParamaterizer alloc] initWithApplicationCredentials:nil userCredentials:nil request:request additionalHeaders:@{}];

    return [paramaterizer URLRequestWithRequest:request];
}

@end
