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
        textField.placeholder = "MAIN"
        
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
        
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    @objc func saveTapped() {
        print("save")
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
                                     textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([saveButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
                                     saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)])
        
    }
    
}
