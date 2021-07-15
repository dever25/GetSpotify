//
//  LoginViewController.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 14.07.2021.
//

import UIKit

protocol LogInViewModelProtocol {
    func logIn()
}

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton!
    
    var viewModel: LogInViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction private func logInAction(_ sender: UIButton) {
        viewModel?.logIn()
    }
    
    private func setUI() {
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = loginButton.bounds.height * 0.5
        loginButton.setTitle("Log In", for: .normal)
    }
}
