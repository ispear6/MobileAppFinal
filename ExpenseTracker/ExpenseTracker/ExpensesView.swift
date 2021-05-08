//
//  ExpensesView.swift
//  ExpenseTracker
//
//  Created by Isaac Spear on 5/6/21.
//

import SwiftUI

struct ExpensesView: View {
    @ObservedObject var expenses = Expenses()
    @State var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text(item.category)
                        Spacer()
                        Text(String(format: "$%.2f", item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarItems(
                trailing: Button(action: {
                    self.showingAddExpense = true
                }, label: { Image(systemName: "plus")
            }))
            .sheet(isPresented: $showingAddExpense) {
                AddExpense(expenses: self.expenses)
            }
            .navigationBarTitle(Text("Expenses"), displayMode: .inline)
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(expenses: Expenses())
    }
}
