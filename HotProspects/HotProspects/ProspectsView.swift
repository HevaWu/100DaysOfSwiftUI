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
    
    enum SortType {
        case name
        case recent
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowScanner = false
    @State private var sortType: SortType = .recent
    @State private var isShowSortMenu = false
    
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
    
    var sortedProspects: [Prospect] {
        switch sortType {
        case .name:
            return prospects.people.sorted(by: { $0.name < $1.name })
        case .recent:
            return prospects.people.reversed()
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return sortedProspects
        case .contacted:
            return sortedProspects.filter { $0.isContacted }
        case .uncontacted:
            return sortedProspects.filter { !$0.isContacted }
        }
    }
    
    var simulateName: String {
        "test\(Int.random(in: 0..<10))"
    }
    
    var simulateEmail: String {
        "test_email_\(Int.random(in: 0..<10))@email.com"
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        if case .none = filter {
                            Image(systemName: prospect.isContacted ? "person.crop.circle.fill" : "person.crop.circle.badge.plus")
                        }
                        
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text(title))
            .navigationBarItems(
                leading: Button(action: {
                    isShowSortMenu = true
                }, label: {
                    Text("Sort By")
                }),
                trailing: Button(action: {
                    isShowScanner = true
                }, label: {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
            )
            .sheet(isPresented: $isShowScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "\(simulateName)\n\(simulateEmail)", completion: handleScan(result:))
            }
            .actionSheet(isPresented: $isShowSortMenu) {
                ActionSheet(
                    title: Text("Select Sort Type"),
                    buttons: [
                        .default(Text("Name")) {
                            sortType = .name
                        },
                        .default(Text("Recent")) {
                            sortType = .recent
                        }
                    ]
                )
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
            
            prospects.add(person)
        case .failure(let error):
            print("Scanning Failed \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Fail")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
