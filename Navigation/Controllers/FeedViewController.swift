//
//  FeedViewController.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
        view.backgroundColor = .white
        view.addSubview(postButton)
    }
    //
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    //
    
//    private lazy var postButton: CustomButton = {
//        let button = CustomButton (title: "New post", titleColor: .black, backColor: .systemIndigo)
//        button.frame = CGRect(x: 30, y: 740, width: 350, height: 60)
//        button.clipsToBounds = false
//        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        button.layer.shadowRadius = 5.0
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOpacity = 0.8
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        return button
//    }()
    var postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.frame = CGRect(x: 30, y: 740, width: 350, height: 60)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = true
        return button
    }()
    
    @objc private func buttonAction() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
