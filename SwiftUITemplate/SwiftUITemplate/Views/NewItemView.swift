//
//  NewItemView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewVM()
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack() {
                Text("Add new todo")
                    .font(.system(size: 32))
                    .bold()
                
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding()
          
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(.graphical)
                
                // Button
                TDButton(title: "Save", backgroundColor: .blue) {
                    if viewModel.canSave {
                        Task {
                            await viewModel.save()
                            isPresented = false
                        }
                    } else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill all fields")
                )
            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(isPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
