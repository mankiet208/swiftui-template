//
//  SwiftUITemplateApp.swift
//  SwiftUITemplate
//
//  Created by Kiet Truong on 04/07/2023.
//

import SwiftUI
import FirebaseCore

@main
struct SwiftUITemplateApp: App {
    
    init() {
        FirebaseApp.configure()
        setupServiceContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .accentColor(.primaryColor)
        }
    }
}

private extension SwiftUITemplateApp {

    func setupServiceContainer() {
        ServiceContainer.register(type: UserRepository.self, UserRepositoryFirestore())
        ServiceContainer.register(type: ToDoRepository.self, ToDoRepositoryFirestore())
    }
}
