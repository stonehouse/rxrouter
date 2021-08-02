//
//  UIViewController+dismissed.swift
//  RxRouter
//
//  Created by Alexander Stonehouse on 10/6/21.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    /// If VC is embedded in a parent ViewController then we need to check whether parent is being dismissed.
    fileprivate var isParentBeingDismissed: Bool {
        return checkParent(self)
    }
    
    /// Recursively check the hierarchy for a VC that is being dismissed
    private func checkParent(_ vc: UIViewController) -> Bool {
        if let parent = vc.parent {
            return parent.isBeingDismissed || checkParent(parent)
        } else {
            return false
        }
    }
}

extension Reactive where Base: UIViewController {

    /// Rx observable, triggered when the view is being dismissed
    public var dismissed: Completable {
        Observable<[Any]>.merge(
                self.sentMessage(#selector(Base.viewDidDisappear))
                    .filter { [unowned base] _ in base.isBeingDismissed || base.isParentBeingDismissed },
                // Called when removing childVC
                self.sentMessage(#selector(Base.removeFromParent))
            )
            .take(1)
            .ignoreElements()
            .asCompletable()
    }
}
