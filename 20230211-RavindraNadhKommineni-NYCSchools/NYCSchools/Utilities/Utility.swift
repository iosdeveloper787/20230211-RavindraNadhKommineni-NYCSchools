//
//  Utility.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//

import Foundation
import UIKit
struct AppUtility {
    static func setNavigationBarAppearance(_ navigationItem: UINavigationItem) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 78/255, green: 172/255, blue: 214/255, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
        navigationItem.compactAppearance?.buttonAppearance = buttonAppearance
    }
}
