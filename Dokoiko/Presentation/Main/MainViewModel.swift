//
//  MainViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/03/25.
//

import Foundation
import RxCocoa
import RxSwift

protocol MainViewModelProtocol: AnyObject {
    /// アプリ初回起動フラグ
    var initialFlag: Driver<Bool> { get }
}

class MainViewModel: MainViewModelProtocol {
    private let initialFlagRelay = BehaviorRelay<Bool>(value: false)
    var initialFlag: Driver<Bool> {
        initialFlagRelay.asDriver()
    }
}
