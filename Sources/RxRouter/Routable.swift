//
//  Routable.swift
//  RxRouter
//
//  Created by Alexander Stonehouse on 13/8/20.
//

import RxSwift
import UIKit

/// Non-generic version of `RoutingCoordinator`, used
/// by `RouteTransitioning`.
public protocol Routable: AnyObject {
    var viewController: UIViewController { get }
    func completed()
}
