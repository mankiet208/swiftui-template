//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation

class ProfileViewVM: BaseViewModel {
   
    @Service private var userRepository: UserRepository
    
    func logOut() {
        _ = userRepository.signOut()
    }
}
