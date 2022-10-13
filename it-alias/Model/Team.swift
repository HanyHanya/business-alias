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
  var name: String
  var rightAnswers: Int
  var wrongAnswers: Int
  
  init(id: UUID = UUID(), name: String, rightAnswers: Int = 0, wrongAnswers: Int = 0) {
    self.id = id
    self.name = name
    self.rightAnswers = 0
    self.wrongAnswers = 0
  }
}
