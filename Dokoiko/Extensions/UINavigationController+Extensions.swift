//
//  UINavigationController+Extensions.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/25.
//

import Foundation
import UIKit

extension UINavigationController {
    /// フェードアニメーションで画面遷移
    func fade(viewControllers: [UIViewController]) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        setViewControllers(viewControllers, animated: false)
    }

    /// フェードアニメーションで画面遷移
    func fade(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
