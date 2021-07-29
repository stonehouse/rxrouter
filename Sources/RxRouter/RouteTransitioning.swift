//
//  Transitioner.swift
//  RxRouter
//
//  Created by Jason Chan on 19/8/20.
//

import UIKit
import RxSwift

protocol RouteTransitioning {

    associatedtype RouteTransition

    func setup(with router: Routable)
    func transition(viewController: UIViewController, type: RouteTransition) -> Completable
    func transition(routeCoordinator: Routable, type: RouteTransition) -> Completable
}

extension RouteTransitioning {

    func transition(routeCoordinator: Routable, type: RouteTransition) -> Completable {
        transition(viewController: routeCoordinator.viewController, type: type)
            .do(onDispose: { routeCoordinator.completed() })
    }
}
