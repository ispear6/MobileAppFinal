//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Isaac Spear on 5/6/21.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id = UUID()
    var amount: Double
    var category: String
    var name: String
}

class Expenses: ObservableObject {
    @Published var items = [Expense]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "ExpensesItems")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "ExpensesItems") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Expense].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}
