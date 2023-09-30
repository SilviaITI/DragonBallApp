//
//  LoginViewController.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 23/9/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    // Function that change eye system image
    private var isShowedPassword = false {
        didSet {
            showPassword.setImage(UIImage(systemName: isShowedPassword ? "eye.fill" : "eye.slash.fill") , for: .normal)
            
        }
    }
    //MARK: - Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var showPassword: UIButton!
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = "Datos incorrectos"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userNameTextField.text = ""
        passwordTextField.text = ""
       
    }
     
    // MARK: - Actions
    @IBAction func continueButtonAction(_ sender: Any) {
    fetchLogin()
    }
    
    //  function to show or hide password
    @IBAction func tapShowPassword(_ sender: Any) {
        isShowedPassword.toggle()
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    // MARK: - Public Methods
    // Function that shows the spinner in the current view
    func showLoading() {
            manageSpinner(inside: view, action: .add)
        }
    // Function that hides the spinner from the current view
    func hideLoading() {
        DispatchQueue.main.async {
            self.manageSpinner(inside: self.view, action: .remove)
        }
    }
    // Function that encapsulates login function
    func fetchLogin() {
        errorLabel.isHidden = true
        showLoading()
        NetworkModel.shared.login(
            user: userNameTextField.text ?? "",
            password: passwordTextField.text ?? ""
        ) { [weak self] result in
            switch result {
                case .success:
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(ListadoHeroesViewController(), animated: true)
                }
                case let .failure(error):
                    print("Error: \(error)")
                DispatchQueue.main.async {
                    self?.errorLabel.isHidden = false
                }
            }
            self?.hideLoading()
        }
    }
}

