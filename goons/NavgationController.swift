//
//  NavgationController.swift
//  goons
//
//  Created by 陳冠雄 on 2022/7/13.
//

import Foundation
import UIKit

class NavigationController: UINavigationController{
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
 
}
