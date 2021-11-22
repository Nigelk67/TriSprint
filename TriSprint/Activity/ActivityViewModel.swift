//
//  ActivityViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 21.11.21.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var measure: String = "metr"
    @Published var distanceText = "0.00"
    @Published var timeText = "0.00"
    @Published var paceText = "0.00"
    @Published var dateText = ""
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
    
    func updateRides(ride: Ride) {
        imageName = TrainingImageNames.trainingRide.rawValue
        if self.measure == "metric" {
            let formattedDistance = FormatDisplay.kmDistance(ride.distance)
            let formattedTime = FormatDisplay.time(Int(ride.duration))
            let formattedPace = FormatDisplay.speed(distance: ride.distance, seconds: ride.duration, outputUnit: UnitSpeed.minutesPerKilometer)
            let formattedDate = FormatDisplay.date(ride.timestamp)
            distanceText = "\(formattedDistance)"
            timeText = "\(formattedTime)"
            paceText = "\(formattedPace)"
            dateText = "\(formattedDate)"
        } else {
            let formattedDistance = FormatDisplay.distance((ride.distance))
            let formattedTime = FormatDisplay.time(Int(ride.duration))
            let formattedPace = FormatDisplay.speed(distance: ride.distance, seconds: ride.duration, outputUnit: UnitSpeed.minutesPerMile)
            let formattedDate = FormatDisplay.date(ride.timestamp)
            distanceText = "\(formattedDistance)"
            timeText = "\(formattedTime)"
            paceText = "\(formattedPace)"
            dateText = "\(formattedDate)"
        }
    }
    
}
