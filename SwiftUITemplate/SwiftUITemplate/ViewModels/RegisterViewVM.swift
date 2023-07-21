//
//  RegisterViewVM.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewVM: BaseViewModel {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    @Service private var userRepository: UserRepository
    
    func register() async {
        guard validate() else {
            // TODO: Handle error
            return
        }
        
        let result = await userRepository.createUser(email: email, password: password)
        
        guard let uid = try? result.get() else {
            // TODO: Handle error
            return
        }
        
        let user = User(
            id: uid,
            name: name,
            email: email,
            createdAt: Date().timeIntervalSince1970
        )
        
        _ = await userRepository.setUser(uid: uid, user: user)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty else {
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
