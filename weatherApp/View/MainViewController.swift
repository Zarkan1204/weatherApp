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
    
    let viewModel = ViewModel()
    var cancellable: Set<AnyCancellable> = []
    
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
        cityTextField.text = viewModel.city
        setupViews()
        setupLayout()
        binding()
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
    
    private func binding() {
        cityTextField.textPublisher
            .assign(to: \.city, on: viewModel)
            .store(in: &cancellable)
        
        viewModel.$currentWeather
            .sink(receiveValue: {[weak self] currentWeather in
                self?.temperatureLabel.text = currentWeather.main?.temp != nil ? "\(Int((currentWeather.main?.temp ?? .zero))) ºC" : Constants.warning})
            .store(in: &cancellable)
        
        viewModel.$currentWeather
            .sink { [weak self] currentWeather in
                self?.pressureLabel.text = currentWeather.main?.pressure != nil ?
                "\(Int(Double((currentWeather.main?.pressure ?? .zero)) * Constants.indexPressure))mm" : Constants.error}
            .store(in: &cancellable)
        
    }
    
    //MARK: - @objc Functions
    
    @objc private func textFieldShouldReturn() {
        view.endEditing(true)
    }
}

//MARK: - UISearchTextField

extension UISearchTextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}

private enum Constants {
    static let fontSize: CGFloat = 40
    static let inset: CGFloat = 50
    static let city = "city"
    static let indexPressure: CGFloat = 0.75
    static let error = "not found"
    static let warning = "incorrect city name"
}
