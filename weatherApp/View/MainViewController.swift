//
//  MainViewController.swift
//  weatherApp
//
//  Created by Мой Macbook on 19.03.2024.
//

import SnapKit
import Combine
import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var cityTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = Constants.city
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(textFieldShouldReturn), for: .editingDidEndOnExit)
        return textField
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textAlignment = .center
        return label
    }()
    
    private var pressureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()
    }
    
    //MARK: - Functions
    
    private func setupViews() {
        view.backgroundColor = .white
        [cityTextField, temperatureLabel, pressureLabel].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        temperatureLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        cityTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.inset)
            make.bottom.equalTo(temperatureLabel.snp.top).offset(-Constants.inset)
            make.height.equalTo(Constants.inset)
        }
        
        pressureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(Constants.inset)
        }
    }
    
    //MARK: - @objc Functions
    
    @objc private func textFieldShouldReturn() {
        view.endEditing(true)
    }
}

private enum Constants {
    static let fontSize: CGFloat = 40
    static let inset: CGFloat = 50
    static let city = "city"
    static let indexPressure: CGFloat = 0.75
}
