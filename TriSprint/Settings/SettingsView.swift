//
//  SettingsView.swift
//  TriSprint
//
//  Created by Nigel Karan on 30.11.21.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var measure: String = CustomUserDefaults.shared.get(key: .measure) as? String ?? ""
    @State private var isKilometers: Bool = false
    
    var body: some View {
        
        ZStack {
            TriBackground()
            VStack {
                Text("Settings")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                Spacer()
                
                VStack {
                    
                    metricsButton
                    
                Button {
                    print("Nige: Show Alert")
                } label: {
                    Text("Reset Activities")
                        .foregroundColor(Color.mainText)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                }

                Spacer()
                }
            }
        }
        .onAppear {
            print("Nige: measure in Settings = \(measure)")
            if measure == Measure.kilometers.rawValue {
                isKilometers = true
            } else {
                isKilometers = false
            }
        }
    }
}

extension SettingsView {
    private var metricsButton: some View {
        VStack {
            Text("Kilometers Or Miles?")
            if isKilometers {
                HStack {
                    Button {
                        isKilometers = true
                        measure = Measure.kilometers.rawValue
                        CustomUserDefaults.shared.set(Measure.kilometers.rawValue, key: .measure)
                    } label: {
                        Text("Km")
                            .foregroundColor(Color.mainText)
                            .font(.system(.title, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .modifier(SmallGreenButton())
                    .padding()
                    
                    
                    Button {
                        isKilometers = false
                        measure = Measure.miles.rawValue
                        CustomUserDefaults.shared.set(Measure.miles.rawValue, key: .measure)
                    } label: {
                        Text("Mi")
                            .foregroundColor(Color.mainText)
                            .font(.system(.title, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .modifier(SmallGreyButton())
                    .padding()
                }
                .frame(width: 300, height: 60)
            } else {
                HStack {
                    Button {
                        isKilometers = true
                        measure = Measure.kilometers.rawValue
                        CustomUserDefaults.shared.set(Measure.kilometers.rawValue, key: .measure)
                    } label: {
                        Text("Km")
                            .foregroundColor(Color.mainText)
                            .font(.system(.title, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .modifier(SmallGreyButton())
                    .padding()
                    
                    
                    Button {
                        isKilometers = false
                        measure = Measure.miles.rawValue
                        CustomUserDefaults.shared.set(Measure.miles.rawValue, key: .measure)
                    } label: {
                        Text("Mi")
                            .foregroundColor(Color.mainText)
                            .font(.system(.title, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .modifier(SmallGreenButton())
                    .padding()
                }
                .frame(width: 300, height: 60)
            }
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
