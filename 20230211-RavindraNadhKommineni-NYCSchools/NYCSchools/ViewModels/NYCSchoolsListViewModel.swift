//
//  NYCSchoolsListViewModel.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//

import Foundation
/**
 A schools list view model protocol defining required methods to render school info.
 */
protocol SchoolsListViewModel {
    /**
     Fetches all schools.
     */
    func fetchSchools() async
    
    /**
     Returns list of city names, where schools are available.
     */
    func allCities() -> [String]
    
    /**
     Returns number of cities, where schools are available.
     */
    func numberOfCities() -> Int
    
    /**
     Returns school at a given index, in the city at given index.
     */
    func school<T: School>(_ at: Int, cityIndex: Int) -> T?
    
    /**
     Return number of schools
     */
    func numberOfSchools() -> Int
    
    /**
     Return school at a given index if exists
     */
    func school<T: School>(_ at: Int) -> T?
    
    /**
     Return school for given unique identifier if exists
     */
    func school<T: School>(_ id: String) -> T?
}

/**
    A NYC schools list view model implementing schools list view model protocol.
    This prototype fetches all schools.
 */
class NYCSchoolsListViewModel: SchoolsListViewModel {
    private var serviceManager: NYCServiceManager
    private var schools = [NYCSchool]()
    var dataLoadingState = ServiceLoadingState.none
    private var schoolsByCity = [String: [NYCSchool]]()
    private var cities = [String]()
    
    init(_ serviceManger: NYCServiceManager = NYCServiceManager(NYCSchoolEndPoint())) {
        self.serviceManager = serviceManger
    }
    
    /**
     Make a network request to fetch schools data.
     */
    func fetchSchools() async {
        dataLoadingState = ServiceLoadingState.none
        
        do {
            dataLoadingState = ServiceLoadingState.loading
            let allSchools: [NYCSchool] = try await serviceManager.getSchools([:])
            
            // Prepare required data.
            schools = allSchools
            schoolsByCity = Dictionary(grouping: schools, by: { $0.city })
            cities = Array(schoolsByCity.keys).sorted()
            
            // Update loading state accordingly.
            dataLoadingState = (schools.count > 0 ?
                                ServiceLoadingState.loaded :
                                    ServiceLoadingState.noDataFound)
        }
        catch {
            dataLoadingState = ServiceLoadingState.failedToLoad
            schools.removeAll()
        }
    }
    
    func allCities() -> [String] {
        return cities
    }
    
    func numberOfCities() -> Int {
        return cities.count
    }
    
    func numberOfSchoolsInCity(_ index: Int) -> Int {
        guard index < cities.count else { return 0 }
        return schoolsByCity[cities[index]]?.count ?? 0
    }
    
    func school<T>(_ at: Int, cityIndex: Int ) -> T? where T : School {
        guard cityIndex < cities.count else { return nil }
        guard let citySchools = schoolsByCity[cities[cityIndex]] else { return nil }
        return citySchools[at] as? T
    }
    
    /**
     Not used in the app now, but nice to have APIs.s
     */
    func numberOfSchools() -> Int {
        return schools.count
    }
    
    func school<T>(_ at: Int) -> T? where T : School {
        guard at < schools.count else { return nil }
        return schools[at] as? T
    }
    
    func school<T>(_ id: String) -> T? where T : School {
        return schools.filter({ $0.id == id }) as? T
    }
}
