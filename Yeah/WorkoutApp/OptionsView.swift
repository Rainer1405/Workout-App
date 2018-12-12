//
//  OptionsView.swift
//  WorkoutApp
//
//  Created by Rainer Sainvil on 11/28/18.
//  Copyright © 2018 Rainer Sainvil. All rights reserved.
//

import UIKit

class OptionsView: UICollectionReusableView {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose Body Section"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        addSubview(label)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
