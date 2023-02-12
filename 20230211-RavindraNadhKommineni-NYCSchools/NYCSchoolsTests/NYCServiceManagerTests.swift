//
//  NYCServiceManagerTests.swift
//  NYCSchoolsTests
//
//  Created by Ravindra Nadh Kommineni on 12/02/23.
//

import XCTest
@testable import NYCSchools
final class NYCServiceManagerTests: XCTestCase {
    var urlSession: URLSession!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        urlSession = nil
    }
    
    func testGetSchoolsAPI() async throws {
        // Injected with custom url session for mocking
        let serviceManger = NYCServiceManager(NYCSchoolEndPoint(), urlSession)
        
        // Set mock data
        guard let mockData = TestUtility.schoolsSuccessString.data(using: .utf8) else {
            return
        }
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        do {
            let schools : [NYCSchool] = try await serviceManger.getSchools([:])
            XCTAssert(!schools.isEmpty, "Schools can not be empty")
            let school = schools.first
            
            // Similarily, verify all necessary info.
            XCTAssertEqual(school?.id, "02M260")
            XCTAssertEqual(school?.name, "Clinton School Writers & Artists, M.S. 260")
            XCTAssertEqual(school?.city, "Manhattan")
            XCTAssertEqual(school?.zip, "10003")
            XCTAssertEqual(school?.description, "Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.")
            XCTAssertEqual(school?.location, "10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)")
        } catch {
            XCTFail("Not expected to throw error: \(error)")
        }
    }
    
    func testGetSchoolsAPI_EmptyResponse() async throws {
        // Injected with custom url session for mocking
        let serviceManger = NYCServiceManager(NYCSchoolEndPoint(), urlSession)
        
        // Set mock data
        guard let mockData = TestUtility.schoolsEmptyString.data(using: .utf8) else {
            return
        }
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        do {
            let schools : [NYCSchool] = try await serviceManger.getSchools([:])
            XCTAssertEqual(schools.isEmpty, true)
        } catch {
            XCTFail("Not expected to throw error: \(error)")
        }
    }
    
    func testGetSchoolsAPI_DecodingError() async throws {
        // Injected with custom url session for mocking
        let serviceManger = NYCServiceManager(NYCSchoolEndPoint(), urlSession)
        
        // Set mock data
        guard let mockData = TestUtility.schoolsInvalidString.data(using: .utf8) else {
            return
        }
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        do {
            let schools : [NYCSchool] = try await serviceManger.getSchools([:])
            XCTFail("Not expected to fetch correct data: \(schools)")
        } catch {
            XCTAssertNotNil(error)
            XCTAssertEqual(error as! ServiceError, ServiceError.failedToDecodeResponse, "Expected to throw parsing error")
        }
    }
    
    func testGetScoresAPI() async throws {
        // Injected with custom url session for mocking
        let serviceManger = NYCServiceManager(NYCSATScoreEndPoint(), urlSession)
        
        // Set mock data
        guard let mockData = TestUtility.scoresSuccessString.data(using: .utf8) else {
            return
        }
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        do {
            let scores : [NYCSATScore] = try await serviceManger.getSATScores(["dbn":"02M260"])
            XCTAssert(!scores.isEmpty, "Scores can not be empty")
            let score = scores.first
            
            // Similarily, verify all necessary info.
            XCTAssertEqual(score?.id, "02M260")
            XCTAssertEqual(score?.schoolName, "Clinton School Writers & Artists, M.S. 260")
            XCTAssertEqual(score?.studentsCount, "29")
            XCTAssertEqual(score?.readingScore, "355")
            XCTAssertEqual(score?.writingScore, "363")
            XCTAssertEqual(score?.mathScore, "404")
        } catch {
            XCTFail("Not expected to throw error: \(error)")
        }
    }
    
    func testGetScoresAPI_EmptyResponse() async throws {
        // Injected with custom url session for mocking
        let serviceManger = NYCServiceManager(NYCSATScoreEndPoint(), urlSession)
        
        // Set mock data
        guard let mockData = TestUtility.scoresEmptyString.data(using: .utf8) else {
            return
        }
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        do {
            let scores : [NYCSATScore] = try await serviceManger.getSATScores(["dbn":"02M260"])
            XCTAssertEqual(scores.isEmpty, true)
        } catch {
            XCTFail("Not expected to throw error: \(error)")
        }
    }
    
    func testGetScoresAPI_DecodingError() async throws {
        // Injected with custom url session for mocking
        let serviceManger = NYCServiceManager(NYCSATScoreEndPoint(), urlSession)
        
        // Set mock data
        guard let mockData = TestUtility.scoresInvalidString.data(using: .utf8) else {
            return
        }
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        do {
            let scores : [NYCSATScore] = try await serviceManger.getSATScores(["dbn":"02M260"])
            XCTFail("Not expected to fetch correct data: \(scores)")
        } catch {
            XCTAssertNotNil(error)
            XCTAssertEqual(error as! ServiceError, ServiceError.failedToDecodeResponse, "Expected to throw parsing error")
        }
    }

}

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
    }
}
