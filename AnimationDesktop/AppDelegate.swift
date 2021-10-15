//
//  AppDelegate.swift
//  AnimationDesktop
//
//  Created by mac on 2021/9/8.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  let notification = NSUserNotification()
  let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    if let button = statusItem.button {
      button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
    }
    constructMenu()
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  @objc func animate(_ sender: Any?) {
    let animatedDesktop = AnimatedDesktop.shared
    if animatedDesktop.path != nil {
      animatedDesktop.run()
    } else {
      notification.identifier = "alert"
      notification.actionButtonTitle = "I got it!"
      notification.informativeText = "Plz select a video file!"
      notification.soundName = NSUserNotificationDefaultSoundName
      NSUserNotificationCenter.default.deliver(notification)
    }
  }
  
  @objc func selectFile() {
    let panel = NSOpenPanel()
    panel.directoryURL = URL(string: "\(NSHomeDirectory())/Movies")
    panel.allowsMultipleSelection = false
    panel.allowedFileTypes = ["mp4"]
    if panel.runModal() == NSApplication.ModalResponse.OK {
      let path = panel.url?.path
      UserDefaults.standard.set(path, forKey: "path")
      AnimatedDesktop.shared.path = path
    }
  }
  
  private func constructMenu() {
    let menu = NSMenu()
    menu.addItem(NSMenuItem(title: "Start Animation Desktop", action: #selector(AppDelegate.animate(_:)), keyEquivalent: "S"))
    menu.addItem(NSMenuItem(title: "Select Video File", action: #selector(AppDelegate.selectFile), keyEquivalent: "O"))
    menu.addItem(NSMenuItem.separator())
    menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    statusItem.menu = menu
  }

}
