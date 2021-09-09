//
//  AnimatedDesktop.swift
//  AnimationDesktop
//
//  Created by mac on 2021/9/8.
//

import Cocoa
import AVKit

class AnimatedDesktop: NSObject {
  var window: NSWindow?
  let playerView: AVPlayerView = AVPlayerView()
  var player: AVPlayer?
  var path: String?
  
  static let shared = AnimatedDesktop()
  private override init() {}
  override class func copy() -> Any { return self }
  override class func mutableCopy() -> Any { return self }
  
  func run() -> Void {
    if window != nil { return }
    let styleMask: NSWindow.StyleMask = [.titled, .resizable, .closable, .fullScreen]
    
    window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 1920, height: 1080), styleMask: styleMask, backing: .buffered, defer: false)
    
    let file = URL(fileURLWithPath: path!)
    player = AVPlayer(url: file)
    window?.title = ""
    window?.ignoresMouseEvents = true
    
    window?.level = NSWindow.Level(rawValue: Int32.kCGDesktopIconWindowLevel.into())

    window?.center()
    window?.setFrame(window!.screen!.frame, display: true)
    window?.makeKeyAndOrderFront(nil)
    
    playerView.controlsStyle = .none
    playerView.videoGravity = .resizeAspectFill
    playerView.player = player
    player?.isMuted = true
    
    player?.play()
    window?.contentView = playerView
    
    NotificationCenter.default.addObserver(self, selector: #selector(loop), name: .AVPlayerItemDidPlayToEndTime, object: nil)
  }
  
  @objc func loop() -> Void {
    player?.seek(to: .zero)
    player?.play()
  }
  
}
