//
//  UserRepository.swift
//  ToDoList
//
//  Created by Kiet Truong on 28/06/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol UserRepository {
    func getUser(uid: String) async -> Result<User?, Error>
    func setUser(uid: String, user: User) async -> Result<Void, Error>
    func createUser(email: String, password: String) async -> Result<String?, Error>
    func signIn(email: String, password: String) async -> Result<Void, Error>
    func signOut() -> Result<Void, Error>
}

struct UserRepositoryFirestore: UserRepository {
    
    func getUser(uid: String) async -> Result<User?, Error> {
        do {
            let documentRef = Firestore.firestore()
                .collection("users")
                .document(uid)
            let document = try await documentRef.getDocument()
            
            guard let data = document.data() else {
                return .success(nil)
            }
            
            return .success(User(data: data))
        } catch {
            return .failure(error)
        }
    }
    
    func setUser(uid: String, user: User) async -> Result<Void, Error> {
        do {
            let documentRef = Firestore.firestore()
                .collection("users")
                .document(uid)
            try await documentRef.setData(user.toDict())
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func createUser(email: String, password: String) async -> Result<String?, Error> {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            return .success(result.user.uid)
        } catch {
            return .failure(error)
        }
    }
    
    func signIn(email: String, password: String) async -> Result<Void, Error> {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func signOut() -> Result<Void, Error> {
        do {
            try Auth.auth().signOut()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
