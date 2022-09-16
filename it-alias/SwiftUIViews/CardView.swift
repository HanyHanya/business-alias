//
//  CardView.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 16.09.22.
//

import SwiftUI

struct CardView: View {
  let prompt: String
    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .stroke(Color.black, lineWidth: 5)
          .background(RoundedRectangle(cornerRadius: 16).fill(Colors.yellow.swiftUIColor))
        Text(prompt)
          .font(.largeTitle)
          .fontWeight(.semibold)
      }
      .frame(width: 280, height: 400, alignment: .center)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
      CardView(prompt: "qwerty")
    }
}
