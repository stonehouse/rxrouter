//
//  UIViewController+popped.swift
//  
//
//  Created by Alexander Stonehouse on 10/6/21.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    public var popped: Completable {
        self.sentMessage(#selector(Base.viewDidDisappear))
            .filter { _ in self.base.isMovingFromParent }
            .take(1)
            .ignoreElements()
            .asCompletable()
    }
}
