//
//  LoginViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 02.12.21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

class LoginViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var isNotValidSignUp: Bool = false
    @Published var isNotValidLogin: Bool = false
    @AppStorage(AppStor.signedIn.rawValue) var signedIn: Bool = false
  
    
    func login(email: String, password: String) {
        
        auth.signIn(withEmail: email, password: password) { user, error in
            if error != nil {
                print("Error signing in",error?.localizedDescription ?? "")
                self.isNotValidLogin = true
                self.signedIn = false
               
            } else if user == nil {
                self.signedIn = false
                self.isNotValidLogin = true
            } else {
              
                self.signedIn = true
            }
            
        }
    }
    
    func signUp(name: String, email: String, password: String) {
        if isValidEmail(email: email) && isValidPassword(password: password) {
            auth.createUser(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else { return }
                self.addUserToFirebase(name: name, email: email)
                self.signedIn = true
            }
        } else {
            isNotValidSignUp = true
        }
        
    }
    
    private func addUserToFirebase(name: String, email: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference()
        let usersRef = ref.child("users").child(uid)
        let values = ["username": name, "email": email]
        usersRef.updateChildValues(values) { (err, ref) in
            if err != nil {
                print("Error registering user details",err as Any)
            }
            print("Nige: User details registered successfully")
        }
    }
    
    func isValidEmail(email:String?) -> Bool {
           guard email != nil else { return false }
           //Requires text before the @, text after the @ and 2 characters after the '.'
           let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
           return pred.evaluate(with: email)
       }
       
       func isValidPassword(password:String?) -> Bool {
           guard password != nil else { return false }
           // at least one digit
           // 8 characters total
           let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[0-9]).{8,}")
           return passwordTest.evaluate(with: password)
       }
    
}
