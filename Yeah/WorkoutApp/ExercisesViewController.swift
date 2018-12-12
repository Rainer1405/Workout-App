//
//  UpperExercisesViewController.swift
//  WorkoutApp
//
//  Created by Trey Burrell on 11/30/18.
//  Copyright © 2018 Rainer Sainvil. All rights reserved.
//

import UIKit

class ExercisesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! WorkoutCollectionViewCell
        let exercise = exercises[indexPath.item]
        let isLast = indexPath.row != exercises.count-1
        
        cell.configure(for: exercise, isLast: isLast)
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width - padding * 8)
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Run some code upon tapping a cell
        // For example, if we wanted to remove the cell upon tap:
        
        // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! ButtonCollectionViewCell
        //let person = exercises[indexPath.item]
        
        
        
            let navViewController = InstructionsViewController()
            navViewController.Workouts = self.exercises
            // This is how you push the NavViewController onto the navigation stack.
            // navigationController is optional because we don't know whether or not this ViewController
            // was implemented inside a NavigationController or not. (If it wasn't, nothing would happen)
            //
            // Now, NavViewController will be at the top of the navigation stack, and ViewController
            // will be at the bottom of the stack. The order of a stack is last-in-first-out (LIFO),
            // whereas queues are first-in-first-out (FIFO).
            navViewController.myindex = indexPath.row
            navigationController?.pushViewController(navViewController, animated: true)
        
        
        
//        let CollectionViewCell = InstructionsCollectionViewCell()
//        
//        navigationController?.pus
            
       
    }
    
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    let photoCellReuseIdentifier = "photoCellReuseIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifier"
    
    

    var collectView: UICollectionView!
    var refreshControl: UIRefreshControl!
    var bodyType: Body!
    var exercises: [Workout]! = []



    override func viewDidLoad() {
        super.viewDidLoad()
        
        let padding: CGFloat = 8


        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        collectView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectView.translatesAutoresizingMaskIntoConstraints = false
        collectView.backgroundColor = .white
        collectView.dataSource = self
        collectView.delegate = self
        collectView.refreshControl = refreshControl
        collectView.register(WorkoutCollectionViewCell.self, forCellWithReuseIdentifier: photoCellReuseIdentifier)
        view.addSubview(collectView)

        setupConstraints()

    }
    
    func setExercises(exercises: [Workout]) {
        self.exercises = exercises
//        self.collectView.reloadData()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])

    }
    
    func getWorkouts() {
        NetworkManager.getWorkout { (work) in
            self.exercises = work
            self.collectView.reloadData()
        }
    }
    
    func getImageFromURLString(urlString: String) -> UIImage? {
        if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
    
    


}
