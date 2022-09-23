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
  private var initialCenter: CGPoint = .zero
  private let panGestureRecognizer = UIPanGestureRecognizer()
  private let cardStack = UIView()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.spacing = 50
    
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
    card.setCorners([.layerMaxXMaxYCorner])
    card.setShadows(false)
    
    return card
  }()
  
  private let rightAnswerCard: CardView = {
    let card = CardView()
    card.translatesAutoresizingMaskIntoConstraints = false
    card.backgroundColor = Colors.green.color
    card.setCorners([.layerMinXMinYCorner])
    card.setShadows(false)
    
    return card
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    addSubviews()
    setupConstraints()
    basicAnimation()
  }
  
  // MARK: - API
  // MARK: - Setups
  private func setupUI() {
    view.backgroundColor = Colors.blue.color
    panGestureRecognizer.addTarget(self, action: #selector(dragCard))
    card.addGestureRecognizer(panGestureRecognizer)
  }
  
  private func addSubviews() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(wrongAnswerCard)
    stackView.addArrangedSubview(cardStack)
    cardStack.addSubview(firstBackgroundCard)
    cardStack.addSubview(secondBackgroundCard)
    cardStack.addSubview(card)
    stackView.addArrangedSubview(rightAnswerCard)
    stackView.bringSubviewToFront(cardStack)
  }
  
  private func basicAnimation() {
    UIView.animate(withDuration: 1, delay: 0.0, options: .curveLinear) { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.firstBackgroundCard.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 10)
      strongSelf.secondBackgroundCard.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 12)
    }
  }
  
  private func setupConstraints() {
    
    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      wrongAnswerCard.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      wrongAnswerCard.widthAnchor.constraint(equalToConstant: view.bounds.width / 12),
      
      cardStack.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      cardStack.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      
      card.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      card.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      
      firstBackgroundCard.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      firstBackgroundCard.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      
      secondBackgroundCard.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      secondBackgroundCard.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      
      rightAnswerCard.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      rightAnswerCard.widthAnchor.constraint(equalToConstant: view.bounds.width / 12),
    ])
  }
  // MARK: - Helpers
  @objc
  private func dragCard(_ sender: UIPanGestureRecognizer) {
    guard let cardView = sender.view else { return }
    
    switch sender.state {
    case .began:
      initialCenter = cardView.center
      
    case .changed:
      let translation = sender.translation(in: view)
      cardView.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
      
    case .ended, .cancelled:
      UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) { [weak self] in
        guard let strongSelf = self else { return }
        cardView.center = strongSelf.initialCenter
      }
      initialCenter = .zero
      
    default:
      return
    }
  }
}
