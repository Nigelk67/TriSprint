//
//  MapView.swift
//  TriSprint
//
//  Created by Nigel Karan on 18.11.21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Binding var plan: Plan
    @State var targetTime = ""
    @State var targetRpe = ""
    @State var targetDesc = ""
    @State var session = ""
    @StateObject private var mapVm = MapViewModel()
    @StateObject private var sessionVm = SessionViewModel()
    @ObservedObject private var scheduleVm = ScheduleViewModel()
    @ObservedObject private  var locationManager = LocationManager()
    @Environment(\.presentationMode) private var presentationMode
    @State private var hasStarted: Bool = false
    @State private var shouldShowStopActions = false
    @State private var showDrillsPopup = false
    @State private var drills: String = "No drills"
    @State private var isBrick = false
    @State private var shouldShowBrickView = false
    @State private var planComplete = false
    @State private var showRatingsView = false
    @State private var rating: Int = 0
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    let measure = CustomUserDefaults.shared.get(key: .measure)
    let rootVC = UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive }
        .map { $0 as? UIWindowScene }
        .compactMap { $0 }
        .first?.windows
        .filter({ $0.isKeyWindow }).first?.rootViewController
    
    var body: some View {
        
        ZStack {
            BackgroundView(plan: $plan)
            
            VStack {
                headerStack
            
                Text(("Day: \(plan.day ?? "")"))
                    .foregroundColor(Color.accentButton)
                    .font(.system(size: 26, weight: .medium, design: .rounded))
                    
                TargetStack(plan: $plan, targetTime: $targetTime, targetRpe: $targetRpe, showDrillsPopup: $showDrillsPopup)
                                
                Map(coordinateRegion: $mapVm.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow))
                
                trackingMeasures
                
                trackingButtons
            }
            
            VStack {
                if shouldShowBrickView {
                    isBrickView
                }
            }.frame(width: 300, height: 400)
            
            VStack {
                if showDrillsPopup {
                    DrillsView(plan: $plan, targetDescription: $targetDesc)
                }
            }.animation(.default, value: showDrillsPopup)
            
                .alert(isPresented: $sessionVm.showConfirmationPopup) {
                    saveSessionAlert
                }
                .navigationBarHidden(true)

            if sessionVm.isSaving {
                withAnimation {
                    LoadingView(loadingText: "Saving..")
                }
            }
            NavigationLink(destination: RatingsView(rating: $rating), isActive: $showRatingsView) { EmptyView() }
        }
        .onAppear {
            mapVm.checkIfLocationServicesIsEnabled()
            setDrillsText()
            if plan.session == Sessions.rideRun.rawValue {
                isBrick = true
            } else {
                isBrick = false
            }
        }
    }
    
}

extension MapView {
    
    private var headerStack: some View {
        HStack(alignment: .firstTextBaseline) {
            CancelButton(presentationMode: presentationMode)
                .padding(.leading,10)
            Spacer()
            ShowDrillsButton(showDrillsPopup: $showDrillsPopup)
                .padding(.trailing,30)
               
            
        }
        //.frame(width: 350)
        
    }
    
    private var isBrickView: some View {
        VStack {
            Spacer()
            Text("FINISHED?")
                .foregroundColor(Color.mainText)
                .font(.system(size: 24, weight: .medium, design: .rounded))
                .padding()
            Text("Have you completed both your activities for this BRICK session")
                .foregroundColor(Color.mainText)
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Button {
                sessionVm.markPlanComplete(plan: plan)
                planComplete = true
                guard let day = plan.day else { return }
                if day == ReviewDay.one.rawValue || day == ReviewDay.two.rawValue || day == ReviewDay.three.rawValue {
                    showRatingsView = true
                } else {
                    rootVC?.dismiss(animated: true)
                }
            } label: {
                Text("Yes")
                    .modifier(RegisterButtons())
            }
            .padding()
            
            Button {
                shouldShowBrickView = false
            } label: {
                Text("No")
                    .foregroundColor(Color.mainButton)
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                    .padding()
            }

        }
        .padding()
        .background(Color.accentButton)
        .opacity(0.95)
        .cornerRadius(10)
    }
    
    private var trackingMeasures: some View {
        VStack {
            HStack {
                Text("Time:")
                    .font(.body)
                    .foregroundColor(Color.mainText)
                Text(sessionVm.timeText)
                    .foregroundColor(Color.mainButton)
                    .font(Font.monospacedDigit(.title3)())
            }
            HStack {
                Text("Distance:")
                    .font(.body)
                    .foregroundColor(Color.mainText)
                Text(sessionVm.distanceText)
                    .foregroundColor(Color.mainButton)
                    .font(Font.monospacedDigit(.title3)())
            }
            HStack {
                Text("Pace:")
                    .font(.body)
                    .foregroundColor(Color.mainText)
                Text(sessionVm.paceText)
                    .foregroundColor(Color.mainButton)
                    .font(Font.monospacedDigit(.title3)())
            }
        }
        
    }
    
    private var trackingButtons: some View {
        HStack {
            Button {
                sessionVm.pauseSession()
            } label: {
                Text(sessionVm.isPaused ? "Continue" : "Pause")
                    .frame(width: 90, height: 40, alignment: .center)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .background(hasStarted ? Color.accentButton : Color.gray)
                    .foregroundColor(Color.mainText)
                    .cornerRadius(5)
            }
            .disabled(hasStarted ? false : true)
            Spacer()
            
            Button {
                hasStarted = true
                start()
            } label: {
                Text("Start")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
            }.buttonStyle(StartButton(hasStarted: hasStarted))
                .disabled(hasStarted ? true : false)
                .opacity(hasStarted ? 0.5 : 1)
            Spacer()
            
            Button {
                shouldShowStopActions.toggle()
            } label: {
                Text("Stop")
                    .frame(width: 90, height: 40, alignment: .center)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .background(hasStarted ? Color.red : Color.gray)
                    .opacity(hasStarted ? 1 : 0.5)
                    .foregroundColor(Color.mainText)
                    .cornerRadius(5)
                    .disabled(hasStarted ? false : true)
            }
            .actionSheet(isPresented: $shouldShowStopActions) {
                stopActionSheet
            }
        }
        .frame(width: 350)
        .padding(.vertical, 30)
        
        
    }
    
    private var stopActionSheet: ActionSheet {
        ActionSheet(title: Text("\(self.plan.session ?? "") STOPPED!"), message: Text("You can"), buttons: [
            .default(Text("Finish & Save This Session"), action: {
                if plan.session == Sessions.rideRun.rawValue {
                    session = session
                } else {
                    session = plan.session ?? ""
                }
                hasStarted = false
                sessionVm.sesssionStopped()
                sessionVm.saveSession(session: session, measure: measure as! String)
                
            }),
            .destructive(Text("Discard This Session"),
                         action: {
                             hasStarted = false
                             sessionVm.sesssionStopped()
                         }),
            .cancel(Text("Carry On!"))
        ])
    }
    
    private var actionSheet: ActionSheet {
        ActionSheet(title: Text("FINISHED?"), message: Text("Have you completed both your activities for this BRICK session"), buttons: [
            .default(Text("YES!"), action: {
                sessionVm.markPlanComplete(plan: plan)
                rootVC?.dismiss(animated: true)
            }),
            .destructive(Text("NO!"),
                         action: {
                             presentationMode.wrappedValue.dismiss()
                         })
        ])
    }
    
    private var saveSessionAlert: Alert {
        Alert(title: Text("SAVED!"), message: Text("This session has been saved"), dismissButton: .default(Text("OK"), action: {
            if isBrick {
                shouldShowBrickView.toggle()
            } else {
                sessionVm.markPlanComplete(plan: plan)
                planComplete = true
                guard let day = plan.day else { return }
                if day == ReviewDay.one.rawValue || day == ReviewDay.two.rawValue || day == ReviewDay.three.rawValue {
                    showRatingsView = true
                } else {
                    rootVC?.dismiss(animated: true)
                }
                
            }
            
        }))
        
//        Alert(title: Text("SAVED!"), message: Text("This session has been saved"), dismissButton: .default(Text("OK"), action: {
//            sessionVm.markPlanComplete(plan: plan)
//            rootVC?.dismiss(animated: true)
//          
//        }))
    }
    
    //MARK: Functions:
    
    private func setDrillsText() {
        if plan.session == Sessions.run.rawValue {
            drills = plan.runDescription ?? "No drills for this session"
        } else {
            drills = plan.rideDescription ?? "No drills for this session"
        }
    }
    
    private func start() {
        sessionVm.secs = 0
        mapVm.distance = Measurement(value: 0, unit: UnitLength.meters)
        mapVm.locationList.removeAll()
        sessionVm.updateDisplay()
        sessionVm.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            sessionVm.eachSecond()
        })
    }
}


struct ShowDrillsButton: View {
    @Binding var showDrillsPopup: Bool
    var body: some View {
        VStack {
            Button(action: {
                showDrillsPopup.toggle()
            }, label: {
                Image(systemName: "ellipsis.bubble")
                    .font(.system(size: 20))
                    .foregroundColor(Color.mainButton)
            })
                
        }
    }
}

struct TargetStack: View {
    @Binding var plan: Plan
    @Binding var targetTime: String
    @Binding var targetRpe: String
    @ObservedObject private var scheduleVm = ScheduleViewModel()
    @Binding var showDrillsPopup: Bool
    var body: some View {
        HStack(alignment: .center) {
            
            let imageName = scheduleVm.setImageNames(session: plan.session ?? "", completed: plan.completed)
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding(.top,5)
            Spacer()
            
            Text("Target Time:")
                .font(.system(size: 16))
                .foregroundColor(Color.mainText)
            if plan.session == Sessions.ride.rawValue {
                Text(plan.rideTime ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title3)
            } else if plan.session == Sessions.rideRun.rawValue {
                Text(targetTime)
                    .foregroundColor(Color.mainText)
                    .font(.title3)
            } else {
                Text(plan.runTime ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title3)
            }
            Text("mins")
                .foregroundColor(Color.mainText)
                .font(.system(size: 12))
                .padding(.leading,-4)
            //}
            Spacer()
            
            // HStack(alignment: .firstTextBaseline) {
            Text("Target RPE:")
                .font(.system(size: 16))
                .foregroundColor(Color.mainText)
            if plan.session == Sessions.ride.rawValue {
                Text(plan.rideRpe ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title3)
            } else if plan.session == Sessions.rideRun.rawValue {
                Text(targetRpe)
                    .foregroundColor(Color.mainText)
                    .font(.title3)
            } else {
                Text(plan.runRpe ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title3)
            }
        }
        .frame(width: 350, height: 50, alignment: .center)
    }
}



//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(plan: .constant(Plan()))
//    }
//}
