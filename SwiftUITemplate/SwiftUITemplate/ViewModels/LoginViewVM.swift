//
//  LoginViewVM.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation
import FirebaseAuth

class LoginViewVM: BaseViewModel {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    @Service private var userRepository: UserRepository
    
    func login() async {
        Task { @MainActor in
            guard validate() else {
                return
            }
            
            _ = await userRepository.signIn(email: email, password: password)
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all field"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email"
            return false
        }
        
        return true
    }
}
