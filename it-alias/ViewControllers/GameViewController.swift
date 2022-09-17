//
//  GameViewController.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 17.09.22.
//

import UIKit

class GameViewController: UIViewController {

  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private let cardStack = UIView()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.spacing = 40
    
    return stackView
  }()
  
  private let card: CardView = {
    let card = CardView()
    card.translatesAutoresizingMaskIntoConstraints = false
    
    card.setWord("qwerty")
    
    return card
  }()
  
  private let firstBackgroundCard: CardView = {
    let card = CardView()
    card.translatesAutoresizingMaskIntoConstraints = false
    
    return card
  }()
  
  private let secondBackgroundCard: CardView = {
    let card = CardView()
    card.translatesAutoresizingMaskIntoConstraints = false
    
    return card
  }()
  
  private let wrongAnswerCard: CardView = {
    let card = CardView()
    card.translatesAutoresizingMaskIntoConstraints = false
    card.backgroundColor = Colors.red.color
    
    return card
  }()
  
  private let rightAnswerCard: CardView = {
    let card = CardView()
    card.translatesAutoresizingMaskIntoConstraints = false
    card.backgroundColor = Colors.green.color
    
    return card
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    addSubviews()
    setupConstraints()
  }
  
  // MARK: - API
  // MARK: - Setups
  private func setupUI() {
    view.backgroundColor = Colors.blue.color
  }
  
  private func addSubviews() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(wrongAnswerCard)
    stackView.addArrangedSubview(cardStack)
    cardStack.addSubview(card)
    cardStack.addSubview(firstBackgroundCard)
    cardStack.addSubview(secondBackgroundCard)
    stackView.addArrangedSubview(rightAnswerCard)
  }
  
  private func setupConstraints() {
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      wrongAnswerCard.heightAnchor.constraint(equalToConstant: view.frame.height / 2.5),
      wrongAnswerCard.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
      
      cardStack.heightAnchor.constraint(equalToConstant: view.frame.height / 2.5),
      cardStack.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
      
      card.heightAnchor.constraint(equalToConstant: view.frame.height / 2.5),
      card.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
      
      rightAnswerCard.heightAnchor.constraint(equalToConstant: view.frame.height / 2.5),
      rightAnswerCard.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
    ])
  }
  // MARK: - Helpers
  
}
