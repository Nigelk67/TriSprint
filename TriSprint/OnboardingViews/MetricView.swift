//
//  MetricView.swift
//  TriSprint
//
//  Created by Nigel Karan on 23.11.21.
//

import SwiftUI

struct MetricView: View {
    
    @State private var measurements = ["Kilometers","Miles"]
    @State private var nextScreen = false
    //@Environment(\.presentationMode) private var presentationMode
    
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
                    //.navigationBarBackButtonHidden(true)
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
//                            .toolbar {
//                                ToolbarItem(placement: .navigationBarLeading) {
//                                    CancelButton(presentationMode: presentationMode)
//                                }
//                            }
            }
        }
       
    }
    
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
            ForEach(measurements, id: \.self) { measure in
                NavigationLink(destination: TrainingDaysView(), isActive: $nextScreen) {
                Button {
                    UserDefaults.standard.set(measure, forKey: UserDefaults.Keys.measure.rawValue)
                    nextScreen.toggle()
                } label: {
                    Text(measure)
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
