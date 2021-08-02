//
//  NavigationRouteTransitioner.swift
//  RxRouter
//
//  Created by Alexander Stonehouse on 2/8/21.
//

import UIKit
import RxSwift

public protocol NavigationRouteTransitioning: RouteTransitioning where RouteTransition == NavigationRouteTransitioner.RouteTransition {
    func transition(viewController: UIViewController) -> Completable
}

extension NavigationRouteTransitioning {
    public func transition(viewController: UIViewController) -> Completable {
        transition(viewController: viewController, type: RouteTransition())
    }
}

public final class NavigationRouteTransitioner: RouteTransitioning {
    public struct RouteTransition {
        var animated = true
    }
    
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func setup(with router: Routable) {
    }
    
    public func transition(viewController: UIViewController, type: RouteTransition) -> Completable {
        navigationController.pushViewController(viewController, animated: type.animated)
        return Completable.empty()
    }
}
