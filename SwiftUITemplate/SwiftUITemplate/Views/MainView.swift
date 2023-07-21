//
//  ContentView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewVM()

    @State var isInitialized = false

    var body: some View {
        Group {
            if isInitialized {
                mainView
            } else {
                LoadingView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isInitialized = true
            }
        }
    }

    var mainView: some View {
        Group {
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                TabView {
                    BaseTabItem(.home) {
                        BaseNavigation {
                            ToDoListView(userId: viewModel.currentUserId)
                        }
                    }

                    BaseTabItem(.profile) {
                        BaseNavigation {
                            ProfileView()
                        }
                    }
                }
            } else {
                BaseNavigation {
                    LoginView()
                }
            }
        }
    }
}

