//
//  iOS_AppApp.swift
//  iOS-App
//
//

import SwiftUI
import RealmSwift

@main
struct iOS_AppApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environment(\.realmConfiguration, Realm.Configuration( /* ... */ ))
            LoginView()
        }
    }
}
