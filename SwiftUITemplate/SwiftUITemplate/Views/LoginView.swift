//
//  LoginView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewVM()

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "TO DO",
                           subtitle: "Never miss a thing",
                           angle: 15,
                           backgroundColor: .orange)
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                // Form
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                                        
                    TDButton(title: "Login", backgroundColor: .blue) {
                        Task {
                            await viewModel.login()
                        }
                    }
                }
                
                // Register
                VStack {
                    Text("New around here?")
//                    NavigationLink("Create an account", destination: RegisterView())
                    NavigationLink(value: Route.register) {
                        Text("Create an account")
                    }
                }
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
