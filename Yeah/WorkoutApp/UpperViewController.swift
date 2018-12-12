//
//  UpperViewController.swift
//  WorkoutApp
//
//  Created by Rainer Sainvil on 11/28/18.
//  Copyright © 2018 Rainer Sainvil. All rights reserved.
//

import UIKit

class UpperViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var upBody: [Body]!
    var Workouts: [Workout]!
    
    let cellHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Setting the title of the navigation bar
        title = "Upper Body"
        
        let forearm = Body(name: "Forearm")
        let bicep = Body(name: "Biceps")
        let tricep = Body(name: "Triceps")
        let shoulder = Body(name: "Shoulders")
        let back = Body(name: "Back")
        let chest = Body(name: "Chest")
        let abs = Body(name: "Abs")
        
        upBody = [forearm, bicep, tricep, back, chest, abs, shoulder]
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: ObjectIdentifier, for: indexPath) as! UITableViewCell
        let cell = UITableViewCell()
        let upper = upBody[indexPath.row]
        cell.textLabel?.text = upper.name
        //cell.configure(for: upper.name)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upBody.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let upbody = upBody[indexPath.row]
        let filteredWorkouts = self.Workouts.filter { (Workout) -> Bool in
            return Workout.main_muscle == upbody.name
        }
        let upBodyController = ExercisesViewController()
        upBodyController.setExercises(exercises: filteredWorkouts)
        upBodyController.bodyType = upbody
        self.navigationController?.pushViewController(upBodyController, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

