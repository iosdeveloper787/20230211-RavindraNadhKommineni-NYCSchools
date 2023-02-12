//
//  NYCSchoolDetailsViewModelTests.swift
//  NYCSchoolsTests
//
//  Created by Ravindra Nadh Kommineni on 12/02/23.
//

import XCTest
@testable import NYCSchools
final class NYCSchoolDetailsViewModelTests: XCTestCase {
    var viewModel: NYCSchoolDetailsViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        let serviceManager = NYCServiceManager(NYCSATScoreEndPoint(), urlSession)
        viewModel = NYCSchoolDetailsViewModel(serviceManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNYCSATScoreViewModel() async throws {
        // Set mock data
        guard let mockData = TestUtility.scoresSuccessString.data(using: .utf8) else {
            return
        }
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        let school = NYCSchool(school_name: "Clinton School Writers & Artists, M.S. 260", overview_paragraph: "Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.", dbn: "02M260", city: "Manhattan", zip: "10003", location: "10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)")
        // Fetch scores.
        await viewModel.fetchSchooolSATScores(school)
        
        XCTAssertEqual(viewModel.scores.count, 1)
    }
}
