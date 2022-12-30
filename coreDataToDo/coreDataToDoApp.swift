//
//  coreDataToDoApp.swift
//  coreDataToDo
//
//  Created by Nael Alshowaikh on 12.12.22.
//

import SwiftUI

@main
struct coreDataToDoApp: App {
    //let persistenceController = PersistenceController.shared
    @StateObject private var dataController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
