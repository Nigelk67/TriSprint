//
//  HomeView.swift
//  TriSprint
//
//  Created by Nigel Karan on 25.11.21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVm = HomeViewModel()
    @StateObject var lineChartVm = LineChartViewModel()
    @State private var bounce = false
    @State private var startProgressBars = false
    @AppStorage(AppStor.signedIn.rawValue) var signedIn: Bool?
    @State private var showLoginScreen: Bool = false
  
    let chartBlockHeight: Double = 400
    let chartBlockWidth: Double = 350
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ride.timestamp, ascending: false)], animation: .default)
    private var rides: FetchedResults<Ride>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Run.timestamp, ascending: false)], animation: .default)
    private var runs: FetchedResults<Run>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Swim.timestamp, ascending: false)], animation: .default)
    private var swims: FetchedResults<Swim>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plan.day, ascending: true)], animation: .default)
    private var plans: FetchedResults<Plan>
    
    var body: some View {
    
        ZStack {
            TriBackground()
            VStack {
                Text("Progress")
                    .foregroundColor(Color.accentButton)
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .padding(.vertical)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        completedSoFar
                        HStack {
                        Text("Actuals")
                            .foregroundColor(Color.mainText)
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .padding(.leading,40)
                            Spacer()
                        }
                        swimCharts
                        rideCharts
                        runCharts
                        speedStack
                        paceStack
                        
                    }
                }
            }
            .onAppear {
                setValuesOnAppear()
            }
        }
    }
}


extension HomeView {
    
    private func setValuesOnAppear() {
        bounce = true
        homeVm.calculateTotals(plans: plans, swims: swims, rides: rides, runs: runs)
        homeVm.calculateFastest(swims: swims, rides: rides, runs: runs)
        lineChartVm.createArraysForChart(swims: swims, rides: rides, runs: runs)

    }
    
    private var completedSoFar: some View {
        VStack {
            HStack {
            Text("Plans Completed So Far")
                .foregroundColor(Color.mainText)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .padding(.leading,40)
                .padding(.bottom,8)
                Spacer()
            }
            HStack {
                VStack {
                    Text("Total")
                        .foregroundColor(Color.mainText)
                        .font(.system(size: 11, weight: .light, design: .rounded))
                    
                    pieChart

                }
                .padding(.trailing,20)
                
                progressStack
                    .padding(.leading,50)
            }
        }
    }
    
    private var pieChart: some View {
        
        PieChartModel([(Color.accentButton.opacity(0.6), 100),(Color.accentButton.opacity(0.2),homeVm.proportionCompleted)])
            .frame(width: 100, height: 100, alignment: .center)
            .scaleEffect(bounce ? 1 : 0)
            .animation(Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3).delay(0.05), value: bounce)
            
        }
        
    
    
    private var progressStack: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Swim")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                ProgressBarView(currentProgress: $homeVm.currentSwimProgress, endProgress: $homeVm.swimProgress, barColor: Color.accentButton, barOpacity: 0.1, progressBarColor: Color.accentButton, progressBarOpacity: 0.8)
            }
            VStack(alignment: .leading) {
                Text("Ride")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                ProgressBarView(currentProgress: $homeVm.currentRideProgress, endProgress: $homeVm.rideProgress, barColor: Color.accentButton, barOpacity: 0.1, progressBarColor: Color.accentButton, progressBarOpacity: 0.8)
            }
            VStack(alignment: .leading) {
                Text("Run")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                ProgressBarView(currentProgress: $homeVm.currentRunProgress, endProgress: $homeVm.runProgress, barColor: Color.accentButton, barOpacity: 0.1, progressBarColor: Color.accentButton, progressBarOpacity: 0.8)
                   
            }
        }
    }
    
    private var speedStack: some View {
  
        ComparisonView(header: "Speed", swimLatest: $homeVm.swimSpeedLatest, swimFastest: $homeVm.swimSpeedFastest, rideLatest: $homeVm.rideSpeedLatest, rideFastest: $homeVm.rideSpeedFastest, runLatest: $homeVm.runSpeedLatest, runFastest: $homeVm.runSpeedFastest, swimVariance: $homeVm.swimSpeedVariance, rideVariance: $homeVm.rideSpeedVariance, runVariance: $homeVm.runSpeedVariance, isSwimNegative: $homeVm.isSwimSpeedNegative, isRideNegative: $homeVm.isRideSpeedNegative, isRunNegative: $homeVm.isRunSpeedNegative)
        
    }
    
    private var paceStack: some View {
      
        ComparisonView(header: "Pace", swimLatest: $homeVm.swimPaceLatest, swimFastest: $homeVm.swimPaceFastest, rideLatest: $homeVm.ridePaceLatest, rideFastest: $homeVm.ridePaceFastest, runLatest: $homeVm.runPaceLatest, runFastest: $homeVm.runPaceFastest, swimVariance: $homeVm.swimPaceVariance, rideVariance: $homeVm.ridePaceVariance, runVariance: $homeVm.runPaceVariance, isSwimNegative: $homeVm.isSwimPaceNegative, isRideNegative: $homeVm.isRidePaceNegative, isRunNegative: $homeVm.isRunPaceNegative)
    
    }
    
    private var swimCharts: some View {
        VStack {
            HStack {
            Image(IconImageNames.swimIcon.rawValue)
                .resizable()
                .scaledToFit()
                Spacer()
            }
            HStack {
                LineChartView(dataForArray: lineChartVm.swimDistanceArrayReversed, chartHeader: "Distance")
                LineChartView(dataForArray: lineChartVm.swimDurationArray, chartHeader: "Time")
            }
            HStack {
                LineChartView(dataForArray: lineChartVm.swimSpeedArray, chartHeader: "Speed")
                LineChartView(dataForArray: lineChartVm.swimPaceArray, chartHeader: "Pace")
            }
        }
        .frame(width: chartBlockWidth, height: chartBlockHeight)
        .background(Color.accentButton.opacity(0.3))
        .cornerRadius(20)
    }
    
    private var rideCharts: some View {
        VStack {
            HStack {
            Image(IconImageNames.rideIcon.rawValue)
                .resizable()
                .scaledToFit()
                Spacer()
            }
            HStack {
                LineChartView(dataForArray: lineChartVm.rideDistanceArray, chartHeader: "Distance")
                LineChartView(dataForArray: lineChartVm.rideDurationArray, chartHeader: "Time")
            }
            HStack {
                LineChartView(dataForArray: lineChartVm.rideSpeedArray, chartHeader: "Speed")
                LineChartView(dataForArray: lineChartVm.ridePaceArray, chartHeader: "Pace")
            }
        }
        .frame(width: chartBlockWidth, height: chartBlockHeight)
        .background(Color.accentButton.opacity(0.3))
        .cornerRadius(20)
    }
    
    private var runCharts: some View {
        VStack {
            HStack {
            Image(IconImageNames.runIcon.rawValue)
                .resizable()
                .scaledToFit()
                Spacer()
            }
            HStack {
                LineChartView(dataForArray: lineChartVm.runDistanceArray, chartHeader: "Distance")
                LineChartView(dataForArray: lineChartVm.runDurationArray, chartHeader: "Time")
            }
            HStack {
                LineChartView(dataForArray: lineChartVm.runSpeedArray, chartHeader: "Speed")
                LineChartView(dataForArray: lineChartVm.runPaceArray, chartHeader: "Pace")
            }
        }
        .frame(width: chartBlockWidth, height: chartBlockHeight)
        .background(Color.accentButton.opacity(0.3))
        .cornerRadius(20)
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
