import FluentPostgreSQL
import Vapor


final class User: PostgreSQLModel {
    typealias Database = PostgreSQLDatabase

    var id: Int?
 //   var username: String
    var altitude : Double
    var username : String
    var positionID : Coordinate.ID
    var locate : [area]
    
   // var mycoordinate : Coordinate

    init(id: Int? = nil, /*username: String*/altitude : Double,username: String/*,mycoordinate : Coordinate */,positionID : Coordinate.ID,locate : [area]) {
        self.id = id
   //     self.username = username
        self.altitude = altitude
        self.username = username
        self.positionID = positionID
        self.locate = locate
        //self.mycoordinate = mycoordinate
    }
 //   struct Coordinate {
 //       let lon, lat: String
 //   }
}
struct area : Codable{
    var lat : Double
    var lot : Double
}
/*
   func create(_ req: Request) throws -> Future<Response> {
     return try req.content
       .decode(Pokemon.PokemonForm.self)
       .flatMap { pokemonForm in
         return User
           .find(pokemonForm.userId, on: req)
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
 */
final class Coordinate: PostgreSQLModel {
    typealias Database = PostgreSQLDatabase

    var id: Int?
    
    var lon, lat: Double

    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}
/// class current route
final class CurrentRoute: PostgreSQLModel {
    typealias Database = PostgreSQLDatabase

     var id: Int?
     var longitude, latitude: Double
     init(longitude: Double, latitude: Double) {
         self.longitude = longitude
         self.latitude = latitude
     }
}
/// end's 

extension User: Content {}
extension User: Migration {}
extension User: Parameter {}

extension CurrentRoute: Content {}
extension CurrentRoute: Migration {}
extension CurrentRoute: Parameter {}

extension Coordinate: Content {}
extension Coordinate: Migration {}
extension Coordinate: Parameter {}
extension User {
var user: Parent<User, Coordinate> {
  return parent(\.positionID)
    }
}
extension Coordinate {
  var coordinate: Children<Coordinate, User> {
    return children(\.positionID)
  }
}
