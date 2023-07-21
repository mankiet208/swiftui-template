//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel = ToDoListViewVM()

    private let userId: String

    init(userId: String) {
        self.userId = userId
    }

    var body: some View {
        BaseView(title: "Home") {
            VStack {
                List($viewModel.toDoItems, id: \.id) { $item in
                    NavigationLink(value: Route.toDoDetail(toDo: item)) {
                        ToDoItemView(toDoItem: $item) {
                            Task {
                                await viewModel.markAsDone(toDoId: item.id)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .refreshable {
                    await viewModel.fetchData()
                }
            }
            .toolbar {
                Button {
                    viewModel.showNewItemView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.primaryColor)
                }
            }
            .sheet(isPresented: $viewModel.showNewItemView) {
                NewItemView(isPresented: $viewModel.showNewItemView)
            }
            .task {
                await viewModel.fetchData()
            }
            .banner(data: $viewModel.bannerData)
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "")
    }
}
