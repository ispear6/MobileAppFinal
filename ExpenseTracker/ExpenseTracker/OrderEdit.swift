//
//  OrderEdit.swift
//  ExpenseTracker
//
//  Created by Isaac Spear on 5/6/21.
//

import SwiftUI

struct OrderEdit: View {
    @ObservedObject var orders: Orders
    @Binding var selectedItem: Int
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Name:")
                    TextField("Name", text: $orders.items[selectedItem].name)
                }
                HStack {
                    Text("Phone:")
                    TextField("Phone #", text: $orders.items[selectedItem].phoneNumber)
                        .keyboardType(.numberPad)
                }
                HStack {
                    Text("Price:")
                    TextField("Quoted Price", text: $orders.items[selectedItem].quotedPrice).keyboardType(.decimalPad)
                }
                DatePicker(
                    "Due Date",
                    selection: $orders.items[selectedItem].deliverBy
                )
                Toggle(isOn: $orders.items[selectedItem].delivered, label: {
                    Text("Delivered")
                })
                Toggle(isOn: $orders.items[selectedItem].invoiceSent, label: {
                    Text("Invoice Sent")
                })
                Toggle(isOn: $orders.items[selectedItem].paymentReceived, label: {
                    Text("Payment Receieved")
                })
            }
        }
        .navigationBarTitle("\(orders.items[selectedItem].orderNumber)")
    }
}

struct OrderEdit_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: 0) var selectedItem: Int
        
        var body: some View {
            OrderEdit(orders: Orders(), selectedItem: $selectedItem)
        }
    }
}
