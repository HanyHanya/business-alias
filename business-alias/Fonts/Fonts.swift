//
//  FontsManager.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 02.09.22.
//

import UIKit

enum FontsManager {
  static func bold(ofSize size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .bold)
  }
  
  static func black(ofSize size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .black)
  }
  
  static func ultraLight(ofSize size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .ultraLight)
  }
  
  static func light(ofSize size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .light)
  }
  
  static func medium(ofSize size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .medium)
  }
  
  static func regular(ofSize size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .regular)
  }
  
  static func semiBold(ofSize size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .semibold)
  }
}
