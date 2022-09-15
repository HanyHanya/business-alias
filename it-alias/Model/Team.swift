//
//  Team.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 4.09.22.
//

import Foundation
import UIKit

struct Team {
  let id: UUID
  var image: UIImage
  var name: String
  
  init(id: UUID = UUID(), image: UIImage, name: String) {
    self.id = id
    self.image = UIImage()
    self.name = name
  }
}
