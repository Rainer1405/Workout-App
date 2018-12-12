//
//  ButtonCollectionViewCell.swift
//  WorkoutApp
//
//  Created by Rainer Sainvil on 11/28/18.
//  Copyright © 2018 Rainer Sainvil. All rights reserved.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    var photoImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        contentView.addSubview(photoImageView)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        super.updateConstraints()
    }
    
    func configure(for bodSection: BodSection) {
        photoImageView.image = UIImage(named: bodSection.profileImageName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
