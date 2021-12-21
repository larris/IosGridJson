//
//  ContentView.swift
//  GridApp
//
//  Created by Lazaros Fantidis on 21/12/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authenticationManager = AuthenticationManager() 
    var body: some View {
        NavigationView {
            VStack{
                if authenticationManager.isAuthenticated{
                    VStack{
//                        Title()
//                        Text("Welcome!! You are authenticated")
//                            .foregroundColor(.white)
//                        PrimaryButton(showImage: false, text: "Logout")
//                            .onTapGesture {
//                                authenticationManager.logout()
//                            }
                        GridView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(colors: [.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                } else {
                LoginView()
                    .environmentObject(authenticationManager)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $authenticationManager.showAlert) {
                Alert(title: Text("Error"), message: Text(authenticationManager.errorDescription ?? "Error trying to login with credentials"), dismissButton: .default(Text("Ok")))
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
