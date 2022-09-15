//
//  MenuViewController.swift
//  it-alias
//
//  Created by Yushkevich Ilya on 16.08.22.
//

import UIKit

class MenuViewController: UIViewController {
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    imageView.backgroundColor = .red
    
    return imageView
  }()
  
  private let startButton: UIButton = {
    let button = UIButton()
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(Colors.blue.color, for: .normal)
    button.setTitle(Strings.Menu.play, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.backgroundColor = Colors.yellow.color
    button.layer.cornerRadius = 10
    button.titleLabel?.font = FontsManager.bold(ofSize: 40)
    button.addTarget(self, action: #selector(goToTeamsViewController), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Colors.blue.color
    
    addSubviews()
    setupConstraints()
  }
  
  // MARK: - Setups
  private func addSubviews() {
    view.addSubview(logoImageView)
    view.addSubview(startButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: view.frame.width / 2),
      logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.topAnchor.constraint(greaterThanOrEqualTo: logoImageView.bottomAnchor, constant: 50),
      startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
      startButton.widthAnchor.constraint(equalToConstant: 120),
      startButton.heightAnchor.constraint(equalToConstant: 60),
    ])
  }
  
  // MARK: - Helpers
  @objc
  private func goToTeamsViewController() {
    let vc = TeamsViewController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
  }
}

