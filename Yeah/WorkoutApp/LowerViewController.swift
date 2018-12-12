//
//  LowerViewController.swift
//  WorkoutApp
//
//  Created by Rainer Sainvil on 11/28/18.
//  Copyright © 2018 Rainer Sainvil. All rights reserved.
//

import UIKit

class LowerViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var lowBody: [Body]!
    var Workouts: [Workout]!
    
    let cellHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Setting the title of the navigation bar
        title = "Lower Body"
        
        let upleg = Body(name: "Upper Legs")
        let lowleg = Body(name: "Lower Legs")
        let glutes = Body(name: "Glutes")
        
        lowBody = [upleg, lowleg, glutes]
        
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
        let lower = lowBody[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = lower.name
        //cell.configure(for: lower)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lowBody.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lowbody = lowBody[indexPath.row]
        let filteredWorkouts = self.Workouts.filter { (Workout) -> Bool in
            return Workout.main_muscle == lowbody.name
        }
        let lowBodyController = ExercisesViewController()
        lowBodyController.setExercises(exercises: filteredWorkouts)
        lowBodyController.bodyType = lowbody
        self.navigationController?.pushViewController(lowBodyController, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
