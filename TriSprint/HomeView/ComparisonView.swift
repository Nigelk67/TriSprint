//
//  ComparisonView.swift
//  TriSprint
//
//  Created by Nigel Karan on 29.11.21.
//

import SwiftUI

struct ComparisonView: View {
    
    let textSizeForComparisonBlocks: CGFloat = 18
    let textSizeForComparisonBlockPercentages: CGFloat = 12
    var measure: String = CustomUserDefaults.shared.get(key: .measure) as? String ?? ""
    @Binding var swimLatest: String
    @Binding var swimFastest: String
    @Binding var rideLatest: String
    @Binding var rideFastest: String
    @Binding var runLatest: String
    @Binding var runFastest: String
    @State private var swimVariance: String = "0"
    @State private var rideVariance: String = "0"
    @State private var runVariance: String = "0"
    @State private var isSwimNegative: Bool = false
    @State private var isRideNegative: Bool = false
    @State private var isRunNegative: Bool = false
    
    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                Text(measure == Measure.kilometers.rawValue ? "Speed Km/hr" : "Speed Mi/hr")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                HStack {
                    VStack(spacing: 10) {
                        Spacer()
                        Text("Latest")
                            .foregroundColor(Color.mainText)
                            .font(.system(size: textSizeForComparisonBlocks, weight: .regular, design: .rounded))
                        Text("Var")
                            .foregroundColor(Color.mainText)
                            .font(.system(size: textSizeForComparisonBlockPercentages, weight: .regular, design: .rounded))
                        Text("Fastest")
                            .foregroundColor(Color.mainText)
                            .font(.system(size: textSizeForComparisonBlocks, weight: .regular, design: .rounded))
                    }
                    .padding(.trailing,20)
                    VStack(spacing: 10) {
                        Image(IconImageNames.swimIcon.rawValue)
                            .resizable()
                            .scaledToFit()
                        Text(swimLatest)
                            .foregroundColor(Color.mainText)
                            .font(.system(size: textSizeForComparisonBlocks, weight: .regular, design: .rounded))
                        Text("\(swimVariance)%")
                            .foregroundColor(isSwimNegative ? Color.red : Color.green)
                            .font(.system(size: textSizeForComparisonBlockPercentages, weight: .regular, design: .rounded))
                        Text(swimFastest)
                            .foregroundColor(Color.mainText)
                            .font(.system(size: textSizeForComparisonBlocks, weight: .regular, design: .rounded))
                    }
                    VStack(spacing: 10) {
                        Image(IconImageNames.rideIcon.rawValue)
                            .resizable()
                            .scaledToFit()
                        Text(rideLatest)
                            .foregroundColor(Color.mainText)
                            .font(.system(size: textSizeForComparisonBlocks, weight: .regular, design: .rounded))
                        Text("\(rideVariance)%")
                            .foregroundColor(isRideNegative ? Color.red : Color.green)
                            .font(.system(size: textSizeForComparisonBlockPercentages, weight: .regular, design: .rounded))
                        Text(rideFastest)
                            .foregroundColor(Color.mainText)
                            .font(.system(size: textSizeForComparisonBlocks, weight: .regular, design: .rounded))
                    }
                    VStack(spacing: 10) {
                        Image(IconImageNames.runIcon.rawValue)
                            .resizable()
                            .scaledToFit()
                        Text(runLatest)
                            .foregroundColor(Color.mainText)
                            .font(.system(size: textSizeForComparisonBlocks, weight: .regular, design: .rounded))
                        Text("\(runVariance)%")
                            .foregroundColor(isRunNegative ? Color.red : Color.green)
                            .font(.system(size: textSizeForComparisonBlockPercentages, weight: .regular, design: .rounded))
                        Text(runFastest)
                            .foregroundColor(Color.mainText)
                            .font(.system(size: textSizeForComparisonBlocks, weight: .regular, design: .rounded))
                    }
                }
                .frame(width:geo.size.width / 1.1, height: 150, alignment: .center)
                //.padding(.horizontal)
            }
            .frame(width: geo.size.width / 1.1, height: 200, alignment: .center)
            .background(Color.white.opacity(0.5))
            .cornerRadius(20)
            .offset(x: 20, y: 0)
        }
        .onAppear {
            calculateVariances()
        }
    }
    
    
    private func calculateVariances() {
        guard let swimLatestDble = Double(swimLatest), let swimFastestDble = Double(swimFastest) else { return }
        let swimVarianceDble = ((swimLatestDble - swimFastestDble)/swimLatestDble) * 100
        if swimVarianceDble < 0 {
            isSwimNegative = true
        }
        swimVariance = String(format: "%.1f", swimVarianceDble)
        
        guard let rideLatestDble = Double(rideLatest), let rideFastestDble = Double(rideFastest) else { return }
        let rideVarianceDble = ((rideLatestDble - rideFastestDble)/rideLatestDble) * 100
        if rideVarianceDble < 0 {
            isRideNegative = true
        }
        rideVariance = String(format: "%.1f", rideVarianceDble)
        
        guard let runLatestDble = Double(runLatest), let runFastestDble = Double(runFastest) else { return }
        let runVarianceDble = ((runLatestDble - runFastestDble)/runLatestDble) * 100
        if runVarianceDble < 0 {
            isRunNegative = true
        }
        
        runVariance = String(format: "%.1f", runVarianceDble)
        
    }
}

//struct ComparisonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComparisonView()
//    }
//}
