//
//  AppDelegate.swift
//  StatusBartender
//
//  Created by shsw228 on 2023/12/09
//

import AppKit
import SwiftUI
import SimplyCoreAudio

class AppDelegate: NSObject,NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover?
    private let simplyCA = SimplyCoreAudio()

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.windows.forEach{ $0.close() } // Close Window
        NSApp.setActivationPolicy(.accessory) // Hide App from Dock
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let button = statusItem.button!
        button.image = NSImage(systemSymbolName: "hifispeaker", accessibilityDescription: nil)
        button.title = simplyCA.defaultOutputDevice?.name ?? String(localized: "failed-get-device-name")
        button.action = #selector(showPopover)
        button.sendAction(on: [.leftMouseUp, .rightMouseUp])

        NotificationCenter.default.addObserver(self, selector: #selector(audioChanged), name: .defaultOutputDeviceChanged, object: nil)

    }

    @objc func audioChanged(_ sender: NotificationCenter) {
        Logger.standard.info(#function)
        guard let button = statusItem.button,
              let deviceName = simplyCA.defaultOutputDevice?.name else { return }
        button.title = deviceName
    }
    @objc func showPopover(_ sender: NSStatusBarButton) {
        guard let event = NSApp.currentEvent else { return }
        Logger.standard.info("\(String(describing: event))")
        switch event.type {
        case .rightMouseUp:
            let menu = NSMenu()
            menu.addItem(
                withTitle: String(localized: "quit-app", comment: "Button to Quit This App"),
                action: #selector(terminate),
                keyEquivalent: ""
            )
            statusItem.popUpMenu(menu)

        default:
            if popover == nil {
                let popover = NSPopover()
                self.popover = popover
                popover.behavior = .transient
                popover.contentViewController = NSHostingController(rootView: ContentView())
            }
            guard let popover else { return }
            popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
        }
    }
    @objc private func terminate() {
        NSApp.terminate(self)
    }
    @objc private func openPreferencesWindow(_ sender: NSMenuItem) {

    }
}
