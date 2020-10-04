import Vapor
import Fluent

final class UserController {
    /*
      func create(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Pokemon.PokemonForm.self).flatMap { pokemonForm in
            return User.find(pokemonForm.userId, on: req)
              .flatMap { user in
                guard let userId = try user?.requireID() else {
                  throw Abort(.badRequest)
                }
                let pokemon = Pokemon(
                  name: pokemonForm.name,
                  level: pokemonForm.level,
                  userID: userId
                )
                return pokemon.save(on: req).map { _ in
                  return req.redirect(to: "/users")
                }
            }
          }
      }
    }
     // add token
    */
    //
    // view with users
       func viewFront(_ req: Request) throws -> Future<View> {
           return User.query(on: req).all().flatMap { users in
               let data = ["userlist": users]
               return try req.view().render("userview", data)
           }
       }
    // view with users
    func list(_ req: Request) throws -> Future<[User]> {
            return User.query(on: req)
            .all()
    }
    func list1(_ req: Request) throws -> Future<[User]> {
               let users =  User.query(on: req)
                .join(\Coordinate.id,to: \User.positionID)
                .filter(\User.positionID >= 2)
                .all()
        print(users)
        return users
    }
    func list2(_ req: Request) throws -> Future<[User]> {
               let users =  User.query(on: req)
                .join(\Coordinate.id,to: \User.positionID)
                //.alsoDecode(User.self)
                .all()
        print(users)
        return users
    }
    func list3(_ req: Request) throws -> Future<[User]> {
                return User.query(on: req)
                 .join(\User.positionID,to: \Coordinate.id )
                 //.alsoDecode(User.self)
                 .all()
     }
    // create a new user
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }

    // update a user
    func update(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self).flatMap { user in
            return try req.content.decode(User.self).flatMap { newUser in
                user.altitude = newUser.altitude
                return user.save(on: req)
            }
        }
    }

    // delete a user
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
        }.transform(to: .ok)
    }
}

final class CoordinateController {
    // view with users
    func list(_ req: Request) throws -> Future<[Coordinate]> {
        return Coordinate.query(on: req).all() //not last
    }
    //
    func last(_ req: Request) throws -> Future<Coordinate> {
        return Coordinate.query(on: req).first().unwrap(or: Abort(HTTPResponseStatus(statusCode: 404)))

    }
    // create a new user
    func create(_ req: Request) throws -> Future<Coordinate> {
        return try req.content.decode(Coordinate.self).flatMap { coordinate in
            return coordinate.save(on: req)
        }
    }
    // delete a location
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Coordinate.self).flatMap { coordinate in
            return coordinate.delete(on: req)
        }.transform(to: .ok)
    }
    // update
    // update a user
    func update(_ req: Request) throws -> Future<Coordinate> {
        return try req.parameters.next(Coordinate.self).flatMap { coordinate in
            return try req.content.decode(Coordinate.self).flatMap { position in
                coordinate.lat = position.lat
                coordinate.lon = position.lon
                return coordinate.save(on: req)
            }
        }
    }

}

/// current route controller
final class currentRouteController {
    /// return [ item]
    func allRoute(_ req: Request) throws -> Future<[CurrentRoute]> {
        return CurrentRoute.query(on: req).all() //not last
    }
    ///
    // create a new user
      func addSegment(_ req: Request) throws -> Future<CurrentRoute> {
          return try req.content.decode(CurrentRoute.self).flatMap { seg in
              return seg.save(on: req)
          }
      }
    //
    // delete all seg at route
     func delete(_ req: Request) throws -> Future<HTTPStatus> {
         return try req.parameters.next(CurrentRoute.self).flatMap { route in
             return route.delete(on: req)
         }.transform(to: .ok)
     }
    
}
