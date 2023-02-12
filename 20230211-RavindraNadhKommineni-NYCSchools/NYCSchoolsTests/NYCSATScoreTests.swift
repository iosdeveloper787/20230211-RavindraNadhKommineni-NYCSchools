//
//  NYCSATScoreTests.swift
//  NYCSchoolsTests
//
//  Created by Ravindra Nadh Kommineni on 12/02/23.
//

import XCTest
@testable import NYCSchools
final class NYCSATScoreTests: XCTestCase {
    var score: SATScore!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        score = NYCSATScore(school_name: "Clinton School Writers & Artists, M.S. 260", num_of_sat_test_takers: "29", dbn: "02M260", sat_critical_reading_avg_score: "355", sat_math_avg_score: "404", sat_writing_avg_score: "363")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testNYCSATScore() throws{
        XCTAssertEqual(score.id, "02M260")
        XCTAssertEqual(score.schoolName, "Clinton School Writers & Artists, M.S. 260")
        XCTAssertEqual(score.studentsCount, "29")
        XCTAssertEqual(score.readingScore, "355")
        XCTAssertEqual(score.mathScore, "404")
        XCTAssertEqual(score.writingScore, "363")
    }
}
