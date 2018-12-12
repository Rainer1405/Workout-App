//
//  Workout.swift
//  WorkoutApp
//
//  Created by Trey Burrell on 12/1/18.
//  Copyright © 2018 Rainer Sainvil. All rights reserved.
//

import Foundation

struct Workout: Codable {
    var name: String
    var main_muscle: String
    var other_muscle: String
    var workout_type: String
    var equipment: String
    var difficulty: String
    var instructions: String
    var picture_url: String
}

struct WorkoutSearchResponse: Codable {
    var success: Bool
    var data: [Workout]
}
