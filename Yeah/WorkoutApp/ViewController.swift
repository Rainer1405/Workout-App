//
//  ViewController.swift
//  WorkoutApp
//
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    var bodSectionArray: [BodSection]!
    var Workouts: [Workout]! = []
    
    let photoCellReuseIdentifier = "photoCellReuseIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .white
        
        let Upp = BodSection(imageName: "Upp")
        let UppBody = BodSection(imageName: "images")
        let Low = BodSection(imageName: "Low")
        let LowBody = BodSection(imageName: "Lower Body")
    
        bodSectionArray = [Upp, UppBody, Low, LowBody]
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
        // Setup Collection View
        // UICollectionViewFlowLayout is used to help organize our cells/items into a grid-pattern
        let layout = UICollectionViewFlowLayout()
        // scrollDirection can be vertical or horizontal
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: photoCellReuseIdentifier)
        collectionView.register(OptionsView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        view.addSubview(collectionView)
        
        setupConstraints()
        
        NetworkManager.getWorkout { (Workouts) in
            self.Workouts = Workouts
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! ButtonCollectionViewCell
        let person = bodSectionArray[indexPath.item]
        cell.configure(for: person)
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bodSectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        headerView.setNeedsUpdateConstraints()
        return headerView
    }
    
    // MARK: - UICollectionViewDelegate (all of these methods are optional)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Run some code upon tapping a cell
        // For example, if we wanted to remove the cell upon tap:
        
       // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! ButtonCollectionViewCell
        let person = bodSectionArray[indexPath.item]
        
        if person.profileImageName == "images" || person.profileImageName == "Upp" {
        let navViewController = UpperViewController()
            navViewController.Workouts = self.Workouts
        // This is how you push the NavViewController onto the navigation stack.
        // navigationController is optional because we don't know whether or not this ViewController
        // was implemented inside a NavigationController or not. (If it wasn't, nothing would happen)
        //
        // Now, NavViewController will be at the top of the navigation stack, and ViewController
        // will be at the bottom of the stack. The order of a stack is last-in-first-out (LIFO),
        // whereas queues are first-in-first-out (FIFO).
        navigationController?.pushViewController(navViewController, animated: true)
            
        } else {
            
            let navViewController = LowerViewController()
            navViewController.Workouts = self.Workouts
            
            // This is how you push the NavViewController onto the navigation stack.
            // navigationController is optional because we don't know whether or not this ViewController
            // was implemented inside a NavigationController or not. (If it wasn't, nothing would happen)
            //
            // Now, NavViewController will be at the top of the navigation stack, and ViewController
            // will be at the bottom of the stack. The order of a stack is last-in-first-out (LIFO),
            // whereas queues are first-in-first-out (FIFO).
            navigationController?.pushViewController(navViewController, animated: true)
            
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // We want || padding IMAGE padding IMAGE padding IMAGE padding ||
        let length = (collectionView.frame.width - padding * 24)
        if bodSectionArray[indexPath.row].profileImageName == "Low" || bodSectionArray[indexPath.row].profileImageName == "Upp" {
            return CGSize(width: length, height: length/2)
        }
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
    
    // MARK: - Action
    @objc func pulledToRefresh() {
        // Place some code here that fetches new data
        // Then call refreshControl.endRefreshing() once we get that data back
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.refreshControl.endRefreshing()
        }
    }
}

