//
//  ContentView.swift
//  PA1
//
//  Created by Joshua Muehring on 1/28/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isSignedIn: Bool = false
    var body: some View {
        VStack {
            if isSignedIn {
                Text("Welcome to College Rides")
                    .font(.largeTitle)
                    .padding()
                Button("Sign Out") {
                    signOut()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            } else {
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                Button("Sign In") {
                    signIn()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Register") {
                    signUp()
                }
                .padding()
            }
            
        }
        .padding()
    }
    
    func signOut() {
            do {
                try Auth.auth().signOut()
                isSignedIn = false
            } catch {
                errorMessage = "Error signing out: \(error.localizedDescription)"
            }
        }

        func signIn() {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    isSignedIn = true
                    errorMessage = ""
                }
            }
        }

        func signUp() {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    isSignedIn = true
                    errorMessage = ""
                }
            }
        }
}

#Preview {
    ContentView()
}
