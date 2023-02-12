//
//  NYCSchoolDetailsViewModel.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//

import Foundation
/**
 A schools list view model protocol defining required methods to render school info.
 */
protocol SchoolDetailsViewModel {
    func fetchSchooolSATScores(_ school: School) async
}
/**
 A NYC school details view model implementing school details view model protocol.
 This prototype fetches SAT scores of a school.
 */
class NYCSchoolDetailsViewModel: SchoolDetailsViewModel {
    private var serviceManager: NYCServiceManager
    var dataLoadingState = ServiceLoadingState.none
    var scores = [NYCSATScore]()
    
    init(_ serviceManger: NYCServiceManager = NYCServiceManager(NYCSATScoreEndPoint())) {
        self.serviceManager = serviceManger
    }
    
    func fetchSchooolSATScores(_ school: School) async {
        
        do {
            // Get SAT scores for the given school.
            let fetchedScores : [NYCSATScore] = try await serviceManager.getSATScores(["dbn": school.id])
            
            scores = fetchedScores
            dataLoadingState = fetchedScores.isEmpty ? .noDataFound : .loaded
        } catch {
            dataLoadingState = .failedToLoad
        }
    }
}
