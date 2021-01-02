//
//  ContentView.swift
//  WeSplit
//
//  Created by Jorge Gonzalez on 12/18/20.
//

import SwiftUI

struct TipResult {
    var tipValue: Double
    var grandTotal: Double
    var amountPerPerson: Double
    
    init(numberOfPeople: Int, tip: Int, orderAmount: String) {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tip)
        let orderAmount = Double(orderAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        self.tipValue = tipValue
        self.grandTotal = grandTotal
        self.amountPerPerson = amountPerPerson
    }
}

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var result: TipResult {
        return TipResult(numberOfPeople: numberOfPeople, tip: tipPercentages[tipPercentage], orderAmount: checkAmount)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                
                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach(2 ..< 15) {
                        Text("\($0) people")
                    }
                }.pickerStyle(InlinePickerStyle())
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person:")) {
                    Text("$\(result.amountPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total Tip:")) {
                    Text("$\(result.tipValue, specifier: "%.2f")")
                }
                
                Section(header: Text("Grand Total:")) {
                    Text("$\(result.grandTotal, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
