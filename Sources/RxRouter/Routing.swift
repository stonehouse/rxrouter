//
//  Routing.swift
//  RxRouter
//
//  Created by Jason Chan on 19/8/20.
//

import Foundation
import RxSwift

public protocol RouterStep {}

public protocol Routing {
    associatedtype Step: RouterStep
    var step: Observable<Step> { get }
}
