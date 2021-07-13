//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Melo, Lareen on 5/31/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section { // 3
                    Picker("Select your cake type", selection: $order.order.type) {
                        ForEach(0..<WrappedOrder.types.count, id: \.self) {
                            Text(WrappedOrder.types[$0])
                        }
                    }
                    // 3
                    Stepper(value: $order.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.order.quantity)")
                    }
                }
                
                Section {
                    // 3
                    Toggle(isOn: $order.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    // 3
                    if order.order.specialRequestEnabled {
                        Toggle(isOn: $order.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        // 3
                        Toggle(isOn: $order.order.addSprinkles) {
                            Text("Add sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details") 
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
