//
//  ActivityView.swift
//  TriSprint
//
//  Created by Nigel Karan on 21.11.21.
//

import SwiftUI

struct ActivityView: View {
    
    @ObservedObject var activityVm = ActivityViewModel()
    @State private var session: Activity = .swim
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ride.timestamp, ascending: true)], animation: .default)
    private var rides: FetchedResults<Ride>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Run.timestamp, ascending: true)], animation: .default)
    private var runs: FetchedResults<Run>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Swim.timestamp, ascending: true)], animation: .default)
    private var swims: FetchedResults<Swim>
    
    var body: some View {
        
        ZStack {
            switch session {
            case .swim:
                SwimBackground()
            case .ride:
                BikeBackground()
            case .run:
                RunBackground()
            }
            
            VStack {
                Picker("Activity", selection: $session) {
                    ForEach(Activity.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                scrollView
                
                .navigationTitle("Training Schedule")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(false)
            }
        }
    }
}


extension ActivityView {
    private var scrollView: some View {
        GeometryReader { fullView in
            ScrollView() {
                if !rides.isEmpty || !swims.isEmpty || !runs.isEmpty {
                    switch session {
                    case .swim:
                        LazyVStack {
                            Spacer()
                            ForEach(swims) { swim in
                                SwimsView(swim: swim)
                                    .frame(width: fullView.size.width - 40, height: 200, alignment: .center)
                                    .padding(.bottom,20)
                                    .shadow(color: .gray, radius: 4, x: 5, y: 5)
                            }
                        }
                    case .ride:
                        LazyVStack {
                            Spacer()
                            ForEach(rides) { ride in
                                RidesView(ride: ride)
                                    .frame(width: fullView.size.width - 40, height: 200, alignment: .center)
                                    .padding(.bottom,20)
                                    .shadow(color: .gray, radius: 4, x: 5, y: 5)
                            }
                        }
                    case .run:
                        LazyVStack {
                            Spacer()
                            ForEach(runs) { run in
                                RunsView(run: run)
                                    .frame(width: fullView.size.width - 40, height: 200, alignment: .center)
                                    .padding(.bottom,20)
                                    .shadow(color: .gray, radius: 4, x: 5, y: 5)
                            }
                        }
                    }
                } else {
                    Spacer()
                    VStack {
                        Spacer()
                        NoActivityView()
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
