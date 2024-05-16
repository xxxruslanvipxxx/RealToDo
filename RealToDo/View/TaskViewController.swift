//
//  NewTaskViewController.swift
//  RealToDo
//
//  Created by Руслан Забиран on 17.04.24.
//

import UIKit

class TaskViewController: UIViewController {
    
    var viewModel: TaskViewModelProtocol?
    private var safeArea: UILayoutGuide!
    
    //MARK: UI variables
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Enter name:"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var mainTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.addTarget(self, action: #selector(mainTextChanged), for: .editingChanged)
        textField.accessibilityIdentifier = "MainTextField"
        
        return textField
    }()
    
    private lazy var textViewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Enter additional text:"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        textView.accessibilityIdentifier = "AdditionalTextView"
        
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isEnabled = true
        button.alpha = 1
        button.accessibilityIdentifier = "SaveButton"
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
        setupDismissKeyboard()
        fillTheFields()
        viewModel?.setButtonState()
    }
    
    //MARK: Bindings
    
    func bindViewModel() {
        
        viewModel?.textFieldIsEmpty.bind({ isEmpty in
            self.setMainTextFieldState(isEmpty: isEmpty)
            self.setButtonState(isEnabled: !isEmpty)
        })
        viewModel?.buttonIsEnabled?.bind({ isEnabled in
            self.setButtonState(isEnabled: isEnabled)
        })
    
        
    }
    
    private func setMainTextFieldState(isEmpty: Bool) { // bug with disabled button
        if isEmpty {
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            self.mainTextField.layer.borderWidth = 1
            self.mainTextField.layer.cornerRadius = 5
            // set empty textfield placeholder
            self.mainTextField.attributedPlaceholder = NSAttributedString(
                string: "This field is required",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
            )
        } else {
            self.mainTextField.layer.borderColor = UIColor.black.cgColor
            self.mainTextField.layer.borderWidth = 0
        }
    }
    
    private func setButtonState(isEnabled: Bool) {
        if isEnabled {
            self.saveButton.isEnabled = true
            self.saveButton.alpha = 1
        } else {
            self.saveButton.isEnabled = false
            self.saveButton.alpha = 0.5
        }
    }
    
    private func fillTheFields() {
        guard let mainText = viewModel?.task?.mainText else { return }
        guard let additionalText = viewModel?.task?.additionalText else { return }
        
        mainTextField.text = mainText
        textView.text = additionalText
    }
    
    //MARK: Objc methods
    
    @objc func mainTextChanged() {
        if let text = mainTextField.text {
            viewModel?.setTextFieldState(text: text)
        }
    }
    
    @objc func saveTapped() {
        guard let mainText = mainTextField.text else { return }
        let additionalText = textView.text
        
        viewModel?.saveTaskWith(mainText: mainText, additionalText: additionalText)
        viewModel?.goToListVC()
        
    }

}

//MARK: - UITextViewDelegate

//MARK: - UITextFieldDelegate

extension TaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Dismiss keyboard with tap

extension TaskViewController {
    
    private func setupDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}

//MARK: - UI Setup

extension TaskViewController {
    
    func setupViews() {
        
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainLabel)
        
        NSLayoutConstraint.activate([mainLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
                                     mainLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
                                     mainLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)])
        
        mainTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainTextField)
        
        NSLayoutConstraint.activate([mainTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8),
                                     mainTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
                                     mainTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)])
        
        textViewLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textViewLabel)
        
        NSLayoutConstraint.activate([textViewLabel.topAnchor.constraint(equalTo: mainTextField.bottomAnchor, constant: 16),
                                     textViewLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
                                     textViewLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)])
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([textView.topAnchor.constraint(equalTo: textViewLabel.bottomAnchor, constant: 8),
                                     textView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
                                     textView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
                                     textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([saveButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
                                     saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)])
        
    }
    
}
