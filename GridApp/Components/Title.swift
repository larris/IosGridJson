//
//  Title.swift
//  GridApp
//
//  Created by Lazaros Fantidis on 21/12/2021.
//

import SwiftUI

struct Title: View {
    var body: some View {
        Text("Authentication")
            .bold()
            .font(.title)
            .foregroundColor(.white)
        
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title()
            .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomLeading))
    }
}
