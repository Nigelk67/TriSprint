//
//  LoginView.swift
//  TriSprint
//
//  Created by Nigel Karan on 01.12.21.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    let auth = Auth.auth()
    let imageWidth: CGFloat = 100
    let imagePadding: CGFloat = 0
    let imageOpacity: Double = 0.8
    let textFieldPadding: CGFloat = 8
    let textFieldCornerRadius: CGFloat = 10
    let textFieldOpacity: Double = 0.6
    let goToCreateAccountText = "No account? Click here to create one"
    let goToLoginText = "Already have an account? Click here"
    @State private var email = ""
    @State private var password = ""
    @State private var signUpEmail = ""
    @State private var signUpPassword = ""
    @State private var userName = ""
    @EnvironmentObject var loginVm: LoginViewModel 
    @State private var showCreateAccount: Bool = true
   
    var body: some View {
        
        NavigationView {
            ZStack {
                TriBackground()
                VStack {
                    
                    headerStack
                    Spacer()
                    centerImage
                    Spacer()
                    if showCreateAccount {
                        signUpStack
                    } else {
                        loginStack
                    }
                    
                    Spacer()
                    Button(action: {
                        showCreateAccount.toggle()
                    }, label: {
                        Text(showCreateAccount ? goToLoginText : goToCreateAccountText)
                            .modifier(GreenButton())
                            .foregroundColor(Color.mainText)
                    })
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
        
    }
}


extension LoginView {
    
    private var headerStack: some View {
        HStack {
        Text("TriSprint")
                .foregroundColor(Color.accentButton)
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .padding()
        }
    }
    
    private var centerImage: some View {
        HStack {
            Image(TrainingImageNames.trainingSwim.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth)
                .padding(.leading, imagePadding)
                .opacity(imageOpacity)
            Image(TrainingImageNames.trainingRide.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth)
                .padding(imagePadding)
                .opacity(imageOpacity)
            Image(TrainingImageNames.trainingRun.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth)
                .padding(imagePadding)
                .opacity(imageOpacity)
        }
    }
    
    private var loginStack: some View {
        HStack {
            VStack(alignment: .center) {
                
                TextField("Email address", text: $email)
                    .frame(width: 250)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                
                SecureField("Password", text: $password)
                    .frame(width: 250)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                
                Button {
                    loginVm.login(email: email, password: password)
                    email = ""
                    password = ""
                } label: {
                    Text("Log In")
                        .modifier(RegisterButtons())
                }
                .alert(isPresented: $loginVm.isNotValidLogin) {
                    Alert(title: Text("HHmmm?"), message: Text("Something's not quite right with your email or password. Try typing them in again"), dismissButton: .default(Text("Ok")))
                }
            }
            .padding()
            
           
        }
    }
    
   
    
    private var signUpStack: some View {
        HStack {
            VStack(alignment: .center) {
                
                TextField("Username", text: $userName)
                    .frame(width: 250)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                
                TextField("Email address", text: $signUpEmail)
                    .frame(width: 250)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                
                SecureField("Password", text: $signUpPassword)
                    .frame(width: 250)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                
                Button {
                    loginVm.signUp(name: userName, email: signUpEmail, password: signUpPassword)
                    userName = ""
                    signUpEmail = ""
                    signUpPassword = ""
                } label: {
                    Text("Create")
                        .modifier(RegisterButtons())
                }
                .alert(isPresented: $loginVm.isNotValidSignUp) {
                    Alert(title: Text("Uh?"), message: Text("Something is not right with your credentials. Try typing them in again"), dismissButton: .default(Text("Ok")))
                }
                
            }
            .padding()
            
//            Image(TrainingImageNames.trainingRun.rawValue)
//                .resizable()
//                .scaledToFit()
//                .frame(width: imageWidth)
//                .padding(imagePadding)
//                .opacity(imageOpacity)
                
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
