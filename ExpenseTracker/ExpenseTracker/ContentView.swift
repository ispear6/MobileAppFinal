//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Isaac Spear on 5/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var showingMood = true
    @ObservedObject var orders = Orders()
    @State var nextOrder = UserDefaults.standard.integer(forKey: "nextorder")
    @State var selectedItem = 0
    @State var showingOrder = false
    
    static let orderDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        let item = Order(orderNumber: nextOrder + 1, name: "Default Name", phoneNumber: "0000000000", quotedPrice: "$00.00", deliverBy: Date(), delivered: false, invoiceSent: false, paymentReceived: false)
        NavigationView {
            VStack {
                Text(Date(), style: .date)
                    .font(.title)
                Text("No pressure, no diamonds. -Thomas Carlyle")
                    .font(.footnote)
                if(showingMood == true) {
                    Text("How are you feeling?")
                    HStack {
                        Spacer()
                        Button(action: {showingMood = false}, label: {
                            Text("😀")
                        })
                        Spacer()
                        Button(action: {showingMood = false}, label: {
                            Text("😐")
                        })
                        Spacer()
                        Button(action: {showingMood = false}, label: {
                            Text("🙁")
                        })
                        Spacer()
                    }
                }
                Spacer()
                List {
                    ForEach(orders.items.sorted { $0.deliverBy < $1.deliverBy}) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(String(format: "%03d", item.orderNumber))
                                    .font(.headline)
                                Text("\(item.deliverBy, formatter: ContentView.orderDateFormat)")
                            }
                            
                            Spacer()
                            VStack {
                                Text(item.name)
                                Button(action: {
                                    selectedItem = orders.items.firstIndex(of: item) ?? 0
                                    self.showingOrder = true
                                }, label: { Text("More Info >")
                                    .foregroundColor(.blue)
                            })
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                    self.orders.items.append(item)
                    nextOrder += 1
                    UserDefaults.standard.set(self.nextOrder, forKey: "nextorder")
                }) {
                    Image(systemName: "plus")
                },
                trailing: NavigationLink(destination: ExpensesView(expenses: Expenses()), label: { Text("Expenses")
            }))
            .sheet(isPresented: $showingOrder) {
                OrderEdit(orders: Orders(), selectedItem: $selectedItem)
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
        }
    }
    func removeItems(at offsets: IndexSet) {
        orders.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
