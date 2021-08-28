//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Lareen Melo on 8/24/21.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @ObservedObject var favorites = Favorites()
    
    // 3
    @State private var isPresentingSortAndFilterMenu = false
    @State var sortSelection: Sort = .defaultSort
    @State var countrySelected = "All"
    @State var priceSelected = 0
    @State var sizeSelected = 0

    var sorted: [Resort] {
        switch sortSelection {
        case .defaultSort:
            return resorts
        case .alphabetical:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        }
    }
    
    
    var sortedAndFiltered: [Resort] {
        var list = sorted
        list = filteredCountries(resorts: sorted)
        list = filteredSizes(resorts: list)
        list = filteredPrices(resorts: list)

        return list
    }
    
    var body: some View {
        NavigationView {
            List(sortedAndFiltered) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
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
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .sheet(isPresented: $isPresentingSortAndFilterMenu, content: {
                FilterAndSortView(resorts: sorted, sort: self.$sortSelection, countryFilter: self.$countrySelected, priceFilter: self.$priceSelected, sizeFilter: self.$sizeSelected)
            })
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: Button(action: {
                isPresentingSortAndFilterMenu = true
            }, label: {
                HStack {
                    Image(systemName: "arrow.up.arrow.down.circle")
                    Image(systemName: "line.horizontal.3.decrease.circle")
                }
            })
            )
            WelcomeView()
        }
        .environmentObject(favorites)
    }
    
//     apply filters
    func filteredCountries(resorts: [Resort]) -> [Resort] {
        filter(resorts: resorts, selection: countrySelected, valuePath: \.country)
    }

    func filteredSizes(resorts: [Resort]) -> [Resort] {
        return filter(resorts: resorts, selection: sizeSelected, valuePath: \.size)
    }

    func filteredPrices(resorts: [Resort]) -> [Resort] {
        return filter(resorts: resorts, selection: priceSelected, valuePath: \.price)
    }

    func filter(resorts: [Resort],
                selection: String,
                valuePath: KeyPath<Resort, String>) -> [Resort] {

        if selection == "All" {
            return resorts
        }

        var list = [Resort]()
        for resort in resorts {
            if selection == resort[keyPath: valuePath] {
                list.append(resort)
            }
        }

        return list
    }
    
    func filter(resorts: [Resort],
                selection: Int,
                valuePath: KeyPath<Resort, Int>) -> [Resort] {

        if selection == 0 {
            return resorts
        }

        var list = [Resort]()
        for resort in resorts {
            if selection == resort[keyPath: valuePath] {
                list.append(resort)
            }
        }

        return list
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
