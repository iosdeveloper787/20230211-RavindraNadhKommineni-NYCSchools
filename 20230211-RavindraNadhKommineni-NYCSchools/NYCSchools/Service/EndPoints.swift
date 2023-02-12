//
//  EndPoint.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
}

protocol EndPoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var appToken: String { get }
}

extension EndPoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "data.cityofnewyork.us/resource"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var header: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var appToken: String {
        return "b3xmAoYe2DSek5CDAla7XpETn"
    }
    
    func getURLString() -> String {
        return "\(scheme)://\(host)\(path)$$app_token=\(appToken)"
    }
}

struct NYCSchoolEndPoint: EndPoint {
    var path: String {
        "/s3k6-pzi2.json?"
    }
}

struct NYCSATScoreEndPoint: EndPoint {
    var path: String {
        "/f9bf-2cp4.json?"
    }
}
