//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Melo, Lareen on 5/31/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    
    // 2
    @State private var showingAlert = false
    @State private var errorMessage = ""
    @State var showingErrorMessage = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(hidden: true)
                    // 3
                    Text("Your total is $\(self.order.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        // 2
        .alert(isPresented: $showingAlert) {
            if showingErrorMessage {
                return Alert(title: Text("D'oh"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                
            } else {
                return Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.order) else { // 3
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("No data response in: \(error?.localizedDescription ?? "Unknown error").")
                // 2
                self.showingAlert = true
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                self.showingErrorMessage = true
                return
            }
            // 3
            if let decodedOrder = try? JSONDecoder().decode(WrappedOrder.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(WrappedOrder.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
                self.showingAlert = true

            } else {
                print("Invalid response from server")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
