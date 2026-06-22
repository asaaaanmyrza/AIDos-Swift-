//
//  AIDosApp.swift
//  AIDos
//
//  Created by Асан Мырзахметов on 15.06.2026.
//

import SwiftUI

@main
struct AIDosApp: App {
    @StateObject private var authVM = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
        }
    }
}
