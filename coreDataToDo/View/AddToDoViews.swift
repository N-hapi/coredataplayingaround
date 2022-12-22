//
//  AddToDoViews.swift
//  coreDataToDo
//
//  Created by Nael Alshowaikh on 18.12.22.
//

import SwiftUI

struct AddToDoViews: View {
    // MARK: properties
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"

    let priorities = ["High", "Normal", "Low"]

// MARK: Body
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: TODO Name
                    TextField("Todo", text: $name)
                    // MARK: - TODO priority
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    //MARK: - Save Button
                    Button(action: {
                        print("save button pressed")
                    }) {
                        Text("Save")
                    }//: Save button
                }//: FORM
                Spacer()
            }//: Vstack
            
            .navigationBarTitle("new todo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action:{
                self.presentationMode.wrappedValue.dismiss()
            }){Image(systemName: "xmark")})
        }//: Nabigation
        
    }
}


// MARK: preview

struct AddToDoViews_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoViews()
    }
}
