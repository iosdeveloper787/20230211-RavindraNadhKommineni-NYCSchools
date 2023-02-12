//
//  SchoolsListTableViewCell.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//

import Foundation
import UIKit

/**
    Schools list table view cell, displaying basic school info.
 */
class SchoolsListTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gradesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func addBorder() {
        containerView.layer.cornerRadius = 5.0
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
//    lazy var containerView: UIView = {
//        let view = UIView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor.white
//        view.layer.cornerRadius = 5.0
//        view.layer.borderWidth = 0.5
//        view.layer.borderColor = UIColor.lightGray.cgColor
//        view.layer.shadowRadius = 2
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowOffset = CGSize(width: 0, height: 1)
//        return view
//    }()
//
//    lazy var stackView: UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.spacing = 4
//        stack.distribution = .equalSpacing
//        return stack
//    }()
//
//    lazy var titleLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Charter-Bold", size: 15)
//        label.textColor = UIColor.black
//        label.textAlignment = .left
//        return label
//    }()
//
//    lazy var descriptionLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Helvetica", size: 13)
//        label.numberOfLines = 2
//        label.lineBreakMode = .byWordWrapping
//        label.textColor = UIColor.black
//        label.textAlignment = .left
//        return label
//    }()
//
//    lazy var availableGradesLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Helvetica", size: 11)
//        label.textColor = UIColor.gray
//        label.textAlignment = .left
//        return label
//    }()
//
//    lazy var addressLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Helvetica", size: 13)
//        label.textColor = UIColor.black
//        label.textAlignment = .left
//        return label
//    }()
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
//
////        setUpInterface()
//    }
//
//    private func setUpInterface() {
//        contentView.backgroundColor = .white
//
//        contentView.addSubview(containerView)
//        containerView.addSubview(stackView)
//        stackView.addArrangedSubview(titleLabel)
//        stackView.addArrangedSubview(descriptionLabel)
//        stackView.addArrangedSubview(availableGradesLabel)
//        stackView.addArrangedSubview(addressLabel)
//
//        NSLayoutConstraint.activate([
//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
//            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
//            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
//            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
//            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
//        ])
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override func prepareForReuse() {
//        titleLabel.text = nil
//        descriptionLabel.text = nil
//        addressLabel.text = nil
//        gradesLabel.text = nil
//
//        self.layoutSubviews()
//    }
    
    func setUp(_ school: School) {
        addBorder()
        titleLabel.text = school.name
        descriptionLabel.text = school.description
        addressLabel.text = school.address
        gradesLabel.text = school.availableGrades
    }
}



