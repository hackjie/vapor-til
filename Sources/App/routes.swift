import Vapor

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

  // new
  router.post("api", "acronyms") { req -> Future<Acronym> in
    return try req.content.decode(Acronym.self).flatMap(to: Acronym.self) { acronym in
      acronym.save(on: req)
    }
  }
  
  // query all
  router.get("api", "acronyms") { req -> Future<[Acronym]> in
    return Acronym.query(on: req).all()
  }
  
  // query one
  router.get("api", "acronyms", Acronym.parameter) { req -> Future<Acronym> in
    return try req.parameters.next(Acronym.self)
  }
  
  // update
  router.put("api", "acronyms", Acronym.parameter) { req -> Future<Acronym> in
    return try flatMap(to: Acronym.self,
                       req.parameters.next(Acronym.self),
                       req.content.decode(Acronym.self)) { acronym, updatedAcronym in
      acronym.short = updatedAcronym.short
      acronym.long = updatedAcronym.long
      
      return acronym.save(on: req)
    }
  }
  
  // delete
  router.delete("api", "acronyms", Acronym.parameter) { req -> Future<HTTPStatus> in
    return try req.parameters.next(Acronym.self).delete(on: req).transform(to: HTTPStatus.noContent)
  }
}
