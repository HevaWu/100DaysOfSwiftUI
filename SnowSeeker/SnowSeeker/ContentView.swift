//
//  ContentView.swift
//  SnowSeeker
//
//  Created by He Wu on 2021/11/29.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    
    @State private var selectedSortType: SortType = .original
    
    var currentOnShowResorts: [Resort] {
        switch selectedSortType {
        case .original:
            return resorts
        case .alphabetical:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country}
        }
    }
    
    let sortType: [SortType] = [.original, .alphabetical, .country]
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
        
    var body: some View {
        NavigationView {
            List(currentOnShowResorts) { resort in
                NavigationLink(destination: {
                    ResortView(resort: resort)
                }, label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                })
            }
            .navigationTitle("Resorts")
            .navigationBarItems(
                leading: HStack {
                    Text("Sort By")
                        .foregroundColor(.blue)
                    
                    Picker(
                        selection: $selectedSortType,
                        content: {
                            ForEach(sortType, id: \.self) { type in
                                Button(type.rawValue) {
                                    selectedSortType = type
                                }
                            }
                        },
                        label: {
                            Text("Sort By")
                        }
                    )
                }
            )
            
            WelcomeView()
        }
        .phoneOnlyStackNavigationView()
        .environmentObject(favorites)
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
