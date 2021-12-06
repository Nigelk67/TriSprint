//
//  PasswordChangeView.swift
//  TriSprint
//
//  Created by Nigel Karan on 06.12.21.
//

import SwiftUI

struct PasswordChangeView: View {
    @StateObject var settingsVm = SettingsViewModel()
    let textFieldPadding: CGFloat = 8
    let textFieldCornerRadius: CGFloat = 10
    let textFieldOpacity: Double = 0.6
    @State var email = ""
    @State var newPassword = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Color.mainBackground.opacity(0.98)
            VStack {
                Text("Change your password")
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
                SecureField("New Password", text: $newPassword)
                    .frame(width: 250)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                
                Button {
                    settingsVm.changePassword(currentEmail: email, password: password, newPassword: newPassword)
                } label: {
                    Text("UPDATE")
                        .modifier(RegisterButtons())
                }
                .padding()
                
                Text("Your new password should be at least 8 characters and contain at least 1 number")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
                    .opacity(settingsVm.invalidPassword ? 1 : 0)
            }
            .alert(isPresented: $settingsVm.unableToUpdatePassword) {
                Alert(title: Text("Oh"), message: Text("Something went wrong. Please try again - thanks."), dismissButton: .cancel(Text("OK")))
            }
            VStack {
                if settingsVm.isSaving {
                    withAnimation {
                        LoadingView(loadingText: "Updating..")
                    }
                }
            }.alert(isPresented: $settingsVm.passwordUpdated) {
                Alert(title: Text("Success!"), message: Text("Your password has been updated"), dismissButton: .cancel(Text("Great!"), action: {
                    email = ""
                    password = ""
                    newPassword = ""
                })
                )
            }
        }
        .ignoresSafeArea()
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView()
    }
}
