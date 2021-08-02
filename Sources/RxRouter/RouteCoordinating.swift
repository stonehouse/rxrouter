//
//  RouteCoordinating.swift
//  RxRouter
//
//  Created by Alexander Stonehouse on 2/8/21.
//

import UIKit
import RxSwift

/// Serves as the 'factory' for the `Router`, handling `Step` events
/// from the router and instantiating the appropriate UI and passing that
/// UI to the `RouteTransitioner` to be presented.
public protocol RouteCoordinating: Routable {

    associatedtype RouteTransitioner: RouteTransitioning
    associatedtype Router: Routing
    associatedtype ViewController: UIViewController

    var transitioner: RouteTransitioner { get }
    var root: ViewController { get }
    var router: Router { get }
    var disposeBag: DisposeBag { get set }

    func navigate(to step: Router.Step)
}

extension RouteCoordinating {

    public var viewController: UIViewController {
        root
    }

    public func completed() {
        disposeBag = DisposeBag()
    }

    /// Must be called after init in implementation. Ensures that the
    /// subscription to the router is set up and the `navigate(to:)`
    /// method will be called.
    public func setup() {
        transitioner.setup(with: self)
        router.step
            .subscribe(onNext: { [weak self] in
                self?.navigate(to: $0)
            })
            .disposed(by: disposeBag)
    }

    public func transition(viewController: UIViewController, type: RouteTransitioner.RouteTransition) {
        transitioner.transition(viewController: viewController, type: type)
            .subscribe()
            .disposed(by: disposeBag)
    }

    public func transition(routeCoordinator: Routable, type: RouteTransitioner.RouteTransition) {
        transitioner.transition(routeCoordinator: routeCoordinator, type: type)
            .subscribe()
            .disposed(by: disposeBag)
    }
}
