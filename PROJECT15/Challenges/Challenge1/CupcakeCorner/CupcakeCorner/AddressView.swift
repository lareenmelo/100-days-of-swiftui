//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Melo, Lareen on 5/31/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                // 3
                TextField("Name", text: $order.order.name)
                TextField("Street Address", text: $order.order.streetAddress)
                TextField("City", text: $order.order.city)
                TextField("Zip", text: $order.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Checkout")
                }
            }
            // 3
            .disabled(order.order.hasValidAddress == false && order.order.hasValidInformation == false) // 1
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
