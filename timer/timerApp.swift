import SwiftUI

@main
struct timerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var timer: Timer?
    var startTime: Date?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the status item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem?.button {
            button.title = "⏱️ 00:00"
            button.action = #selector(menuBarButtonClicked)
        }
    }

    @objc func menuBarButtonClicked() {
        let menu = NSMenu()

        menu.addItem(NSMenuItem(title: "Start", action: #selector(startStopwatch), keyEquivalent: "S"))
        menu.addItem(NSMenuItem(title: "Stop", action: #selector(stopStopwatch), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "Q"))

        statusItem?.menu = menu
        statusItem?.button?.performClick(nil)
    }

    @objc func startStopwatch() {
        // Record the start time
        startTime = Date()

        // Invalidate any existing timer
        timer?.invalidate()

        // Start a new timer that updates the menu bar every second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @objc func stopStopwatch() {
        // Stop the timer
        timer?.invalidate()
        timer = nil

        // Reset the menu bar title
        statusItem?.button?.title = "⏱️ 00:00"
    }

    @objc func updateTime() {
        guard let startTime = startTime else { return }

        // Calculate the elapsed time
        let elapsedTime = Int(Date().timeIntervalSince(startTime))

        // Format elapsed time as MM:SS
        let minutes = elapsedTime / 60
        let seconds = elapsedTime % 60
        let formattedTime = String(format: "⏱️ %02d:%02d", minutes, seconds)

        // Update the menu bar item title
        statusItem?.button?.title = formattedTime
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}

