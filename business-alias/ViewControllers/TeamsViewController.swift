//
//  TeamsViewController.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 2.09.22.
//

import UIKit

class TeamsViewController: UIViewController {
  // MARK: - Outlets
  // MARK: - Actions
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private var teams = [TeamView(), TeamView()]
  private var isEnoughTeams = false
  
  private let teamsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.font = FontsManager.bold(ofSize: 40)
    label.text = Strings.Teams.addTeams
    label.adjustsFontSizeToFitWidth = true
    label.textColor = Colors.yellow.color
    label.textAlignment = .center
    
    return label
  }()
  
  private let teamsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    stackView.alignment = .fill
    
    return stackView
  }()
  
  private let addTeamView = AddTeamView()
  
  private let startGameButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.layer.cornerRadius = 10
    button.backgroundColor = Colors.yellow.color
    button.setTitleColor(Colors.blue.color, for: .normal)
    button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    button.setTitle(Strings.Teams.startGame, for: .normal)
    button.titleLabel?.font = FontsManager.bold(ofSize: 40)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    
    return button
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Colors.blue.color
    let _ = teams.map { teamView in
      teamView.delegate  = self
      teamView.isEnoughTeams = isEnoughTeams
    }
    
    setupCompletions()
    addSubviews()
    setupConstraints()
  }
  
  // MARK: - API
  // MARK: - Setups
  private func setupCompletions() {
    addTeamView.addTeam = { [weak self] in
      guard let strongSelf = self else { return }
      let teamView = TeamView()
      teamView.delegate = self
      
      strongSelf.teams.append(teamView)
      strongSelf.teamsStackView.removeArrangedSubview(strongSelf.addTeamView)
      strongSelf.teamsStackView.addArrangedSubview(teamView)
      strongSelf.teamsStackView.addArrangedSubview(strongSelf.addTeamView)
      if strongSelf.teams.count == 4 {
        strongSelf.teamsStackView.removeArrangedSubview(strongSelf.addTeamView)
        strongSelf.addTeamView.removeFromSuperview()
      }
      
      if strongSelf.teams.count > 2 {
        strongSelf.isEnoughTeams = true
        let _ = strongSelf.teams.map { $0.isEnoughTeams = strongSelf.isEnoughTeams }
      }
    }
  }
  private func addSubviews() {
    view.addSubview(teamsLabel)
    view.addSubview(teamsStackView)
    let _ = teams.map { teamsStackView.addArrangedSubview($0) }
    teamsStackView.addArrangedSubview(addTeamView)
    view.addSubview(startGameButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      teamsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      teamsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
      teamsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
      teamsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      teamsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      teamsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      teamsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      teamsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      
      startGameButton.topAnchor.constraint(greaterThanOrEqualTo: teamsStackView.bottomAnchor, constant: 100),
      startGameButton.widthAnchor.constraint(equalToConstant: 120),
      startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    ])
  }
  // MARK: - Helpers
  @objc
  private func startGame() {
    let vc = GameViewController()
    let teams = teams.map { $0.team }
    vc.teams = teams
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension TeamsViewController: TeamViewDelegate {
  func deleteView(_ view: TeamView) {
    let teamsToLeave = teams.filter { $0 != view }
    teamsStackView.removeArrangedSubview(view)
    view.removeFromSuperview()
    teams = teamsToLeave

    if teams.count < 4 && !addTeamView.isDescendant(of: teamsStackView) {
      teamsStackView.addArrangedSubview(addTeamView)
    }
    
    if teams.count <= 2 {
      isEnoughTeams = false
      let _ = teams.map { $0.isEnoughTeams = isEnoughTeams }
    }
  }
}
