//
//  URLBuilderTests.swift
//  TechnicalTask-lvl1Tests
//
//  Created by Alexander Pavlovets on 16.12.24.
//

import XCTest
@testable import TechnicalTask_lvl1

final class URLBuilderTests: XCTestCase {

    var urlBuilderImp: URLBuilderImp!
    var routeStub: APIRouteStub!

    override func setUpWithError() throws {
        urlBuilderImp = URLBuilderImp()
        routeStub = APIRouteStub()
    }

    override func tearDownWithError() throws {
        urlBuilderImp = nil
        routeStub = nil
    }

    func testURLBuilder() throws {
        
        // When
        let request = try urlBuilderImp.build(with: routeStub)
        let url = try XCTUnwrap(request.url)

        // Then
        XCTAssertEqual(url.absoluteString, "https://stubapi.com/stubEndpoint")
        XCTAssertEqual(request.httpMethod, "GET")
    }
}
