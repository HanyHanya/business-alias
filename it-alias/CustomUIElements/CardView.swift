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
    label.textAlignment = .center
    label.font = FontsManager.bold(ofSize: 20)
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    
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
  
  func setCorners(_ maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]) {
    self.layer.maskedCorners = maskedCorners
  }
  
  func isShadowEnabled(_ isEnabled: Bool) {
    switch isEnabled {
    case true:
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOpacity = 1
      self.layer.shadowOffset = .zero
      self.layer.shadowRadius = 10
      self.layer.shouldRasterize = true
      self.layer.rasterizationScale = UIScreen.main.scale
    case false:
      self.layer.shadowOffset = .zero
      self.layer.shadowColor = UIColor.clear.cgColor
      self.layer.shadowRadius = 0
      self.layer.shadowOpacity = 0
    }
  }
  
  // MARK: - Setups
  private func setupUI() {
    self.backgroundColor = Colors.yellow.color
    self.layer.cornerRadius = 20
    
    setCorners()
    isShadowEnabled(true)
  }
  
  private func addSubviews() {
    self.addSubview(wordLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      wordLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      wordLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      wordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      wordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
    ])
  }
  // MARK: - Helpers
}
