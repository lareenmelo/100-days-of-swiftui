//
//  ContentView.swift
//  iExpense
//
//  Created by Melo, Lareen on 5/21/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        // 2
                        Text("$\(item.amount)")
                            .foregroundColor(style(amount: item.amount))
                            .fontWeight(.bold)
                        
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            // 1
            .navigationBarItems(leading: EditButton(), trailing:
                                    
                                    Button(action: {
                                        self.showingAddExpense = true
                                    }, label: {
                                        Image(systemName: "plus")
                                    })
                                    .sheet(isPresented: $showingAddExpense) {
                                        AddView(expenses: self.expenses)
                                    }
            )
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    // 2
    func style(amount: Int) -> Color {
        if amount <= 10 {
            return .green
        } else if amount <= 100 {
            return .orange
        } else {
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
