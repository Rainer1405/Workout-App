//
//  InstructionsViewController.swift
//  
//
//  Created by Rainer Sainvil on 12/2/18.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    var name: UILabel!
    var main_muscle: UILabel!
    var other_muscle: UILabel!
    var workout_type: UILabel!
    var difficulty: UILabel!
    var picture_url: UIImageView!
    var instructions: UILabel!
    var refreshControl: UIRefreshControl!
    var bodSectionArray: [BodSection]!
    var Workouts: [Workout]! = []
    var myindex: Int!
    
    let photoCellReuseIdentifier = "photoCellReuseIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    let labelHeight: CGFloat = 16
    let photoImageWidth: CGFloat = 120
    let photoImageHeight: CGFloat = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Excercise"
        view.backgroundColor = UIColor.lightGray
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
        // Setup Collection View
        // UICollectionViewFlowLayout is used to help organize our cells/items into a grid-pattern
        let layout = UICollectionViewFlowLayout()
        // scrollDirection can be vertical or horizontal
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        name = UILabel()
        name.text = Workouts[myindex].name
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 14)
        name.numberOfLines = 0
        
        main_muscle = UILabel()
        main_muscle.text = "Main Muscle: " + Workouts[myindex].main_muscle
        main_muscle.translatesAutoresizingMaskIntoConstraints = false
        main_muscle.font = UIFont.systemFont(ofSize: 10)
        
        other_muscle = UILabel()
        other_muscle.text = "Other Muscle: " + Workouts[myindex].other_muscle
        other_muscle.translatesAutoresizingMaskIntoConstraints = false
        other_muscle.font = UIFont.systemFont(ofSize: 10)
        
        workout_type = UILabel()
        workout_type.text = "Workout Type:" + Workouts[myindex].workout_type
        workout_type.translatesAutoresizingMaskIntoConstraints = false
        workout_type.font = UIFont.systemFont(ofSize: 10)
        
        difficulty = UILabel()
        difficulty.text = "Difficulty:" + Workouts[myindex].difficulty
        difficulty.translatesAutoresizingMaskIntoConstraints = false
        difficulty.font = UIFont.systemFont(ofSize: 10)
        
        picture_url = UIImageView()
        picture_url.image = getImageFromURLString(urlString: Workouts[myindex].picture_url)
        picture_url.translatesAutoresizingMaskIntoConstraints = false
        picture_url.contentMode = .scaleAspectFit
        
        instructions = UILabel()
        instructions.text = "Instructions:" + Workouts[myindex].instructions
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.font = UIFont.systemFont(ofSize: 12)
        instructions.contentMode = .scaleToFill
        instructions.numberOfLines = 0
        
        view.addSubview(name)
        view.addSubview(main_muscle)
        view.addSubview(other_muscle)
        view.addSubview(workout_type)
        view.addSubview(difficulty)
        view.addSubview(picture_url)
        view.addSubview(instructions)
        
        setupConstraints()
        
        NetworkManager.getWorkout { (Workouts) in
            self.Workouts = Workouts
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            name.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            ])
        
        NSLayoutConstraint.activate([
            main_muscle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            main_muscle.topAnchor.constraint(equalTo: name.bottomAnchor),
            main_muscle.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            other_muscle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            other_muscle.topAnchor.constraint(equalTo: main_muscle.bottomAnchor),
            other_muscle.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            workout_type.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            workout_type.topAnchor.constraint(equalTo: other_muscle.bottomAnchor),
            workout_type.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            difficulty.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            difficulty.topAnchor.constraint(equalTo: workout_type.bottomAnchor),
            difficulty.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            picture_url.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: padding),
            picture_url.topAnchor.constraint(equalTo: difficulty.bottomAnchor, constant: padding),
            picture_url.heightAnchor.constraint(equalToConstant: photoImageHeight),
            picture_url.widthAnchor.constraint(equalToConstant: photoImageWidth)
            ])
        
        NSLayoutConstraint.activate([
            instructions.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            instructions.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            instructions.topAnchor.constraint(equalTo: picture_url.bottomAnchor)
            
            ])
    
    }
    func getImageFromURLString(urlString: String) -> UIImage? {
        if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
    
    // MARK: - UICollectionViewDataSource
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! InstructionsCollectionViewCell
//        let person = Workouts[indexPath.item]
//        cell.configure(for: person)
//        cell.setNeedsUpdateConstraints()
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return bodSectionArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
//        headerView.setNeedsUpdateConstraints()
//        return headerView
//    }
//
//    // MARK: - UICollectionViewDelegate (all of these methods are optional)
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // Run some code upon tapping a cell
//        // For example, if we wanted to remove the cell upon tap:
//
//        // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! ButtonCollectionViewCell
//        let person = bodSectionArray[indexPath.item]
//
//        if person.profileImageName == "images" {
//            let navViewController = UpperViewController()
//            navViewController.Workouts = self.Workouts
//            // This is how you push the NavViewController onto the navigation stack.
//            // navigationController is optional because we don't know whether or not this ViewController
//            // was implemented inside a NavigationController or not. (If it wasn't, nothing would happen)
//            //
//            // Now, NavViewController will be at the top of the navigation stack, and ViewController
//            // will be at the bottom of the stack. The order of a stack is last-in-first-out (LIFO),
//            // whereas queues are first-in-first-out (FIFO).
//            navigationController?.pushViewController(navViewController, animated: true)
//
//        } else {
//
//            let navViewController = LowerViewController()
//            navViewController.Workouts = self.Workouts
//
//            // This is how you push the NavViewController onto the navigation stack.
//            // navigationController is optional because we don't know whether or not this ViewController
//            // was implemented inside a NavigationController or not. (If it wasn't, nothing would happen)
//            //
//            // Now, NavViewController will be at the top of the navigation stack, and ViewController
//            // will be at the bottom of the stack. The order of a stack is last-in-first-out (LIFO),
//            // whereas queues are first-in-first-out (FIFO).
//            navigationController?.pushViewController(navViewController, animated: true)
//
//        }
//    }
//
//    // MARK: - UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // We want || padding IMAGE padding IMAGE padding IMAGE padding ||
//        let length = (collectionView.frame.width - padding * 8)
//        return CGSize(width: length, height: length)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: headerHeight)
//    }
//
    // MARK: - Action
    @objc func pulledToRefresh() {
        // Place some code here that fetches new data
        // Then call refreshControl.endRefreshing() once we get that data back
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.refreshControl.endRefreshing()
        }
        
        
    }
}
