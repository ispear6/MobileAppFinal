//
//  AddExpense.swift
//  ExpenseTracker
//
//  Created by Isaac Spear on 5/6/21.
//

import SwiftUI

struct AddExpense: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    let categories = ["Travel", "Food", "Materials", "Tools"]
    @State var name = ""
    @State var amount = ""
    @State var category = ""
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Double(self.amount) {
                    let item = Expense(id: UUID(), amount: actualAmount, category: category, name: name)
                    expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showAlert = true
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error!"), message: Text("Invalid amount value"), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense(expenses: Expenses())
    }
}
