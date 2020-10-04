import Vapor
import FluentPostgreSQL
import Leaf

/// Called before your application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {

    /// Register routes to the router
    try services.register(FluentPostgreSQLProvider())
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    /// Leaf config
    let leafProvider = LeafProvider()    // added
    try services.register(leafProvider)  // added
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    // Configure a PostgreSQL database
    let postgreSQLConfig : PostgreSQLDatabaseConfig
    if let url = Environment.get("DATABASE_URL") {
        postgreSQLConfig = PostgreSQLDatabaseConfig(url: url)!
    } else {
        postgreSQLConfig = PostgreSQLDatabaseConfig(hostname: "localhost", username: "brazilec22")
    }
    
    let postgreSQL = PostgreSQLDatabase(config: postgreSQLConfig)
    // middlewares
    var middlewares = MiddlewareConfig()
    middlewares.use(ErrorMiddleware.self)
    middlewares.use(FileMiddleware.self)
    // etc.
    services.register(middlewares)
    // Register the configured PostreSQL database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: postgreSQL, as: .psql)
    services.register(databases)
    // magration
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql)
    migrations.add(model: Coordinate.self, database: .psql)
    /// add current route
    migrations.add(model: CurrentRoute.self, database: .psql)
    //
    services.register(migrations)
}
