//
//  RouterStepper.swift
//  RxRouter
//
//  Created by Jason Chan on 19/8/20.
//

import Foundation
import RxSwift

protocol RouterStep {}

protocol Routing {
    associatedtype Step: RouterStep
    var step: Observable<Step> { get }
}
