//
//  AddTeamView.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 15.09.22.
//

import UIKit

class AddTeamView: UIView {
  // MARK: - Properties
  // MARK: Public
  var addTeam: (() -> ())?
  // MARK: Private
  private enum Constants {
    static let addTeam = UIImage(systemName: "plus.app")
  }
  
  private let tapGestureRecognizer: UITapGestureRecognizer = {
    let tapGestureRecognizer = UITapGestureRecognizer()

    
    return tapGestureRecognizer
  }()
    
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fillProportionally
    
    return stackView
  }()
  
  private let teamImageView: UIImageView = {
    let imageView = UIImageView()
    
    imageView.image = Constants.addTeam
    
    return imageView
  }()
  
  private let addTeamLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.text = Strings.AddTeamView.addTeam
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.font = FontsManager.semiBold(ofSize: 25)
    label.textColor = Colors.blue.color
    
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
  
  // MARK: - Setups
  private func commonInit() {
    setupUI()
    addSubviews()
    setupConstraints()
    
  }
  
  private func setupUI() {
    backgroundColor = Colors.yellow.color
    layer.cornerRadius = 10
    
    tapGestureRecognizer.addTarget(self, action: #selector(addTeamEvent(_:)))    
    self.addGestureRecognizer(tapGestureRecognizer)
  }
  
  private func addSubviews() {
    self.addSubview(stackView)
    stackView.addArrangedSubview(teamImageView)
    stackView.addArrangedSubview(addTeamLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      teamImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 10),
      teamImageView.heightAnchor.constraint(equalTo: teamImageView.widthAnchor),
      stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
      stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
    ])
  }
  
  // MARK: - Helpers
  @objc
  func addTeamEvent(_ sender: UITapGestureRecognizer) {
    addTeam?()
  }
}
