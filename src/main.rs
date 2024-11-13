use actix_web::{web, App, HttpServer};
use crate::handlers::get_time;

// Import handlers
mod handlers;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Start the Actix Web server
    HttpServer::new(|| {
        App::new()
            .route("/time/{timezone}", web::get().to(get_time))
    })
    .bind("0.0.0.0:8080")?
    .run()
    .await
}
