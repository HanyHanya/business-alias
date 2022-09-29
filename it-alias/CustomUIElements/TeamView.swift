//
//  TeamView.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 2.09.22.
//

import UIKit

class TeamView: UIView {
  // MARK: - Properties
  // MARK: Public
  var delegate: TeamViewDelegate? = nil
  // MARK: Private
  
  private enum Constants {
    static let deleteImage = UIImage(systemName: "trash")
  }
  
  var team = Team(image: UIImage(), name: Strings.TeamView.teamName)
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    
    return stackView
  }()
  
  private let teamImageView: UIImageView = {
    let imageView = UIImageView()
    
    imageView.backgroundColor = .red
    
    return imageView
  }()
  
  private let teamNameTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    textField.text = Strings.TeamView.teamName
    textField.font = FontsManager.semiBold(ofSize: 25)
    textField.textColor = Colors.blue.color
    
    return textField
  }()
  
  private let deleteButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.setImage(Constants.deleteImage, for: .normal)
    button.addTarget(self, action: #selector(deleteView), for: .touchUpInside)
    
    return button
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
  
  // MARK: - API
  func setTeam(_ team: Team) {
    teamImageView.image = team.image
    teamNameTextField.text = team.name
  }
  
  // MARK: - Setups
  private func commonInit() {
    setupUI()
    addSubviews()
    setupConstraints()
    teamNameTextField.delegate = self
    
    setTeam(team)
  }
  
  private func setupUI() {
    backgroundColor = Colors.yellow.color
    layer.cornerRadius = 10
  }
  
  private func addSubviews() {
    self.addSubview(stackView)
    stackView.addArrangedSubview(teamImageView)
    stackView.addArrangedSubview(teamNameTextField)
    stackView.addArrangedSubview(deleteButton)
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
  private func deleteView() {
    delegate?.deleteView(self)
  }
}


extension TeamView: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let text = textField.text else { return }
    team.name = text
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else { return false }
    return text.count + string.count <= 15
  }
}
