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
    @State var searchText = ""
    @State var isSearching = false
 
    
    var body: some View {
        NavigationView {
            ScrollView {
                //Search bar
                SearchBar(searchText: $searchText, isSearching: $isSearching)
            
                //Grid
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200),spacing: 12,alignment: .top),
                    GridItem(.flexible(minimum: 100, maximum: 200),spacing: 12,alignment: .top),
                    GridItem(.flexible(minimum: 100, maximum: 200),alignment: .top),
                ],  spacing: 12,  content: {
                    ForEach((vm.results).filter({"\($0)".contains(searchText) || searchText.isEmpty}), id: \.self){ rs in
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

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
                HStack{
                    TextField("Search terms here", text: $searchText)
                        .padding(.leading,24)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(.horizontal)
                .onTapGesture {
                    isSearching = true
                }
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Spacer()
                        if isSearching {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .padding(.vertical)
                            }
                            
                        }
                        
                    }.padding(.horizontal,32)
                        .foregroundColor(.gray)
                }
            
            if isSearching {
                Button {
                    isSearching = false
                    searchText = ""
                    
                    //Dismiss keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading,0)
                }
                .transition(.move(edge: .trailing))
            }
        }
    }
}
