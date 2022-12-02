//
//  StatsViewController.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 6.10.22.
//

import UIKit

class StatsViewController: UIViewController {
  // MARK: - Properties
  // MARK: Public
  var teams: [Team]!
  
  // MARK: Private
  private let statsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.font = FontsManager.bold(ofSize: 40)
    label.text = Strings.Stats.gameStats;
    label.adjustsFontSizeToFitWidth = true
    label.textColor = Colors.yellow.color
    label.textAlignment = .center
    
    return label
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 10
    stackView.alignment = .fill
    
    return stackView
  }()
  
  private let finishButton: UIButton = {
    let button = UIButton()
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(Colors.blue.color, for: .normal)
    button.setTitle(Strings.Stats.toMenu, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.backgroundColor = Colors.yellow.color
    button.layer.cornerRadius = 10
    button.titleLabel?.font = FontsManager.bold(ofSize: 40)
    button.addTarget(self, action: #selector(endGame), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    addSubviews()
    setupConstraints()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.navigationItem.setHidesBackButton(true, animated: true)
    for team in teams {
      addTeamStats(team: team)
    }
  }
  
  // MARK: - Setups
  private func setupUI() {
    view.backgroundColor = Colors.blue.color
  }
  
  private func addSubviews() {
    view.addSubview(statsLabel)
    view.addSubview(stackView)
    view.addSubview(finishButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      statsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      statsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
      
      stackView.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      
      finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      finishButton.topAnchor.constraint(lessThanOrEqualTo: stackView.bottomAnchor, constant: 50),
      finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    ])
  }
  // MARK: - Helpers
  @objc
  private func endGame() {
    navigationController?.popToRootViewController(animated: true)
  }
  
  private func addTeamStats(team: Team) {
    let teamStatsView = TeamStatsView()
    teamStatsView.team = team
    stackView.addArrangedSubview(teamStatsView)
    NSLayoutConstraint.activate([
      teamStatsView.heightAnchor.constraint(equalToConstant: stackView.bounds.height / 6)
    ])
  }
}
