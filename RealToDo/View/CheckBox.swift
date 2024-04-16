//
//  CheckBox.swift
//  RealToDo
//
//  Created by Руслан Забиран on 16.04.24.
//

import UIKit

class CheckBox: UIView {

    var isChecked: Bool = false
    let checkBox = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func toggle() {
        self.isChecked = !isChecked
            
        if isChecked {
            checkBox.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            checkBox.image = UIImage(systemName: "circle")
        }
        
    }
    
    private func createSubviews() {
        checkBox.image = UIImage(systemName: "circle")
        checkBox.contentMode = .scaleAspectFit
        checkBox.tintColor = .systemBlue
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(checkBox)
        NSLayoutConstraint.activate([checkBox.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     checkBox.topAnchor.constraint(equalTo: self.topAnchor)])
        
    }
    
}
