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
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Colors.blue.color
    let _ = teams.map { $0.delegate  = self }
    
    setupCompletions()
    addSubviews()
    setupConstraints()
  }
  
  // MARK: - API
  // MARK: - Setups
  private func setupCompletions() {
    addTeamView.addTeam = {
      let teamView = TeamView()
      teamView.delegate = self
      
      self.teams.append(teamView)
      self.teamsStackView.removeArrangedSubview(self.addTeamView)
      self.teamsStackView.addArrangedSubview(teamView)
      self.teamsStackView.addArrangedSubview(self.addTeamView)
      if self.teams.count == 4 {
        self.teamsStackView.removeArrangedSubview(self.addTeamView)
        self.addTeamView.removeFromSuperview()
      }
    }
  }
  private func addSubviews() {
    view.addSubview(teamsLabel)
    view.addSubview(teamsStackView)
    let _ = teams.map { teamsStackView.addArrangedSubview($0) }
    teamsStackView.addArrangedSubview(addTeamView)
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
    ])
  }
  // MARK: - Helpers
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
  }
}
