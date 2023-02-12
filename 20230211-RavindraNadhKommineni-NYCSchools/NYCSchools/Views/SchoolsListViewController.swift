//
//  SchoolsListViewController.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//

import UIKit

class SchoolsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let schoolsListViewModel = NYCSchoolsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "NYC Schools"
        
        AppUtility.setNavigationBarAppearance(navigationItem)
        tableView.rowHeight =  UITableView.automaticDimension
        tableView.register(SchoolsListHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: SchoolsListHeaderView.self))
        
        prepareData()
    }
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ChalkboardSE-Bold", size: 25)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Prepare Data
    
    func prepareData() {
        // Create an async task to fetch schools data,
        // and takes appropriate action when fetch completes.
        Task {
            // Optionally, show a loading indicator while data is loading.
            showMessage("Loading...")
            
            // Fetch schools.
            await schoolsListViewModel.fetchSchools()
            
            // Act on the school data fetched.
            switch schoolsListViewModel.dataLoadingState {
                case .loaded:
                    setUpSchoolsTableView()
                case .failedToLoad:
                    // Provide retry option here.
                    showMessage("Failed to load schools data.")
                case .noDataFound:
                    showMessage("No data found.")
                default:
                    print("Do nothing")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "showSchoolDetails" {
            guard let schoolDetailsViewController = segue.destination as? SchoolDetailsViewController, let indexPath = tableView.indexPathForSelectedRow, let school: NYCSchool = schoolsListViewModel.school(indexPath.row, cityIndex: indexPath.section) else {
                return
            }
            schoolDetailsViewController.setUp(school)
        }
    }
    
    //MARK: - Interface
    
    private func setUpSchoolsTableView() {
        infoLabel.isHidden = true
        
        if (tableView.superview == nil) {
            view.addSubview(tableView)
            
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
            ])
        }
        
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func setUpInfoLabel() {
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func showMessage(_ message: String) {
        if (infoLabel.superview == nil) {
            setUpInfoLabel()
        }
        
        tableView.isHidden = true
        infoLabel.isHidden = false
        infoLabel.text = message
    }
}

/**
 Schools table view's delegate and data source. Displays all available schools grouped by city.
 A cool feature would be to search school by city / name / zip etc.,
 */
extension SchoolsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: SchoolsListHeaderView.self)) as? SchoolsListHeaderView else { return nil }
        
        headerView.setUp(schoolsListViewModel.allCities()[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return schoolsListViewModel.numberOfCities()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolsListViewModel.numberOfSchoolsInCity(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let school: NYCSchool = schoolsListViewModel.school(indexPath.row, cityIndex: indexPath.section),
              let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SchoolsListTableViewCell.self), for: indexPath) as? SchoolsListTableViewCell else { return UITableViewCell() }
        
        cell.setUp(school)
        return cell
    }
}
