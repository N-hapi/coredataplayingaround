//
//  ContentView2.swift
//  coreDataToDo
//
//  Created by Nael Alshowaikh on 18.12.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
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
                .onDelete(perform: deleteTodo)
                
            }//: List
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(leading: EditButton(), trailing:
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
    private func deleteTodo(at offsets: IndexSet){
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            do {
                try managedObjectContext.save()
            }
            catch{
                print(error)
                
            }
        }
    }
    
}

// MARK: - preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        let persistenceController = PersistenceController.preview
        ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            .previewDevice("iphone 14 pro")
    }
}
