//
//  ContentView.swift
//  GridApp
//
//  Created by Lazaros Fantidis on 14/12/2021.
//

import SwiftUI
import Kingfisher


struct ContentView: View {
    
    @ObservedObject var vm = GridviewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200),spacing: 12,alignment: .top),
                    GridItem(.flexible(minimum: 100, maximum: 200),spacing: 12,alignment: .top),
                    GridItem(.flexible(minimum: 100, maximum: 200),alignment: .top),
                ],  spacing: 12,  content: {
                    ForEach(vm.results, id: \.self){ rs in
                        GridViewArtists(rs: rs)
                    }
                    
                }).padding(.horizontal,12)
            }.navigationTitle("Search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct GridViewArtists: View {
    let rs: Result
    var body: some View {
        VStack(alignment:.leading, spacing: 4.0) {
            KFImage(URL(string: rs.artworkUrl100))
                .scaledToFit()
                .cornerRadius(22)
            
            Text(rs.artistName)
                .font(.system(size: 10,weight: .semibold))
            Text(rs.name)
                .font(.system(size:9,weight: .regular))
            Text(rs.releaseDate)
                .font(.system(size: 9,weight:.regular))
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}
