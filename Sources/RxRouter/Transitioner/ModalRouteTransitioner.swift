//
//  ModalCoordinator.swift
//  RxRouter
//
//  Created by Alexander Stonehouse on 17/8/20.
//

import RxSwift
import UIKit

protocol ModalRouteTransitioning: RouteTransitioning where RouteTransition == ModalRouteTransitioner.RouteTransition {
    func dismissChild()
}

final class ModalRouteTransitioner: ModalRouteTransitioning {
    struct RouteTransition {
        var animated: Bool = true
        var style: UIModalPresentationStyle = .overCurrentContext
    }

    private var root: UIViewController?
    private let disposeBag = DisposeBag()

    func setup(with router: Routable) {
        self.root = router.viewController
    }

    func transition(viewController: UIViewController, type: RouteTransition) -> Completable {
        viewController.modalPresentationStyle = type.style
        self.root?.present(viewController, animated: type.animated, completion: nil)

        return viewController.rx.dismissed
    }

    func dismissChild() {
        self.root?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
