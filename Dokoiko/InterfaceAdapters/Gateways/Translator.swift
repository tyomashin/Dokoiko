//
//  Translator.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/04/07.
//

import Foundation
import RxSwift
import CoreLocation
import NotificationCenter

/// 参考：https://github.com/koutalou/iOS-CleanArchitecture/tree/master/iOSCleanArchitectureTwitterSample/Domain/UseCase/Translater
protocol Translator {
    associatedtype Input
    associatedtype Output
    func translate(_: Input) -> Output
}

extension ObservableType {
    func map<T: Translator>(translator: T) -> Observable<T.Output> where Self.Element == T.Input {
        map { translator.translate($0) }
    }
}

extension Collection {
    func map<T: Translator>(translator: T) throws -> [T.Output] where Self.Iterator.Element == T.Input {
        map { translator.translate($0) }
    }
}
