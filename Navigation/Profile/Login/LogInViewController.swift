//
//  LogInViewController.swift
//  Navigation
//
//  Created by Suharik on 23.03.2022.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate {
    func userValidation (log: String, pass: String) -> Bool
}

class LogInViewController: UIViewController {
    let logInView = LogInView()
    var isLogin = false
    var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        //
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        logInView.emailTextField.delegate = self
        logInView.passwordTextField.delegate = self
        setupLoginViews()
        setupLoginLayout()
    }
    
    var loginAlertController: UIAlertController = {
        let alertController = UIAlertController(title: "Пользователь не найден", message: "Вы правильно ввели логин или пароль?", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Похоже нет", style: .default) { (_) -> Void in
        }
        alertController.addAction(acceptAction)
        return alertController
    }()
    
    func setupLoginViews(){
        logInView.scrollView.addSubview(logInView)
        view.addSubview(logInView.scrollView)
        view.addSubview(logInView.emailTextField)
        view.addSubview(logInView.loginButton)
        view.addSubview(logInView.loginImageView)
        view.addSubview(logInView.passwordTextField)
        view.addSubview(logInView)
    }
    
    @objc func loginButtonPressed(){
        let currentUserService = TestUserService()
        let profileViewController = ProfileViewController(userService: currentUserService, name: logInView.emailTextField.text!)
        if delegate?.userValidation(log: logInView.emailTextField.text!, pass: logInView.passwordTextField.text!) == true {
            isLogin = true
            navigationController?.pushViewController(profileViewController, animated: true)
            navigationController?.setViewControllers([profileViewController], animated: true)
        } else {
            present(loginAlertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbdShow(_ notification: NSNotification){
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            logInView.scrollView.contentInset.bottom = kbdSize.height
            logInView.scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc func kbdHide(_ notification: NSNotification){
        logInView.scrollView.contentInset.bottom = .zero
        logInView.scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    
    func setupLoginLayout(){
        view.addSubview(logInView)
        logInView.translatesAutoresizingMaskIntoConstraints = false
        logInView.loginImageView.translatesAutoresizingMaskIntoConstraints = false
        logInView.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        logInView.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        logInView.loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                        logInView.scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                        logInView.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                        logInView.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                                        logInView.scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                        
                                        logInView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                        logInView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                        logInView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                                        
                                        logInView.loginImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),                                       logInView.loginImageView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
                                        
                                        logInView.emailTextField.topAnchor.constraint(equalTo: logInView.loginImageView.bottomAnchor, constant: 120),
                                        logInView.emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                        logInView.emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                        logInView.emailTextField.heightAnchor.constraint(equalToConstant: 50),
                                        
                                        logInView.passwordTextField.topAnchor.constraint(equalTo: logInView.emailTextField.bottomAnchor, constant: 0),
                                        logInView.passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                        logInView.passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                        logInView.passwordTextField.heightAnchor.constraint(equalToConstant: 50),
                                        
                                        logInView.loginButton.topAnchor.constraint(equalTo: logInView.passwordTextField.bottomAnchor, constant: 16),
                                        logInView.loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                        logInView.loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                        logInView.loginButton.heightAnchor.constraint (equalToConstant: 50)])
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        view.endEditing(true)
        return true
    }
}



