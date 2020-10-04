import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let userController = UserController()
    router.get("frontview",use: userController.viewFront)//
    router.get("users", use: userController.list)
    router.get("users1", use: userController.list1)
    router.get("users2",use: userController.list2)
    router.get("users3",use: userController.list3)
    router.post("users", use: userController.create)
    router.patch("users", User.parameter, use: userController.update)
    router.delete("users", User.parameter, use: userController.delete)
    //
    let coordinateController = CoordinateController()
    router.get("location", use: coordinateController.list)
    router.get("tracking", use: coordinateController.last)
    router.post("location", use: coordinateController.create)
    router.delete("tracking",Coordinate.parameter ,use: coordinateController.delete)
    router.patch("tracking",Coordinate.parameter ,use: coordinateController.update)
    //
    let currentRouteControll = currentRouteController()
    router.get("route",use: currentRouteControll.allRoute)
    router.post("route",use: currentRouteControll.addSegment)
    router.delete("delete", CurrentRoute.parameter, use: currentRouteControll.delete)
    
}
