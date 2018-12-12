//
//  InstructionsCollectionViewCell.swift
//  WorkoutApp
//
//  Created by Rainer Sainvil on 12/2/18.
//  Copyright © 2018 Rainer Sainvil. All rights reserved.
//

import UIKit

class InstructionsCollectionViewCell: UICollectionViewCell {
    
    var name: UILabel!
    var main_muscle: UILabel!
    var other_muscle: UILabel!
    var workout_type: UILabel!
    var difficulty: UILabel!
    var picture_url: UIImageView!
    var instructions: UILabel!
    
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
        
        other_muscle = UILabel()
        other_muscle.translatesAutoresizingMaskIntoConstraints = false
        other_muscle.font = UIFont.systemFont(ofSize: 10)
        
        workout_type = UILabel()
        workout_type.translatesAutoresizingMaskIntoConstraints = false
        workout_type.font = UIFont.systemFont(ofSize: 10)
        
        difficulty = UILabel()
        difficulty.translatesAutoresizingMaskIntoConstraints = false
        difficulty.font = UIFont.systemFont(ofSize: 10)
        
        picture_url = UIImageView()
        picture_url.translatesAutoresizingMaskIntoConstraints = false
        picture_url.contentMode = .scaleAspectFit
        
        instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.font = UIFont.systemFont(ofSize: 10)
        
        contentView.addSubview(name)
        contentView.addSubview(main_muscle)
        contentView.addSubview(other_muscle)
        contentView.addSubview(workout_type)
        contentView.addSubview(difficulty)
        contentView.addSubview(picture_url)
        contentView.addSubview(instructions)
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
            other_muscle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            other_muscle.topAnchor.constraint(equalTo: name.bottomAnchor),
            other_muscle.heightAnchor.constraint(equalToConstant: labelHeight)
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
            instructions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            instructions.topAnchor.constraint(equalTo: workout_type.bottomAnchor)
            ])
        
        super.updateConstraints()
    }
    
    func configure(for work: Workout) {
        name.text = work.name
        main_muscle.text = work.main_muscle
        other_muscle.text = work.other_muscle
        workout_type.text = work.workout_type
        difficulty.text = work.difficulty
        let url = URL(string: work.picture_url)
        let data = try? Data(contentsOf: url!)
        picture_url.image = UIImage(data: data!)
        contentView.addSubview(picture_url)
        instructions.text = work.instructions
        
    }
    
}
