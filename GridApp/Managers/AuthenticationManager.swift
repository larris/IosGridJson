//
//  AuthenticationManager.swift
//  GridApp
//
//  Created by Lazaros Fantidis on 21/12/2021.
//

import Foundation
import LocalAuthentication

class AuthenticationManager:ObservableObject{
    private(set) var context = LAContext()
    @Published private(set) var biometryType: LABiometryType = .none
    @Published private(set) var isAuthenticated = false
    @Published private(set) var errorDescription: String?
    @Published var showAlert = false
    private(set) var canEvaluatePolicy = false
    
    
    init(){
        getBiometryType()
    }
    
    func getBiometryType() {
        canEvaluatePolicy =  context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        biometryType = context.biometryType
    }
    
    func authenticateWithBiometrics() async {
        context = LAContext()
        
        if canEvaluatePolicy{
            let reason = "Log into your account"
            
            do {
               let success =  try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                if success{
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        print("isAuthenticated",self.isAuthenticated)
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.showAlert = true
                    self.biometryType = .none
                }
            }
        }
    }
    
    
    func authenticateWithCredentials(username: String, password: String){
        if username.lowercased() == "lazaros" && password == "12345" {
            isAuthenticated = true
        } else {
            errorDescription = " Wrong Credentials"
            showAlert = true
        }
    }
    
    func logout(){
        isAuthenticated = false
    }
}
