//
//  SecondViewController.swift
//  goons
//
//  Created by 陳冠雄 on 2022/7/11.
//

import Foundation
import UIKit

class SecondViewController: UIViewController{
    
    let navBarAppearance = UINavigationBarAppearance()
    
    var isDarkContentBackground = false

    func statusBarEnterLightBackground() {
        isDarkContentBackground = false
        setNeedsStatusBarAppearanceUpdate()
    }

    func statusBarEnterDarkBackground() {
        isDarkContentBackground = true
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isDarkContentBackground {
            return .darkContent
        } else {
            return .lightContent
        }
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    let redView: UIView = {
        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = .red
        
        redView.layer.masksToBounds = true
        redView.clipsToBounds = true
        
        redView.layer.cornerRadius = 20
        redView.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        return redView
    }()
    let mainTitle: UILabel = {
        let mainTitle = UILabel()
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.textColor = .white
        mainTitle.text = "Fade animation"
        mainTitle.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        
        
        return mainTitle
    }()
    let subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.textColor = .white
        subTitle.text = "iOS APP"
        subTitle.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return subTitle
    }()
    let image: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dog.jpeg")!
        return imageView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.delegate = self
        
        
        navBarAppearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-back-24.png"), style: .done, target: self, action: #selector(pop))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
     
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(image)
        self.scrollView.addSubview(redView)
        self.scrollView.addSubview(mainTitle)
        self.scrollView.addSubview(subTitle)
        configureConstraints()
    }
    
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureConstraints(){
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
        let imageConstraints = [
            image.heightAnchor.constraint(equalToConstant: 300),
            image.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: self.redView.topAnchor,constant: 50)
        ]
        NSLayoutConstraint.activate(imageConstraints)
        
        let redViewConstraints = [
            redView.heightAnchor.constraint(equalToConstant: 900),
            redView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 250),
            redView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            redView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            redView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(redViewConstraints)
        
        let mainTitleConstraints = [
            mainTitle.topAnchor.constraint(equalTo: self.scrollView.topAnchor,constant: 60),
            mainTitle.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor,constant: 20),
            mainTitle.bottomAnchor.constraint(equalTo: redView.topAnchor, constant: -140),
            mainTitle.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor,constant:200)
        ]
        
        NSLayoutConstraint.activate(mainTitleConstraints)
        
        let subTitleConstraints = [
            subTitle.topAnchor.constraint(equalTo: self.mainTitle.bottomAnchor, constant: 0),
            subTitle.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor,constant: 20),
            subTitle.bottomAnchor.constraint(equalTo: redView.topAnchor, constant: -110),
            subTitle.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor,constant:200)
        ]
        NSLayoutConstraint.activate(subTitleConstraints)
        
        
        
    }
}
extension SecondViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let tempAlpha = y/190
        
        self.navigationController?.navigationBar.alpha = tempAlpha
        
        switch(tempAlpha){
        case _ where tempAlpha < 0.35 :
            //case 1 bar只有箭頭 沒有標題 且透明
            self.title = ""
            navBarAppearance.configureWithTransparentBackground()
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.alpha = 1
            
            statusBarEnterLightBackground()
        case _ where tempAlpha < 1 && tempAlpha > 0.35 :
            //case 2 有標題且開始浮現
            navBarAppearance.configureWithDefaultBackground()
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.title = "Fade animation"
            self.navigationController?.navigationBar.alpha = tempAlpha
            statusBarEnterDarkBackground()
        default:
            //case3 完全浮現
            statusBarEnterDarkBackground()
            self.navigationController?.navigationBar.alpha = 1
            self.title = "Fade animation"
        }
        
        
        
        
    }
}
