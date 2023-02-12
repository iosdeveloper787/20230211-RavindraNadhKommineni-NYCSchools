//
//  NYCServiceManager.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//

import Foundation
/**
 Possible  errors.
 */
public enum ServiceError: Error, Equatable {
    case invalidURL(url : String)
    case failedToFetchData
    case failedWithErrorCode(code: Int)
    case failedToDecodeResponse
}

/**
 Loading states of service. Based on this we will show or hide activity indicator and show error message to the user if failed to load service.
 */
enum ServiceLoadingState {
    case none
    case loading
    case failedToLoad
    case noDataFound
    case loaded
}
/**
 Protocol to define all API calls.
 */
public protocol ServiceManager {
    func getSchools<T: School>(_ params: [String: String]) async throws -> [T]
    func getSATScores<T: SATScore>(_ params: [String : String]) async throws -> [T]
}

/**
    A NYC service manager, to provide NYC schools data and SAT scores data of corresponding school.
 */
public struct NYCServiceManager: ServiceManager {
    
    // The URLSession instance used to fetch data.
    let urlSession: URLSession
    
    // The EndPoint to provider URL and the headers.
    let endPoint: EndPoint
    
    init(_ endPoint: EndPoint, _ session: URLSession = URLSession.shared) {
        urlSession = session
        self.endPoint = endPoint
    }
    
    /**
     Construct the final URL with given params.
     */
    func constructUrl(_ baseUrl: String,
                      params:[String : String]) -> String {
        var finalUrl = baseUrl
        
        // Caller to ensure valid key, value pair is passed.
        for (key, value) in params {
            finalUrl = (finalUrl + "&" + key + "=" + value)
        }
        return finalUrl
    }
    
    func getResponse<T>(for urlString: String) async throws -> [T] where T : Decodable {
        guard let url = URL(string: urlString) else {
            // Logging for debug purposes.
            print("Invalid URL:\(urlString)")
            throw ServiceError.invalidURL(url: urlString)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.header
        // Make a request to get data from the prepared url
        var dataResponse: (Data, URLResponse)
        do {
            dataResponse = try await urlSession.data(for: request)
        } catch {
            print("\(urlString) API failed to fetch data")
            throw ServiceError.failedToFetchData
        }
        
        // Validate the response. As per API docs, status code 200 is success response.
        // Optionally, handle other status codes.
        // For example, 202 is request in-progress, retry mechanism can be implemented.
        let statusCode = (dataResponse.1 as? HTTPURLResponse)?.statusCode
        guard (statusCode == 200) else {
            print("\(urlString) API failed with error code : \(String(describing: statusCode))")
            throw ServiceError.failedWithErrorCode(code: statusCode ?? 0)
        }
        
        // Return decoded results.
        var decodedResults = [T]()
        do {
            decodedResults = try JSONDecoder().decode([T].self, from: dataResponse.0)
        } catch {
            print("\(urlString) API failed to decode data : \(error)")
            throw ServiceError.failedToDecodeResponse
        }
        
        return decodedResults
    }
    
    /**
         Get NYC schools data.
     */
    public func getSchools<T>(_ params: [String : String]) async throws -> [T] where T : School {
        // Prepare fianl url with url and query params if any.
        let urlString = constructUrl(endPoint.getURLString(), params: params)
        
        return try await getResponse(for: urlString)
    }
    
    /**
        Get SAT Scores of corresponding school
     */
    public func getSATScores<T>(_ params: [String : String]) async throws -> [T] where T : SATScore {
        // Prepare fianl url, with url and query params if any.
        let urlString = constructUrl(endPoint.getURLString(), params: params)
        
        return try await getResponse(for: urlString)
    }
}
