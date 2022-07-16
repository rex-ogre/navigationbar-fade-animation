//
//  ViewController.swift
//  goons
//
//  Created by 陳冠雄 on 2022/7/11.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    
    let navBarAppearance = UINavigationBarAppearance()
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("下一頁", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarAppearance.configureWithDefaultBackground()
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "下一頁"
       
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        self.view.addSubview(button)
        configureConstraints()
        

        
      
    }
    
    
    @objc func tap(){
        let vc2 = SecondViewController()
        vc2.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    func configureConstraints(){
        let buttoConstraints = [
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(buttoConstraints)
    }
    
}
