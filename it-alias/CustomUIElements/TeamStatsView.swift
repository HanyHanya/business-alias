//
//  TeamStatsView.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 7.10.22.
//

import UIKit

class TeamStatsView: UIView {
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  var team: Team! {
    didSet {
      teamNameLabel.text = team.name
      wrongAnswersLabel.text = Strings.TeamStats.wrongAnswers + String(team.wrongAnswers)
      rightAnswersLabel.text = Strings.TeamStats.rightAnswers + String(team.rightAnswers)
      totalScoreLabel.text = String(team.rightAnswers - team.wrongAnswers)
    }
  }
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
    
    return stackView
  }()
  
  private let scoreStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    
    return stackView
  }()
  
  private let teamNameLabel: UILabel = {
    let label = UILabel()
    
    label.font = FontsManager.semiBold(ofSize: 25)
    label.adjustsFontSizeToFitWidth = true
    label.textColor = Colors.blue.color
    
    return label
  }()
  
  private let wrongAnswersLabel: UILabel = {
    let label = UILabel()
    
    
    label.font = FontsManager.semiBold(ofSize: 14)
    label.adjustsFontSizeToFitWidth = true
    label.textColor = Colors.blue.color
    
    return label
  }()
  
  private let rightAnswersLabel: UILabel = {
    let label = UILabel()
    
    
    label.font = FontsManager.semiBold(ofSize: 14)
    label.adjustsFontSizeToFitWidth = true
    label.textColor = Colors.blue.color
    
    return label
  }()
  
  private let totalScoreLabel: UILabel = {
    let label = UILabel()
    
    label.font = FontsManager.bold(ofSize: 20)
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
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
  }
  
  private func addSubviews() {
    addSubview(stackView)
    stackView.addArrangedSubview(teamNameLabel)
    stackView.addArrangedSubview(scoreStackView)
    scoreStackView.addArrangedSubview(wrongAnswersLabel)
    scoreStackView.addArrangedSubview(rightAnswersLabel)
    stackView.addArrangedSubview(totalScoreLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
