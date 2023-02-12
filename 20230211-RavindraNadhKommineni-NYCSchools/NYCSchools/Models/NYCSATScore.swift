//
//  NYCSATScore.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//
import Foundation
/**
 SATScore  protocol which represents the fields which are going to display on SchoolDetailsViewController
 */
public protocol SATScore: Codable {
    var id: String { get }
    var schoolName: String { get }
    var studentsCount: String { get }
    var readingScore: String { get }
    var mathScore: String { get }
    var writingScore: String { get }
}

/**
    NYCSATScore Class is used to decode the SATScore data which is scoming from server.
    It confirms to SATScore protocol to get the fields which are gping to display on SchoolDetailsViewController
 */
public struct NYCSATScore: SATScore {
    let school_name: String
    let num_of_sat_test_takers: String
    let dbn: String
    let sat_critical_reading_avg_score: String
    let sat_math_avg_score: String
    let sat_writing_avg_score: String
    
    
    public var id: String {
        return dbn
    }
    
    public var schoolName: String {
        return school_name
    }
    
    public var studentsCount: String {
        return num_of_sat_test_takers
    }
    
    public var readingScore: String {
        return sat_critical_reading_avg_score
    }
    
    public var mathScore: String {
        return sat_math_avg_score
    }
    
    public var writingScore: String {
        return sat_writing_avg_score
    }
}
