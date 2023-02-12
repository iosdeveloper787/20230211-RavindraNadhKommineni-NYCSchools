//
//  NYCSchool.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//
import Foundation
/**
 Shool protocol which represents the fields which are going to display on SchoolsListViewController
 */
public protocol School: Codable {
    var id: String { get }
    var name: String { get }
    var description: String { get }
    var city: String { get }
    var zip: String { get }
    var address: String { get }
    var availableGrades: String { get }
    var coordinates: [String:String]? { get }
}
/**
    NYCSchool Class is used to decode the School data which is scoming from server.
    It confirms to School protocol to get the fields which are gping to display on SchoolsListViewController
 */
public struct NYCSchool: School {
    let school_name: String
    let overview_paragraph: String
    let dbn: String
    public var city: String
    public var zip: String
    var location: String
    var finalgrades: String?
    
    public var id: String {
        return dbn
    }
    
    public var name: String {
        return school_name
    }
    
    public var description: String {
        return overview_paragraph
    }
    
    public var availableGrades: String {
        guard let grades = finalgrades else { return "Grades info not available." }
        return "Grades offered: \(grades)"
    }
    
    public var address: String {
        return getAddress(location)
    }
    
    public var coordinates: [String : String]? {
        return getCoordinates(location)
    }
}

/*
    Extension methods to grab address and coordinates from the location
 */
extension NYCSchool {
    func getAddress(_ location: String) -> String {
        if (location.split(separator: "(").count > 1) {
            return String(location.split(separator: "(")[0])
        }
        return location
    }
    func getCoordinates(_ location: String) -> [String: String]? {
        var coordinates:[String:String]?
        guard  location.split(separator: "(").count > 1 else {
            return nil
        }
        let afterOpenBracketString = location.split(separator: "(")[1]
        let closedBracketSplitArray = afterOpenBracketString.split(separator: ")")
        let coordinatesString = closedBracketSplitArray[0]
        
        guard coordinatesString.split(separator: ", ").count > 1 else {
            return nil
        }
        let latitude = String(coordinatesString.split(separator: ", ")[0])
        let longitude = String(coordinatesString.split(separator: ", ")[1])
        coordinates = ["latitude": latitude, "longitude": longitude]
        return coordinates
    }
}
