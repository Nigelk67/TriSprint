//
//  ActivityViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 21.11.21.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var measure: String = "metr"
    @Published var rideDistanceText = "0.00"
    @Published var rideTimeText = "0.00"
    @Published var ridePaceText = "0.00"
    @Published var rideDateText = ""
    @Published var imageName = TrainingImageNames.trainingFull.rawValue                                                
    //var ridePosts = [RidePost]()
    //@Environment(\.managedObjectContext) private var viewContext
    //@FetchRequest(
    //    sortDescriptors: [NSSortDescriptor(keyPath: \Ride.timestamp, ascending: true)], animation: .default)
    //private var rides: FetchedResults<Ride>
    
//    func fetchRides(ride: Ride) {
//        let ridePost = RidePost(duration: ride.duration, timestamp: ride.timestamp ?? Date(), distance: ride.distance)
//        ridePosts.append(ridePost)
//        print("Nige: ride posts = \(ridePosts)")
//    }
    
    func updateRuns(activity: AnyClass) {
        
    }
    
    func updateRides(ride: Ride) {
        imageName = TrainingImageNames.trainingRide.rawValue
        if self.measure == "metric" {
            let formattedDistance = FormatDisplay.kmDistance(ride.distance)
            let formattedTime = FormatDisplay.time(Int(ride.duration))
            let formattedPace = FormatDisplay.speed(distance: ride.distance, seconds: ride.duration, outputUnit: UnitSpeed.minutesPerKilometer)
            let formattedDate = FormatDisplay.date(ride.timestamp)
            rideDistanceText = "\(formattedDistance)"
            rideTimeText = "\(formattedTime)"
            ridePaceText = "\(formattedPace)"
            rideDateText = "\(formattedDate)"
        } else {
            let formattedDistance = FormatDisplay.distance((ride.distance))
            let formattedTime = FormatDisplay.time(Int(ride.duration))
            let formattedPace = FormatDisplay.speed(distance: ride.distance, seconds: ride.duration, outputUnit: UnitSpeed.minutesPerMile)
            let formattedDate = FormatDisplay.date(ride.timestamp)
            rideDistanceText = "\(formattedDistance)"
            rideTimeText = "\(formattedTime)"
            ridePaceText = "\(formattedPace)"
            rideDateText = "\(formattedDate)"
        }
    }
    
}
