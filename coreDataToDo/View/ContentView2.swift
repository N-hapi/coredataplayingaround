//
//  ContentView2.swift
//  coreDataToDo
//
//  Created by Nael Alshowaikh on 18.12.22.
//

import SwiftUI
import CoreData

struct ContentView2: View {
    // MARK: - properties
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    
    @State private var showingAddTodoView: Bool = false


    // MARK: Body
    var body: some View {

        NavigationView {
            List {
                
                ForEach(self.todos, id: \.self){
                    todo in
                    HStack{
                        Text(todo.name ?? "Uknowns")
                        
                        Spacer()
                        
                        Text(todo.priority ?? "uknown")
                        
                    }
                }//:foreach
                
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
//        let context = (UIApplication.shared.delegate).PersistenceController.viewContext
        let persistenceController = PersistenceController.shared
        ContentView2().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
            //.environment(\.managedObjectContext, persistenceController.container.viewContext)
//            .environment(\.managedObjectContext, context)
            
            
            .previewDevice("iphone 14 pro")
    }
}
