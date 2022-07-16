//
//  PostViewController.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit
import SnapKit

class PostViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
        let button = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(openInfo))
        navigationItem.rightBarButtonItem = button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
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
        setupButton()
        buttonAlert.tapAction = { [weak self] in
            guard let self = self else { return }
            self.showAlertButtonTapped()
        }
    }
    @IBAction func showAlertButtonTapped() {
        let alert = UIAlertController(title: "ВнИмАнИе", message: "Шо то идет не так...", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Понято", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Непонято", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Выйти", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private lazy var buttonAlert: CustomButton = {
        let button = CustomButton (
            title: "Открыть предупреждение",
            titleColor: .black,
            backColor: .systemIndigo,
            backImage: UIImage()
        )
        return button
    }()
    
    @objc private func buttonAction() {
        showAlertButtonTapped()
    }
    
    func setupButton(){
        buttonAlert.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

