//
//  DesktopWindow.swift
//  AnimationDesktop
//
//  Created by mac on 2021/9/11.
//

import Cocoa

class DesktopWindow: NSWindow {
  init() {
    super.init(contentRect: NSRect(x: 0, y: 0, width: 16, height: 9), styleMask: .borderless, backing: .buffered, defer: false)
    title = ""
    ignoresMouseEvents = true
    level = NSWindow.Level(rawValue: (kCGDesktopIconWindowLevel - 1).into())
    center()
    setFrame(screen!.frame, display: true)
    makeKeyAndOrderFront(nil)
  }
}
