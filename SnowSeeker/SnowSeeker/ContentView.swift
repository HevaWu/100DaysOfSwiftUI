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
    
    @State private var isShowFilterMenu = false
    
    @State private var selectedFilterType: FilterType = .none
    @State private var selectedFilterCountry: String = ""
    @State private var selectedFilterSize: String = ""
    @State private var selectedFilterPrice: String = ""
    
    @State private var onShowingList = [Resort]()
    
    let filterType: [FilterType] = [.none, .country, .size, .price]
    let sortType: [SortType] = [.original, .alphabetical, .country]
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationView {
            List(onShowingList) { resort in
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
                                Text(type.rawValue)
                            }
                        },
                        label: {
                            Text("Sort By")
                        }
                    )
                        .onChange(of: selectedSortType, perform: selectedSortByOnChange)
                },
                trailing: HStack {
                    Text("Filter By")
                        .foregroundColor(.blue)
                    
                    Picker(
                        selection: $selectedFilterType,
                        content: {
                            ForEach(filterType, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        },
                        label: {
                            Text("Filter By")
                        }
                    )
                        .onChange(of: selectedFilterType, perform: selectedFilterByOnChange)
                }
            )
            .actionSheet(isPresented: $isShowFilterMenu) {
                let (title, buttons) = getFilterMenuTitleAndButtons()
                return ActionSheet(
                    title: Text(title),
                    buttons: buttons
                )
            }
            .onAppear {
                loadList()
            }
            
            WelcomeView()
        }
        .phoneOnlyStackNavigationView()
        .environmentObject(favorites)
    }
    
    func selectedSortByOnChange(_ type: SortType) {
        loadList()
    }
    
    func selectedFilterByOnChange(_ type: FilterType) {
        if type == .none {
            isShowFilterMenu = false
            loadList()
        } else {
            isShowFilterMenu = true
        }
    }
    
    /// Put this in a single function to
    /// avoid auto-update when FilterType is not finished picking
    func loadList() {
        var sortedResorts: [Resort] {
            switch selectedSortType {
            case .original:
                return resorts
            case .alphabetical:
                return resorts.sorted { $0.name < $1.name }
            case .country:
                return resorts.sorted { $0.country < $1.country}
            }
        }
        
        var filteredResorts: [Resort] {
            switch selectedFilterType {
            case .none:
                return sortedResorts
            case .country:
                return sortedResorts.filter { $0.country == selectedFilterCountry }
            case .size:
                return sortedResorts.filter { $0.sizeType == selectedFilterSize }
            case .price:
                return sortedResorts.filter { $0.priceType == selectedFilterPrice }
            }
        }
        
        onShowingList = filteredResorts
    }
    
    func getFilterMenuTitleAndButtons() -> (title: String, buttons: [ActionSheet.Button]) {
        switch selectedFilterType {
        case .none:
            fatalError("Should not go into here")
        case .country:
            let buttons: [ActionSheet.Button] = Resort.allResortsCountry.map { country in
                ActionSheet.Button.default(Text(country), action: {
                    selectedFilterCountry = country
                    loadList()
                })
            }
            return ("Please Select Filter Country", buttons)
        case .size:
            let buttons: [ActionSheet.Button] = Resort.allSizeType.map { size in
                ActionSheet.Button.default(Text(size), action: {
                    selectedFilterSize = size
                    loadList()
                })
            }
            return ("Please Select Filter Size", buttons)
        case .price:
            let buttons: [ActionSheet.Button] = Resort.allPriceType.map { price in
                ActionSheet.Button.default(Text(price), action: {
                    selectedFilterPrice = price
                    loadList()
                })
            }
            return ("Please Select Filter Price", buttons)
        }
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
