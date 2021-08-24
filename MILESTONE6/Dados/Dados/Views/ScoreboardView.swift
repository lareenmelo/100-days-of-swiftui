//
//  ScoreboardView.swift
//  Dados
//
//  Created by Lareen Melo on 8/17/21.
//

import SwiftUI
import CoreData

enum Sorts {
    
}

struct ScoreboardView: View {
    @State private var sortFromNewestDate = true
    @State private var descriptor: NSSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
    
    var body: some View {
        NavigationView {
            SortedList(sortDescripter: descriptor, newestToOldest: sortFromNewestDate)
                .navigationBarTitle("Scores", displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.sortFromNewestDate.toggle()
                                            self.changeSortOption()
                                        }, label: {
                                            Image(systemName: "arrow.up.arrow.down")
                                        })
                                    
                )
        }
    }
    
    func changeSortOption() {
        if sortFromNewestDate {
            descriptor = NSSortDescriptor(key: "date", ascending: true)
            
        } else {
            descriptor = NSSortDescriptor(key: "date", ascending: false)
            
        }
        
    }
}

struct ListHeader: View {
    var message: String
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "die.face.6")
                .rotationEffect(.degrees(60))
            Text("Scores sorted by: \(message)")
            Image(systemName: "die.face.6")
                .rotationEffect(.degrees(60))
        }
    }
}

struct SortedList: View {
    @FetchRequest var results: FetchedResults<Die>
    var resultsHeader: String
    
    init(sortDescripter: NSSortDescriptor, newestToOldest: Bool) {
        let request: NSFetchRequest<Die> = Die.fetchRequest()
        request.sortDescriptors = [sortDescripter]
        
        resultsHeader = newestToOldest ? "Oldest to Newest" : "Newest to Oldest"
        _results = FetchRequest<Die>(fetchRequest: request)
    }
    
    
    var body: some View {
        List {
            Section(header: ListHeader(message: resultsHeader)) {
                ForEach(results, id: \.self) { result in
                    Text("\(result.number)")
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}
