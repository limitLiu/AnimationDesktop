//
//  Utils.swift
//  AnimationDesktop
//
//  Created by mac on 2021/9/9.
//

import Foundation

protocol BaseOperationWrapper {
  static func +(_ lhs: Self, _ rhs: Self) -> Self
  static func -(_ lhs: Self, _ rhs: Self) -> Self
//  static var kCGDesktopIconWindowLevel: Self { get }
}

protocol Into {
  func into() -> Int
}

extension Int32: BaseOperationWrapper {
//  static var kCGDesktopIconWindowLevel: Int32 = Int32.min + 5 + 20 + 20 - 1
  
  static func +(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    return lhs.addingReportingOverflow(rhs).partialValue
  }
  
  static func -(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    return lhs.subtractingReportingOverflow(rhs).partialValue
  }
}

extension Int32: Into {
  func into() -> Int {
    Int(self)
  }
}

@inlinable public var kCGDesktopIconWindowLevel: CGWindowLevel {
  return CGWindowLevelForKey(CGWindowLevelKey.desktopIconWindow)
}
