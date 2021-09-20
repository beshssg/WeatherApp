//
//  ListTableViewCell.swift
//  WeatherApp
//
//  Created by beshssg on 20.09.2021.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    // MARK: - UIProperties:
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 16
        return sv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            autoLayout()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            autoLayout()
        }
    
    // MARK: - Methods:
    private func autoLayout() {
        contentView.addSubview(stackView)
        [nameLabel, statusLabel, degreeLabel].forEach { stackView.addArrangedSubview($0) }
        [stackView, nameLabel, statusLabel, degreeLabel].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            statusLabel.widthAnchor.constraint(equalToConstant: 100),
            
            degreeLabel.widthAnchor.constraint(equalToConstant: 100),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Models weather:
    func labelsConfigure(weather: WeatherModel) {
        nameLabel.text = weather.name
        statusLabel.text = weather.conditionString
        degreeLabel.text = "\(String(weather.temperature))°C"
    }
}
