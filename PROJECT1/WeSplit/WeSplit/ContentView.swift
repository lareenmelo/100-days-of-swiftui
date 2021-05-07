//
//  ContentView.swift
//  WeSplit
//
//  Created by Melo, Lareen on 4/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    // 3
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]

    // 2
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal

    }
    
    var totalPerPerson: Double {
        // 3
        let peopleCount = Double(numberOfPeople) ?? 1
        
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    // 3
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                
                Section(header: Text("Total amount")) { // 2
                    Text("$\(grandTotal, specifier: "%.2f")")
                    
                }
                
                Section(header: Text("Amount per person")) { // 1
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
