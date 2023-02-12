//
//  TestUtility.swift
//  NYCSchoolsTests
//
//  Created by Ravindra Nadh Kommineni on 12/02/23.
//

import Foundation
struct TestUtility {
    static let schoolsSuccessString = """
            [
                {
                    "school_name":"Clinton School Writers & Artists, M.S. 260",
                    "overview_paragraph":"Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.",
                    "dbn":"02M260",
                    "city":"Manhattan",
                    "zip":"10003",
                    "location":"10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)"
                }
            ]
    """
    static let schoolsEmptyString = """
            []
    """
    static let schoolsInvalidString = """
            [
                {
                    "school":"Clinton School Writers & Artists, M.S. 260",
                    "overview_paragraph":"Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.",
                    "dbn":"02M260",
                    "city":"Manhattan",
                    "zip":"10003",
                    "location":"10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)"
                }
            ]
    """
    static let scoresSuccessString = """
            [
                {
                    "dbn": "02M260",
                    "school_name": "Clinton School Writers & Artists, M.S. 260",
                    "num_of_sat_test_takers": "29",
                    "sat_critical_reading_avg_score": "355",
                    "sat_math_avg_score": "404",
                    "sat_writing_avg_score": "363"
                }
            ]
    """
    static let scoresEmptyString = """
            []
    """
    static let scoresInvalidString = """
            [
                {
                    "id": "02M260",
                    "school_name": "Clinton School Writers & Artists, M.S. 260",
                    "num_of_sat_test_takers": "29",
                    "sat_critical_reading_avg_score": "355",
                    "sat_math_avg_score": "404",
                    "sat_writing_avg_score": "363"
                }
            ]
    """
}
