//
//  FilterAndSortView.swift
//  SnowSeeker
//
//  Created by Lareen Melo on 8/27/21.
//

import SwiftUI

enum Sort {
    case defaultSort
    case alphabetical
    case country
}

struct FilterAndSortView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var resorts: [Resort]
    @Binding var sort: Sort
    @Binding var countryFilter: String
    @Binding var priceFilter: Int
    @Binding var sizeFilter: Int

    private var countries: [String] {
        var uniqueCountries = Set(resorts.map({$0.country}))
        uniqueCountries.insert("All")
        return uniqueCountries.sorted()
    }
    
    private var prices: [Int] {
        var uniquePrices = Set(resorts.map({$0.price}))
        uniquePrices.insert(0)

        return uniquePrices.sorted()
    }
    
    private var sizes: [Int] {
        var uniqueSizes = Set(resorts.map({$0.size}))
        uniqueSizes.insert(0)
        return uniqueSizes.sorted()
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort your results by")) {
                    Picker("Sort resorts", selection: self.$sort) {
                        Text("Default").tag(Sort.defaultSort)
                        Text("Name").tag(Sort.alphabetical)
                        Text("Country").tag(Sort.country)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Section(header: Text("Filter your results by")) {
                        Picker("Country", selection: self.$countryFilter) {
                            ForEach(countries) {
                                Text($0)
                            }
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Picker("Size", selection: self.$sizeFilter) {
                            ForEach(sizes, id: \.self) {
                                Text(getSize($0))
                            }
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Picker("Price", selection: self.$priceFilter) {
                            ForEach(prices, id: \.self) {
                                Text($0 == 0 ? "All" : String(repeating: "$", count: $0))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                }
                .navigationBarTitle(Text("Sort and Filter"))
                .navigationBarItems(trailing: Button(
                    action: { self.presentationMode.wrappedValue.dismiss() },
                    label: { Text("Done").padding(15) }
                ))
            }
        }
    }
    
    
    func getSize(_ number: Int) -> String {
        switch number {
        case 0:
            return "All"
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
}

struct FilterAndSortView_Previews: PreviewProvider {
    static var previews: some View {
        FilterAndSortView(resorts: Bundle.main.decode("resorts.json"), sort: .constant(.defaultSort), countryFilter: .constant("USA"), priceFilter: .constant(0) , sizeFilter: .constant(2))
    }
}

