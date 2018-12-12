//
//  WorkoutCollectionViewCell.swift
//  WorkoutApp
//
//  Created by Trey Burrell on 12/2/18.
//  Copyright © 2018 Rainer Sainvil. All rights reserved.
//

import UIKit

class WorkoutCollectionViewCell: UICollectionViewCell {
    var name: UILabel!
    var main_muscle: UILabel!
    var workout_type: UILabel!
    var difficulty: UILabel!
    var picture_url: UIImageView!
    var line: UIView!
    
    let padding: CGFloat = 10
    let labelHeight: CGFloat = 16
    let photoImageWidth: CGFloat = 120
    let photoImageHeight: CGFloat = 120
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 14)
        name.numberOfLines = 0
        
        main_muscle = UILabel()
        main_muscle.translatesAutoresizingMaskIntoConstraints = false
        main_muscle.font = UIFont.systemFont(ofSize: 10)
        
        workout_type = UILabel()
        workout_type.translatesAutoresizingMaskIntoConstraints = false
        workout_type.font = UIFont.systemFont(ofSize: 10)
        
        difficulty = UILabel()
        difficulty.translatesAutoresizingMaskIntoConstraints = false
        difficulty.font = UIFont.systemFont(ofSize: 10)
        
        picture_url = UIImageView()
        picture_url.translatesAutoresizingMaskIntoConstraints = false
        picture_url.contentMode = .scaleAspectFit
        
        line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        
        contentView.addSubview(name)
        contentView.addSubview(main_muscle)
        contentView.addSubview(workout_type)
        contentView.addSubview(difficulty)
        contentView.addSubview(picture_url)
        contentView.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            ])
        
        NSLayoutConstraint.activate([
            main_muscle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            main_muscle.topAnchor.constraint(equalTo: name.bottomAnchor),
            main_muscle.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            workout_type.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            workout_type.topAnchor.constraint(equalTo: main_muscle.bottomAnchor),
            workout_type.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            difficulty.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            difficulty.topAnchor.constraint(equalTo: workout_type.bottomAnchor),
            difficulty.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            picture_url.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            picture_url.topAnchor.constraint(equalTo: difficulty.bottomAnchor, constant: padding),
            picture_url.heightAnchor.constraint(equalToConstant: photoImageHeight),
            picture_url.widthAnchor.constraint(equalToConstant: photoImageWidth)
            ])
        
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.topAnchor.constraint(equalTo: picture_url.bottomAnchor)
            ])
        
        super.updateConstraints()
    }
    
    func configure(for work: Workout, isLast: Bool) {
        name.text = work.name
        main_muscle.text = work.main_muscle
        workout_type.text = work.workout_type
        difficulty.text = work.difficulty
        let url = URL(string: work.picture_url)
        let data = try? Data(contentsOf: url!)
        picture_url.image = UIImage(data: data!)
        contentView.addSubview(picture_url)
        
    }
    
}

