//
//  AppDelegate.swift
//  AnimationDesktop
//
//  Created by mac on 2021/9/8.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
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
      // TODO 没有选择文件时弹出警告
    }
  }
  
  @objc func selectFile() {
    // TODO 动态设置文件
    AnimatedDesktop.shared.path = "/Users/mac/Movies/Animation Wallpaper/12.28.mp4"
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
