//
//  NetworkManager.swift
//  WorkoutApp
//
//  Created by Trey Burrell on 12/1/18.
//  Copyright © 2018 Rainer Sainvil. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let workoutURL = "http://35.243.172.54"
    
    static func getWorkout(didGetWorkouts: @escaping ([Workout]) -> Void) {
        Alamofire.request(workoutURL, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let workoutResponse = try? jsonDecoder.decode(WorkoutSearchResponse.self, from: data) {
                    
                    didGetWorkouts(workoutResponse.data)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
