//
//  TableViewCell.swift
//  RealToDo
//
//  Created by Руслан Забиран on 14.04.24.
//

import UIKit

class TaskCell: UITableViewCell {

    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "First Task"
        
        return label
    }()
    
    lazy var additionalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wash the dish"
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "12.04.2024"
        
        return label
    }()
    
    lazy var checkBox: CheckBox = {
        let checkBox = CheckBox()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        return checkBox
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.selectionStyle = .none
        setupView()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            }, completion: { finished in
                UIView.animate(withDuration: 0.2) {
                    self.transform = .identity
                }
            })
        }
        
    }
    
}

private extension TaskCell {
    
    func setupView() {
        
        let hStackView = UIStackView(arrangedSubviews: [dateLabel, additionalLabel])
        hStackView.axis = .horizontal
        hStackView.spacing = 8
        hStackView.alignment = .leading
        hStackView.distribution = .fillProportionally
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hStackView)
        
        let vStackView = UIStackView(arrangedSubviews: [mainLabel, hStackView])
        vStackView.axis = .vertical
        vStackView.spacing = 3
        vStackView.alignment = .leading
        vStackView.distribution = .fillEqually
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vStackView)
        
        NSLayoutConstraint.activate([vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                                     vStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     vStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1)])
        
        contentView.addSubview(checkBox)
        NSLayoutConstraint.activate([checkBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     checkBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
                                     checkBox.heightAnchor.constraint(equalToConstant: 20),
                                     checkBox.widthAnchor.constraint(equalToConstant: 20)])
        
    }
    
    func setupGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapCheckbox))
        checkBox.checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(gesture)
    }
    
    @objc func tapCheckbox() {
        checkBox.toggle()
    }
    
}
