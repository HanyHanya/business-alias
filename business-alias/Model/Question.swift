//
//  Question.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 10.10.22.
//

import Foundation
import RealmSwift

final class Question: Object {
  @Persisted(primaryKey: true) var _id: ObjectId
  @Persisted var russianString: String = ""
  @Persisted var englishString: String = ""
}
