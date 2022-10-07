//
//  SwitchingTeamsPopupViewController.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 6.10.22.
//

import UIKit

class SwitchingTeamsPopupViewController: UIViewController {
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private var team: Team!
  // MARK: - Lifecycle
  private let teamNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.font = FontsManager.bold(ofSize: 40)
    label.adjustsFontSizeToFitWidth = true
    label.textColor = Colors.blue.color
    label.textAlignment = .center
    
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    addSubviews()
    setupConstraints()
  }
  // MARK: - API
  func setTeam(_ team: Team) {
    self.team = team
    teamNameLabel.text = team.name + Strings.Game.teamTurn
  }
  
  // MARK: - Setups
  private func setupUI() {
    view.backgroundColor = Colors.yellow.color
  }
  
  private func addSubviews() {
    view.addSubview(teamNameLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      teamNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      teamNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      teamNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      teamNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
    ])
  }
}
