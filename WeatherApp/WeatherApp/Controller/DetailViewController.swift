//
//  ViewController.swift
//  WeatherApp
//
//  Created by beshssg on 19.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - UIProperties:
    var weatherModel: WeatherModel?
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 20
        return sv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .red
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        autoLayout()
    }
    
    // MARK: - Methods:
    private func autoLayout() {
        view.addSubview(stackView)
        [nameLabel, statusLabel, degreeLabel].forEach { stackView.addArrangedSubview($0) }
        [stackView, nameLabel, statusLabel, degreeLabel].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints = [
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Models > DetailViewController:
    func configureData(model: WeatherModel?) {
        if let data = model {
            nameLabel.text = data.name
            statusLabel.text = data.conditionString
            degreeLabel.text = "\(String(describing: data.temperature))°C"
        }
    }
}

