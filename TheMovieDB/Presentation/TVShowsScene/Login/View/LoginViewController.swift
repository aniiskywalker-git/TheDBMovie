//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import UIKit

class LoginViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: LoginViewModel?
    
    static func create(
        with viewModel: LoginViewModel
    ) -> LoginViewController {
        let view = LoginViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //bind(to: viewModel)
        viewModel?.viewDidLoad()
    }
    
    private func bind(to viewModel: LoginViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel?.errorTitle ?? "", message: error)
    }

    @IBAction func loginButton(_ sender: Any) {
        viewModel?.authenticate(email: emailField.text ?? "", password: passwordField.text ?? "")
    }
    
}

