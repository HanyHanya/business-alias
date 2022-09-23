//
//  CardView.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 17.09.22.
//

import UIKit

final class CardView: UIView {
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private let wordLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.textColor = Colors.blue.color
    label.adjustsFontSizeToFitWidth = true
    
    return label
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    setupUI()
    addSubviews()
    setupConstraints()
  }
  
  // MARK: - API
  func setWord(_ word: String) {
    wordLabel.text = word
  }
  
  // MARK: - Setups
  private func setupUI() {
    self.backgroundColor = Colors.yellow.color
    self.layer.cornerRadius = 20
    self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 1
    self.layer.shadowOffset = .zero
    self.layer.shadowRadius = 10
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = UIScreen.main.scale
  }
  
  private func addSubviews() {
    self.addSubview(wordLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      wordLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      wordLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])
  }
  // MARK: - Helpers
}
