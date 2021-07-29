//
//  RouterPlay.swift
//  RxRouter
//
//  Created by Alexander Stonehouse on 13/8/20.
//

import RxSwift
import UIKit

protocol Routable: class {
    var viewController: UIViewController { get }
    func completed()
}

protocol RouteCoordinating: Routable {

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

    var viewController: UIViewController {
        root
    }

    func completed() {
        disposeBag = DisposeBag()
    }

    func setup() {
        transitioner.setup(with: self)
        router.step
            .subscribe(onNext: { [weak self] in
                self?.navigate(to: $0)
            })
            .disposed(by: disposeBag)
    }

    func transition(viewController: UIViewController, type: RouteTransitioner.RouteTransition) {
        transitioner.transition(viewController: viewController, type: type)
            .subscribe()
            .disposed(by: disposeBag)
    }

    func transition(routeCoordinator: Routable, type: RouteTransitioner.RouteTransition) {
        transitioner.transition(routeCoordinator: routeCoordinator, type: type)
            .subscribe()
            .disposed(by: disposeBag)
    }
}
