//
//  DetailContentView.swift
//  TriSprint
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct DetailContentView: View {

    @Binding var plan: Plan
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            BikeBackground()
            VStack {
                cancelButton
                Text("Day: 5")
                    .foregroundColor(Color.mainText)
                    .font(.title)
                Spacer()
                ScrollView {
                    VStack {
                        HStack {
                            skipButton
                            enterManuallyButton
                        }
                        
                        HStack {
                            Image("Training_Full")
                                .padding(.horizontal,10)
                            Spacer()
                            VStack {
                                Text("Time")
                                    .foregroundColor(Color.mainText)
                                    .font(.title3)
                                    .padding(.bottom,4)
                                    
                                HStack(alignment: .firstTextBaseline) {
                                    Text("222")
                                        .foregroundColor(Color.mainText)
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                    Text("mins")
                                        .foregroundColor(Color.mainText)
                                        .font(.caption)
                                        .padding(.horizontal,-6)
                                }
                            }
                            Spacer()
                            VStack {
                                Text("RPE")
                                    .foregroundColor(Color.mainText)
                                    .font(.title3)
                                    .padding(.bottom,4)
                                Text("6")
                                    .foregroundColor(Color.mainText)
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                            }
                            .padding()
                        }
                        .padding(.horizontal,0)
                        .padding(.vertical,20)
                        
                        Text("This is where the description and drills for the session would go,This is where the description and drills for the session would go,This is where the description and drills for the session would go,This is where the description and drills for the session would go")
                            .foregroundColor(Color.mainText)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        letsGoButton
                            .padding(.bottom)
                    }
                    .frame(width: 350)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                }
            }
        }
    }
    private var cancelButton: some View {
        HStack {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Cancel")
        })
            //Spacer()
        }
    }
    
    private var enterManuallyButton: some View {
        HStack {
            Spacer()
            Button {
                print("Nige: Enter Manually")
            } label: {
                Text("Enter Manually")
                    .modifier(SmallGreenButton())
            }
            .padding(.top)
            .padding(.trailing)
        }
    }
    
    private var skipButton: some View {
        HStack {
            Button {
                print("Nige: Skip button pressed")
            } label: {
                Text("Skip Session")
                    .modifier(ReallySmallGreenButton())
            }
            .padding(.top)
            .padding(.leading)
            Spacer()
        }
    }
    private var letsGoButton: some View {
        HStack {
            Spacer()
            Button {
                print("Nige: Let's go button pressed")
            } label: {
                Text("Let's Go!")
                    .modifier(RedButton())
            }
            .padding(.top)
            .padding(.trailing)
        }
    }
    
}

struct DetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailContentView(plan: .constant(Plan()))
    }
}
