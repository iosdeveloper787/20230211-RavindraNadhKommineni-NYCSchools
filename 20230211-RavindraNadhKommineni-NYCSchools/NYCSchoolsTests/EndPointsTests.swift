//
//  EndPointsTests.swift
//  NYCSchoolsTests
//
//  Created by Ravindra Nadh Kommineni on 12/02/23.
//

import XCTest
@testable import NYCSchools

final class EndPointsTests: XCTestCase {
    var schoolEndPoint: EndPoint!
    var scoreEndPoint: EndPoint!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        schoolEndPoint = NYCSchoolEndPoint()
        scoreEndPoint = NYCSATScoreEndPoint()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        schoolEndPoint = nil
        scoreEndPoint = nil
    }
    
    func testNYCSchoolEndPointDefaultValues() throws {
        XCTAssertEqual(schoolEndPoint.appToken, "b3xmAoYe2DSek5CDAla7XpETn")
        XCTAssertEqual(schoolEndPoint.header, ["Content-Type": "application/json"])
        XCTAssertEqual(schoolEndPoint.path, "/s3k6-pzi2.json?")
        XCTAssertEqual(schoolEndPoint.scheme, "https")
        XCTAssertEqual(schoolEndPoint.host, "data.cityofnewyork.us/resource")
        XCTAssertEqual(schoolEndPoint.method, .get)
    }
    
    func testNYCSchoolEndPointGetURLString() throws {
        // When
        let urlString = schoolEndPoint.getURLString()
        
        // Then
        XCTAssertEqual(urlString, "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=b3xmAoYe2DSek5CDAla7XpETn")
    }
    
    func testNYCSATScoreEndPointDefaultValues() throws {
        // Then
        XCTAssertEqual(scoreEndPoint.appToken, "b3xmAoYe2DSek5CDAla7XpETn")
        XCTAssertEqual(scoreEndPoint.header, ["Content-Type": "application/json"])
        XCTAssertEqual(scoreEndPoint.path, "/f9bf-2cp4.json?")
        XCTAssertEqual(scoreEndPoint.scheme, "https")
        XCTAssertEqual(scoreEndPoint.host, "data.cityofnewyork.us/resource")
        XCTAssertEqual(scoreEndPoint.method, .get)
    }
    
    func testNYCSATScoreEndPointGetURLString() throws {
        // When
        let urlString = scoreEndPoint.getURLString()
        
        // Then
        XCTAssertEqual(urlString, "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?$$app_token=b3xmAoYe2DSek5CDAla7XpETn")
    }

}

