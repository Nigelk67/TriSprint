//
//  LoginView.swift
//  TriSprint
//
//  Created by Nigel Karan on 01.12.21.
//

import SwiftUI

struct LoginView: View {
    let imageWidth: CGFloat = 150
    let imagePadding: CGFloat = 40
    @State private var email = ""
    @State private var password = ""
    @State private var signUpEmail = ""
    @State private var signUpPassword = ""
    @State private var userName = ""
    //@State private var reset: Bool = false
    @StateObject var loginVm = LoginViewModel()
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                TriBackground()
                VStack {
                    HStack {
                        Image(TrainingImageNames.trainingSwim.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageWidth)
                            .padding(imagePadding)
                        VStack {
                            TextField("Email address", text: $email)
                                .padding()
                                .background(Color.accentButton)
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color.accentButton)
                            Button {
                                loginVm.login(email: email, password: password)
                                email = ""
                                password = ""
                            } label: {
                                Text("Log In")
                                    .foregroundColor(Color.mainText)
                                    .frame(width: 150, height: 50)
                                    .background(Color.mainButton)
                                    .cornerRadius(8)
                            }
                           
                        }
                    }
                    Image(TrainingImageNames.trainingRide.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageWidth)
                        .padding(imagePadding)
                    HStack {
                        VStack {
                            TextField("Username", text: $userName)
                            TextField("Email address", text: $signUpEmail)
                                .padding()
                                .background(Color.accentButton)
                            SecureField("Password", text: $signUpPassword)
                                .padding()
                                .background(Color.accentButton)
                            Button {
                                loginVm.signUp(name: userName, email: signUpEmail, password: signUpPassword)
                                userName = ""
                                signUpEmail = ""
                                signUpPassword = ""
                            } label: {
                                Text("Create")
                                    .foregroundColor(Color.mainText)
                                    .frame(width: 150, height: 50)
                                    .background(Color.mainButton)
                                    .cornerRadius(8)
                            }
                            .alert(isPresented: $loginVm.isNotValidSignUp) {
                                Alert(title: Text("Uh?"), message: Text("Something is not right with your credentials. Try typing them in again"), dismissButton: .default(Text("Ok")))
                            }
                          
                        }
                        Image(TrainingImageNames.trainingRun.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageWidth)
                            .padding(imagePadding)
                            
                    }
                    //NAVIGATION BOOL = @AppStorage("signedIn")
                }
                .onAppear {
                    loginVm.checkLogin()
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
