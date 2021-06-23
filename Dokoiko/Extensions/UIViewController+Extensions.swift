//
//  UIViewController+Extensions.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/18.
//

import Foundation
import UIKit

extension UIViewController {
    /// アラートダイアログを表示する
    /// - Parameters:
    ///   - title: タイトル
    ///   - message: 本文
    ///   - tapOk: OKタップ時の処理
    func showMessage(title: String? = nil, message: String? = nil, tapOk: (() -> Void)? = nil) {
        let alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.Btn.ok, style: .default) { _ in
            tapOk?()
        }
        alertDialog.addAction(okAction)
        present(alertDialog, animated: true, completion: nil)
    }
}
