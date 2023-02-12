//
//  NYCSchoolsListViewModelsTests.swift
//  NYCSchoolsTests
//
//  Created by Ravindra Nadh Kommineni on 12/02/23.
//

import XCTest
@testable import NYCSchools
final class NYCSchoolsListViewModelsTests: XCTestCase {
    var viewModel: NYCSchoolsListViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        let serviceManager = NYCServiceManager(NYCSchoolEndPoint(), urlSession)
        viewModel = NYCSchoolsListViewModel(serviceManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testSchoolsListViewModel() async throws {
        // Set mock data
        guard let mockData = TestUtility.schoolsSuccessString.data(using: .utf8) else {
            return
        }
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Fetch schools.
        await viewModel.fetchSchools()
        
        XCTAssertEqual(viewModel.allCities(), ["Manhattan"])
        XCTAssertEqual(viewModel.numberOfCities(), 1)
        XCTAssertEqual(viewModel.numberOfSchools(), 1)
    }

}
