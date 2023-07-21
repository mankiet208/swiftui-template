//
//  ToDoListVM.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ToDoListViewVM: BaseViewModel {
    @Published var showNewItemView = false
    @Published var toDoItems = [ToDoItem]()
    
    @Service private var toDoRepository: ToDoRepository
    
    private var listener: ListenerRegistration?
    
    deinit {
        listener?.remove()
    }
    
    func markAsDone(toDoId: String) async {
        Task {
            let uid = FirebaseManager.shared.getUserId()
            
            guard let uid = uid,
                  let index = toDoItems.firstIndex(where: {$0.id == toDoId }) else {
                return
            }
            
            let isDone = !toDoItems[index].isDone
            let result = await toDoRepository.markAsDone(uid: uid, toDoId: toDoId, isDone: isDone)
            
            if case .failure(let error) = result {
                await MainActor.run {
                    bannerData = BannerData(
                        title: "Error",
                        message: error.localizedDescription,
                        type: .error
                    )
                }
            }
        }
    }
    
    func fetchData() async {
        listener = toDoRepository.fetchData { [weak self] result in
            switch result {
            case .success(let items):
                self?.toDoItems = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

