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
    @AppStorage("measure") var measure: String?
    @State var header: String
    @Binding var swimLatest: String
    @Binding var swimFastest: String
    @Binding var rideLatest: String
    @Binding var rideFastest: String
    @Binding var runLatest: String
    @Binding var runFastest: String
    @Binding var swimVariance: String
    @Binding var rideVariance: String
    @Binding var runVariance: String
    @Binding var isSwimNegative: Bool
    @Binding var isRideNegative: Bool
    @Binding var isRunNegative: Bool
    
    
    var body: some View {
        
            VStack {

                HStack {
                    VStack(spacing: 10) {
                        if header == "Speed" {
                            Text(measure == Measure.kilometers.rawValue ? "\(header) (km/hr)" : "\(header) (mi/hr)")
                                .foregroundColor(Color.mainText)
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .padding(.leading, 10)
                        } else {
                            Text(measure == Measure.kilometers.rawValue ? "\(header) (mn/km)" : "\(header) (mn/mi)")
                                .foregroundColor(Color.mainText)
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .padding(.leading, 10)
                        }
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
                .frame(width: 350, height: 150, alignment: .center)
             
            }
            .frame(width: 350, height: 200, alignment: .center)
            .background(Color.white.opacity(0.5))
            .cornerRadius(20)
         
    }
    
    
}

//struct ComparisonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComparisonView()
//    }
//}
