//
//  SchoolsListHeaderView.swift
//  NYCSchools
//
//  Created by Ravindra Nadh Kommineni on 11/02/23.
//

import UIKit
/**
 Schools table view header, to display city name.
 */
class SchoolsListHeaderView: UITableViewHeaderFooterView {
    
        lazy var titleLabel: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "ChalkboardSE-Bold", size: 25)
            label.textColor = UIColor.black
            label.textAlignment = .left
            return label
        }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUpInterface()
    }
    
    private func setUpInterface() {
        contentView.backgroundColor = .white
        
                contentView.addSubview(titleLabel)
        
                NSLayoutConstraint.activate([
                    titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
                    titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                    titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                ])
    }
    
    func setUp(_ header: String) {
        titleLabel.text = header
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
    }
}
