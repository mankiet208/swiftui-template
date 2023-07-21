//
//  MainViewViewModel.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation
import FirebaseAuth

class MainViewVM: BaseViewModel {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    override init() {
        super.init()
        
        handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.currentUserId = user?.uid ?? ""
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
