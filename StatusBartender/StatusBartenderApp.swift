//
//  StatusBartenderApp.swift
//  StatusBartender
//
//  Created by shsw228 on 2023/12/09
//


import SwiftUI
import SimplyCoreAudio

@main
struct StatusBartenderApp: App {
#if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
#endif
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
