//
//  ContentView2.swift
//  coreDataToDo
//
//  Created by Nael Alshowaikh on 18.12.22.
//

import SwiftUI

struct ContentView2: View {
    // MARK: - properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingAddTodoView: Bool = false


    // MARK: Body
    var body: some View {

        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }//: List
            .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                    // Show add todo view
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus")
                }//: Add button
                    .sheet(isPresented: $showingAddTodoView){
                        AddToDoViews().environment(\.managedObjectContext, self.managedObjectContext )
                    }

            )
        }//: Navigation
    }
}

// MARK: - preview

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2().previewDevice("iphone 14 pro")
    }
}
