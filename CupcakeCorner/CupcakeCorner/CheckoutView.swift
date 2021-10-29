//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by He Wu on 2021/10/01.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: OrderViewModel
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibilityHidden(true)
                    
                    Text("Your total is $\(order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showConfirmation) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            print("Failed to encode order.")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                alertTitle = "Error"
                self.alertMessage = "No data in response: \(error?.localizedDescription ?? "Unknown Error")"
                showConfirmation = true
                return
            }
            
            if let decoded = try? JSONDecoder().decode(Order.self, from: data) {
                alertTitle = "Thank you"
                self.alertMessage = "Your Order for \(decoded.quantity) x \(Order.types[decoded.type].lowercased()) cupcakes is on its way!"
                showConfirmation = true
            } else {
                alertTitle = "Error"
                self.alertMessage = "Invalid request from server"
                showConfirmation = true
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderViewModel())
    }
}
