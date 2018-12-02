import Vapor
import Fluent

/// Register your application's routes here.
public func routes(_ router: Router) throws {
  // Basic "It works" example
  router.get { req in
      return "It works!"
  }
  
  // Basic "Hello, world!" example
  router.get("hello") { req in
      return "Hello, world!"
  }
  
  // register controller to control route
  let acronymsController = AcronymsController()
  try router.register(collection: acronymsController)
    
    // register user controller
    let usersController = UsersController()
    try router.register(collection: usersController)
}
