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
    let imageWidth: CGFloat = 80
    let imagePadding: CGFloat = 30
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
    //@State private var reset: Bool = false
    @StateObject var loginVm = LoginViewModel()
    @State private var showCreateAccount: Bool = false
    @AppStorage(AppStor.signedIn.rawValue) var signedIn: Bool = false
    //@StateObject var loginState = LoginState()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                TriBackground()
                VStack {
                    Spacer()
                    headerStack
                    
                    centerImage
                    
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
        Image(TrainingImageNames.trainingSwim.rawValue)
            .resizable()
            .scaledToFit()
            .frame(width: imageWidth)
            .padding(.leading, imagePadding)
            .opacity(imageOpacity)
            Spacer()
        Text("TriSprint")
                .foregroundColor(Color.mainText)
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .padding()
            Spacer()
        }
    }
    
    private var centerImage: some View {
        Image(TrainingImageNames.trainingRide.rawValue)
            .resizable()
            .scaledToFit()
            .frame(width: imageWidth)
            .padding(imagePadding)
            .opacity(imageOpacity)
    }
    
    private var loginStack: some View {
        HStack {
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    TextField("Email address", text: $email)
                        .padding(textFieldPadding)
                        .background(Color.accentButton.opacity(textFieldOpacity))
                        .cornerRadius(textFieldCornerRadius)
                }
                HStack {
                    Spacer()
                    SecureField("Password", text: $password)
                        .padding(textFieldPadding)
                        .background(Color.accentButton.opacity(textFieldOpacity))
                        .cornerRadius(textFieldCornerRadius)
                }
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
            .padding(.leading,30)
            
            Image(TrainingImageNames.trainingRun.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth)
                .padding(imagePadding)
                .opacity(imageOpacity)
        
        }
    }
    
   
    
    private var signUpStack: some View {
        HStack {
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    TextField("Username", text: $userName)
                        .padding(textFieldPadding)
                        .background(Color.accentButton.opacity(textFieldOpacity))
                        .cornerRadius(textFieldCornerRadius)
                }
                HStack {
                    Spacer()
                TextField("Email address", text: $signUpEmail)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                }
                HStack {
                    Spacer()
                SecureField("Password", text: $signUpPassword)
                    .padding(textFieldPadding)
                    .background(Color.accentButton.opacity(textFieldOpacity))
                    .cornerRadius(textFieldCornerRadius)
                }
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
            .padding(.leading,30)
            
            Image(TrainingImageNames.trainingRun.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth)
                .padding(imagePadding)
                .opacity(imageOpacity)
                
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
