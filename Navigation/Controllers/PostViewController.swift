//
//  PostViewController.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    var titlePost: String = "Suharik"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
        self.navigationItem.title = titlePost
        let button = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(openInfo))
        navigationItem.rightBarButtonItem = button
    }
    //
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
    }
    //
    @objc func openInfo(){
        let rootVC = InfoViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        present(navVC, animated: true)
    }
}

class InfoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Информация"
        view.addSubview(buttonAlert)
    }
    @IBAction func showAlertButtonTapped() {
        let alert = UIAlertController(title: "ВнИмАнИе", message: "Чет идет не так...", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Понято", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Непонято", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Выйти", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
//    private lazy var buttonAlert: CustomButton = {
//        let button = CustomButton (
//            title: "Открыть предупреждение",
//            titleColor: .black,
//            backColor: .systemIndigo
//        )
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        return button
//    }()
    
    var buttonAlert: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.frame = CGRect(x: 30, y: 740, width: 350, height: 60)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitle("Открыть предупреждение", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = true
        return button
    }()
    
    @objc private func buttonAction() {
        showAlertButtonTapped()
    }
}

