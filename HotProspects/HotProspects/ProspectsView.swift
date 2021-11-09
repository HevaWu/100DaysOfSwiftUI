//
//  ProspectsView.swift
//  HotProspects
//
//  Created by He Wu on 2021/11/08.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {
    
    enum FilterType {
        case none
        case contacted
        case uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowScanner = false
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
                .navigationBarTitle(Text(title))
                .navigationBarItems(trailing: Button(action: {
                    isShowScanner = true
                }, label: {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
                )
                .sheet(isPresented: $isShowScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "test\ntest@email.com", completion: handleScan(result:))
                }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            prospects.people.append(person)
        case .failure(let error):
            print("Scanning Failed \(error.localizedDescription)")
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
