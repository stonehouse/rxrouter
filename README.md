# RxRouter
RxRouter is an implementation of the Coordinator Pattern in Swift and relies of RxSwift. The goal of RxRouter is to keep strict separation between the business logic of navigation from the boilerplate of creating the UI. Additionally, RxRouter attempts to avoid coupling the type of navigation from the creation of the UI.

## Roles in RxRouter

#### Router
Routers implement the `Routing` protocol and generate `Step` events to control the navigation flow. This is where the business logic of navigation should live, but its decoupled from how the navigation occurs.

#### RouteCoordinator
RouteCoordinators are coupled to a give `Routing` implementation and handle the `Step` evenst from the Router. They implement the `RouteCoordinating` protocol and tasked with instantiating the appropriate View Controller for the UI. This is also a good place to do dependency injection. The RouteCoordinator does not present the UI itself, it delegates that to a `RouteTransitioner`.

#### RouteTransitioner
A RouteTransitioner implements the `RouteTransitioning` protocol and is responsible for handling a specific type or presentation. The RouteTransitioner helps decouple the presentation style from the actual UI. This makes it easier to have more custom and dynamic navigation that might change depending on context, such as split view on an iPad and navigation controller on an iPhone.

### Implementations
`ModalRouteTransitioner` and `NavigationRouteTransitioner` are available as basic implementations, but custom versions are straightforward to make.

__References__
- RxRouter borrows heavily from the ideas of [RxFlow](https://github.com/RxSwiftCommunity/RxFlow) while solving for some slightly different goals.
- Introduction to the [Coordinator Pattern](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps)
