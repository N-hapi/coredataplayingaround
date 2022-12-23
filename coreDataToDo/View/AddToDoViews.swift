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
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"

    let priorities = ["High", "Normal", "Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""

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
                        if self.name != ""{
                            print("save button pressed")
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                       
                        
                        
                        do{
                            try self.managedObjectContext.save()
                            print("New todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
                        }catch{
                            print(error)
                        }
                        }else {
                            self.errorShowing = true
                            self.errorTitle = "invalide name"
                            self.errorMessage = "enter something for the todo item"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                        
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
            .alert(isPresented: $errorShowing){
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("ok")))
                
            }
        }//: Nabigation
        
    }
}


// MARK: preview

struct AddToDoViews_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoViews().previewDevice("iphone 14 pro")
    }
}
