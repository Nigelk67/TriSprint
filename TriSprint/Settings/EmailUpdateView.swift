//
//  EmailUpdateView.swift
//  TriSprint
//
//  Created by Nigel Karan on 06.12.21.
//

import SwiftUI

struct EmailUpdateView: View {
    
    @StateObject var settingsVm = SettingsViewModel()
    
    let textFieldPadding: CGFloat = 8
    let textFieldCornerRadius: CGFloat = 10
    let textFieldOpacity: Double = 0.6
    @State var email = ""
    @State var newEmail = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Color.mainBackground.opacity(0.98)
            VStack {
                Text("Change your email address")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                TextField("Current Email", text: $email)
                    .frame(width: 250)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .frame(width: 250)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                TextField("New Email", text: $newEmail)
                    .frame(width: 250)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                    .keyboardType(.emailAddress)
                
                Button {
                    settingsVm.changeEmail(currentEmail: email, password: password, newEmail: newEmail)
                } label: {
                    Text("UPDATE")
                        .foregroundColor(Color.mainButton)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding()
            }
            .alert(isPresented: $settingsVm.unableToUpdateEmail) {
                Alert(title: Text("Oh"), message: Text("Something went wrong. Please try again - thanks."), dismissButton: .cancel(Text("OK")))
            }
            VStack {
                if settingsVm.isSaving {
                    withAnimation {
                        LoadingView(loadingText: "Updating..")
                    }
                }
            }.alert(isPresented: $settingsVm.emailUpdated) {
                Alert(title: Text("Success!"), message: Text("Email  has been updated to \n\(newEmail)"), dismissButton: .cancel(Text("Great!"), action: {
                    email = ""
                    password = ""
                    newEmail = ""
                })
                )
            }
        }
        .ignoresSafeArea()
    }
}

struct EmailUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        EmailUpdateView()
    }
}
