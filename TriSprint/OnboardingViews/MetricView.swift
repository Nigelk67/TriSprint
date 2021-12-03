//
//  MetricView.swift
//  TriSprint
//
//  Created by Nigel Karan on 23.11.21.
//

import SwiftUI

struct MetricView: View {
    
    @State private var measurements = [Measure.kilometers.rawValue,Measure.miles.rawValue]
    @State private var nextScreen = false
    @AppStorage(AppStor.measure.rawValue) var measure: String?
    
    var body: some View {
        ZStack {
            RunBackground()
            VStack {
                Spacer()
                Text("Personalise Your Plan")
                    .foregroundColor(Color.accentButton)
                    .font(.system(.largeTitle, design: .rounded))
                    .padding(.vertical)
                Spacer()
                selectionView
                Spacer()
                Spacer()
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
}

extension MetricView {
    private var selectionView: some View {
        VStack {
            Text("What do you prefer to work in?")
                .foregroundColor(Color.mainText)
                .font(.system(.title2, design: .rounded))
                .padding(.vertical)
                .multilineTextAlignment(.center)
                .padding()
            
            buttonsView
            
        }
        .background(Color.white)
        .opacity(0.7)
        .cornerRadius(8)
        .padding(.horizontal, 20)
    }
    
    private var buttonsView: some View {
        VStack {
            ForEach(measurements, id: \.self) { metric in
                NavigationLink(destination: TrainingDaysView(), isActive: $nextScreen) {
                    Button {
                        measure = metric
                        CustomUserDefaults.shared.set(metric, key: .measure)
                        nextScreen.toggle()
                    } label: {
                        Text(metric)
                            .foregroundColor(Color.mainText)
                            .font(.system(.title, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .modifier(GreenButton())
                    .padding(.horizontal, 10)
                }
            }
            .padding()
        }
    }
}

struct MetricView_Previews: PreviewProvider {
    static var previews: some View {
        MetricView()
    }
}
