//
//  Order.swift
//  ExpenseTracker
//
//  Created by Isaac Spear on 5/6/21.
//

import Foundation

struct Order: Identifiable, Equatable, Codable {
    var id = UUID()
    var orderNumber: Int
    var name: String
    var phoneNumber: String
    var quotedPrice: String
    var deliverBy: Date
    var delivered: Bool
    var invoiceSent: Bool
    var paymentReceived: Bool
}

class Orders: ObservableObject {
    @Published var items = [Order]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Order].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}
