//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Lareen Melo on 7/18/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    // challenge 3
    enum SortOption {
        case name, date
    }
    
    let filter: FilterType
    @State var sort: SortOption = .date // challenge 3
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortActionSheet = false // challenge 3
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
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
    
    // challenge 3
    var sortedProspects: [Prospect] {
        switch sort {
        case .name:
            return filteredProspects.sorted {$0.name < $1.name }
        case .date:
            return filteredProspects.sorted {$0.date > $1.date }
        }
    }

    let simulatedData = ["Paul Hudson\npaul@hackingwithswift.com", "Taylor Swift\ntaylor@hackingwithswift.com", "Taylor Swift\ntaylor@hackingwithswift.com", "Tim Apple\ntim@hackingwithswift.com"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        // challenge 1
                        HStack {
                            VStack(alignment: .leading) {
                                Text(prospect.name)
                                    .font(.headline)
                                Text(prospect.emailAddress)
                                    .foregroundColor(.secondary)
                            }
                            if filter == .none {
                                Spacer()
                                Image(systemName: prospect.isContacted ?  "checkmark.square" : "square")
                                    .padding(.trailing)
                            }
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button(action: { // challenge 3
                self.isShowingSortActionSheet = true
            }, label: {
                Image(systemName: "arrow.up.arrow.down.square")
                Text("Sort")

            }), trailing: Button(action: {
                self.isShowingScanner = true

                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: self.simulatedData.randomElement()!, completion: self.handleScan)
            }
            // challenge 3
            .actionSheet(isPresented: $isShowingSortActionSheet) {
                ActionSheet(title: Text("Sort list by"), buttons: [
                    .default(Text("Name"), action: { self.sort = .name }),
                    .default(Text("Recently added"), action: { self.sort = .date })
                ])
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]

            self.prospects.add(person)

        case .failure(let error):
            print("Scanning failed")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // testing

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
                        print("D'oh")
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
