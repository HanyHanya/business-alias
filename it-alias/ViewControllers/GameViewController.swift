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
  var teams = [Team]()
  // MARK: Private
  private enum Constants {
    static let ruLocale = "ru"
    static let enLocale = "en"
  }
  private var currentTeam = 0
  private var initialCenter: CGPoint = .zero
  private let panGestureRecognizer = UIPanGestureRecognizer()
  
  private let questionsRepository: QuestionsRepository = RealmRepository.instance
  private var questionsStrings: [String]!
  private var questionCards = [CardView]()
  
  private let dateComponentsFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    
    formatter.allowedUnits = .second
    
    return formatter
  }()
  
  private let timerCountdownLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.font = FontsManager.bold(ofSize: 40)
    label.adjustsFontSizeToFitWidth = true
    label.textColor = Colors.yellow.color
    label.textAlignment = .center
    
    return label
  }()
  
  private let cardStack: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  private let foregroundCardStack: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  private let backgroundCardStack: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.spacing = 50
    
    return stackView
  }()
  
  private let firstQuestionCard: CardView = {
    let card = CardView()
    card.translatesAutoresizingMaskIntoConstraints = false
        
    return card
  }()
  
  private let secondQuestionCard: CardView = {
    let card = CardView()
    card.translatesAutoresizingMaskIntoConstraints = false
        
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
    card.isShadowEnabled(false)
    
    return card
  }()
  
  private let rightAnswerCard: CardView = {
    let card = CardView()
    card.translatesAutoresizingMaskIntoConstraints = false
    card.backgroundColor = Colors.green.color
    card.setCorners([.layerMinXMinYCorner])
    card.isShadowEnabled(false)
    
    return card
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupQuestions()
    addSubviews()
    setupConstraints()
    basicAnimation()
    startGamePopup(teamIndex: currentTeam)
  }
  
  // MARK: - API
  // MARK: - Setups
  private func setupUI() {
    view.backgroundColor = Colors.blue.color
    panGestureRecognizer.addTarget(self, action: #selector(dragCard))
    secondQuestionCard.addGestureRecognizer(panGestureRecognizer)
    firstQuestionCard.addGestureRecognizer(panGestureRecognizer)
  }
  
  private func setupQuestions() {
    guard
      let languageCode = Locale.current.languageCode
    else {
      questionsStrings = questionsRepository.getAll().map { $0.englishString }
      
      guard !questionsStrings.isEmpty else { return }
      firstQuestionCard.setWord(questionsStrings.removeFirst())
      secondQuestionCard.setWord(questionsStrings.removeFirst())
      
      return
    }
    
    switch languageCode.lowercased() {
    case Constants.enLocale:
      questionsStrings = questionsRepository.getAllEnglish().shuffled()
    case Constants.ruLocale:
      questionsStrings = questionsRepository.getAllRussian().shuffled()
    default:
      return
    }
    
    guard !questionsStrings.isEmpty else { return }
    
    firstQuestionCard.setWord(questionsStrings.removeFirst())
    secondQuestionCard.setWord(questionsStrings.removeFirst())
  }
  
  private func addSubviews() {
    view.addSubview(timerCountdownLabel)
    view.addSubview(stackView)
    stackView.addArrangedSubview(wrongAnswerCard)
    backgroundCardStack.addSubview(firstBackgroundCard)
    backgroundCardStack.addSubview(secondBackgroundCard)
    
    // Managing UIPanGestureRecognizer with the array of cards
    foregroundCardStack.addSubview(secondQuestionCard)
    foregroundCardStack.addSubview(firstQuestionCard)
    questionCards.append(firstQuestionCard)
    questionCards.append(secondQuestionCard)
    
    cardStack.addSubview(backgroundCardStack)
    cardStack.addSubview(foregroundCardStack)
    stackView.addArrangedSubview(cardStack)
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
      timerCountdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      timerCountdownLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      timerCountdownLabel.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.topAnchor),
      
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      wrongAnswerCard.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      wrongAnswerCard.widthAnchor.constraint(equalToConstant: view.bounds.width / 12),
      
      cardStack.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      cardStack.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      
      backgroundCardStack.heightAnchor.constraint(equalTo: cardStack.heightAnchor),
      backgroundCardStack.widthAnchor.constraint(equalTo: cardStack.widthAnchor),
      backgroundCardStack.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
      backgroundCardStack.centerYAnchor.constraint(equalTo: cardStack.centerYAnchor),
      
      foregroundCardStack.heightAnchor.constraint(equalTo: cardStack.heightAnchor),
      foregroundCardStack.widthAnchor.constraint(equalTo: cardStack.widthAnchor),
      foregroundCardStack.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
      foregroundCardStack.centerYAnchor.constraint(equalTo: cardStack.centerYAnchor),
      
      firstQuestionCard.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      firstQuestionCard.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      firstQuestionCard.centerXAnchor.constraint(equalTo: foregroundCardStack.centerXAnchor),
      firstQuestionCard.centerYAnchor.constraint(equalTo: foregroundCardStack.centerYAnchor),
      
      secondQuestionCard.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      secondQuestionCard.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      secondQuestionCard.centerXAnchor.constraint(equalTo: foregroundCardStack.centerXAnchor),
      secondQuestionCard.centerYAnchor.constraint(equalTo: foregroundCardStack.centerYAnchor),
      
      firstBackgroundCard.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      firstBackgroundCard.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      firstBackgroundCard.centerXAnchor.constraint(equalTo: backgroundCardStack.centerXAnchor),
      firstBackgroundCard.centerYAnchor.constraint(equalTo: backgroundCardStack.centerYAnchor),
      
      secondBackgroundCard.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      secondBackgroundCard.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      secondBackgroundCard.centerXAnchor.constraint(equalTo: backgroundCardStack.centerXAnchor),
      secondBackgroundCard.centerYAnchor.constraint(equalTo: backgroundCardStack.centerYAnchor),
      
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
      
    case .cancelled:
      returnView(cardView, initialCenter: initialCenter)
      initialCenter = .zero
      
    case .ended:
      if cardView.center.x <= -50 {
        teams[currentTeam].wrongAnswers += 1
        removeView(cardView, initialCenter: initialCenter)
        initialCenter = .zero
      } else if cardView.center.x >= 180 {
        teams[currentTeam].rightAnswers += 1
        removeView(cardView, initialCenter: initialCenter)
        initialCenter = .zero
      } else {
        returnView(cardView, initialCenter: initialCenter)
      }
      
    default:
      return
    }
  }
  
  private func returnView(_ view: UIView, initialCenter: CGPoint) {
    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
      view.center = initialCenter
    }
  }
  
  private func removeView(_ view: UIView, initialCenter: CGPoint) {
    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear) {
      view.layer.opacity = 0
    } completion: { [weak self] finished in
      guard let strongSelf = self else { return }
      if finished {
        guard !strongSelf.questionsStrings.isEmpty
        else {
          strongSelf.endGame()
          return
        }
        
        let card = strongSelf.makeCardWithText(strongSelf.questionsStrings.removeFirst())
        strongSelf.addCard(card)
        let cardToPan = strongSelf.questionCards.count - 2
        strongSelf.questionCards[cardToPan].addGestureRecognizer(strongSelf.panGestureRecognizer)
        view.removeFromSuperview()
        strongSelf.questionCards.removeFirst()
      } else {
        strongSelf.returnView(view, initialCenter: initialCenter)
      }
    }
  }
  
  private func makeCardWithText(_ text: String) -> CardView {
    let card: CardView = {
      let card = CardView()
      card.translatesAutoresizingMaskIntoConstraints = false
      
      card.setWord(text)
      
      return card
    }()
    
    return card
  }
  
  private func addCard(_ card: CardView) {
    questionCards.append(card)
    foregroundCardStack.addSubview(card)
    foregroundCardStack.sendSubviewToBack(card)
    NSLayoutConstraint.activate([
      card.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
      card.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
      card.centerXAnchor.constraint(equalTo: foregroundCardStack.centerXAnchor),
      card.centerYAnchor.constraint(equalTo: foregroundCardStack.centerYAnchor),
    ])
  }
  
  private func startGamePopup(teamIndex: Int) {
    let switchingTeamsVC = SwitchingTeamsPopupViewController()
    switchingTeamsVC.setTeam(teams[teamIndex])
    switchingTeamsVC.modalPresentationStyle = .popover
    switchingTeamsVC.preferredContentSize = CGSize(width: view.bounds.width / 1.3, height: view.bounds.width / 1.3)
    switchingTeamsVC.popoverPresentationController?.sourceView = view
    switchingTeamsVC.popoverPresentationController?.delegate = self
    switchingTeamsVC.popoverPresentationController?.permittedArrowDirections = []
    switchingTeamsVC.popoverPresentationController?.sourceRect = CGRect(
      origin: CGPoint(
        x: view.bounds.midX,
        y: view.bounds.midY
      ),
      size: .zero
    )
    present(switchingTeamsVC, animated: true)
  }
  
  private func endGame() {
    let statsViewController = StatsViewController()
    statsViewController.teams = teams
    navigationController?.pushViewController(statsViewController, animated: true)
  }
}

extension GameViewController: UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
    UIDevice.current.userInterfaceIdiom == .pad ? UIModalPresentationStyle.popover : UIModalPresentationStyle.none
  }
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    var secondsRemaining = 60
    let timer = Timer(timeInterval: 1, repeats: true) { [weak self] timer in
      guard let strongSelf = self else { return }
      secondsRemaining -= 1
      strongSelf.timerCountdownLabel.text = String(secondsRemaining)
      
      if secondsRemaining == 0 {
        timer.invalidate()
        strongSelf.currentTeam += 1
        
        if strongSelf.teams.count == strongSelf.currentTeam {
          strongSelf.currentTeam = 0
        }
        
        if !strongSelf.questionsStrings.isEmpty {
          strongSelf.startGamePopup(teamIndex: strongSelf.currentTeam)
        } else {
          strongSelf.endGame()
        }
      }
    }
    RunLoop.current.add(timer, forMode: .common)
  }
}
