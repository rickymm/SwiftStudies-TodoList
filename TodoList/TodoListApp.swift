//
//  TodoListApp.swift
//  TodoList
//
//  Created by Ricky Mafra Moino on 28/12/24.
//

import SwiftUI

@main
struct TodoListApp: App {
    @State private var listViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ListView()
            }
            .environment(listViewModel)
        }
    }
}
