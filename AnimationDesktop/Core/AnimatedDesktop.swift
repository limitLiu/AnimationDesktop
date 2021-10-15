//
//  AnimatedDesktop.swift
//  AnimationDesktop
//
//  Created by mac on 2021/9/8.
//

import Cocoa
import AVKit

class AnimatedDesktop: NSObject {
  var window: DesktopWindow?
  let playerView: AVPlayerView = AVPlayerView()
  var player: AVPlayer?
  var path: String? = UserDefaults.standard.string(forKey: "path")

  static let shared = AnimatedDesktop()
  private override init() {}
  override class func copy() -> Any { return self }
  override class func mutableCopy() -> Any { return self }

  func run() -> Void {
    if window != nil { return }

    let file = URL(fileURLWithPath: path!)
    player = AVPlayer(url: file)
    window = DesktopWindow()

    playerView.controlsStyle = .none
    playerView.videoGravity = .resizeAspectFill
    playerView.player = player
    player?.isMuted = true
    player?.play()

    window?.contentView = playerView

    NotificationCenter
        .default
        .addObserver(
            self,
            selector: #selector(loop),
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
          )
  }

  @objc func loop() -> Void {
    player?.seek(to: .zero)
    player?.play()
  }

}
