use actix_web::{web, HttpResponse};
use chrono::{DateTime, Local, Utc, TimeZone};
use serde::Serialize;

// Struct for the JSON response
#[derive(Serialize)]
struct TimeResponse {
    timezone: String,
    current_time: String,
}

// Handler function to get the current time for a specified timezone
pub async fn get_time(path: web::Path<String>) -> HttpResponse {
    let timezone: String = path.into_inner();

    // Try to get the timezone and current time
    let response = match timezone.parse::<chrono::FixedOffset>() {
        Ok(offset) => {
            let now = Utc::now().with_timezone(&offset);
            TimeResponse {
                timezone: timezone.clone(),
                current_time: now.to_rfc3339(),
            }
        }
        Err(_) => {
            // If timezone is invalid, return the local time as default
            let local_now: DateTime<Local> = Local::now();
            TimeResponse {
                timezone: "Invalid Timezone. Defaulting to Local Time".to_string(),
                current_time: local_now.to_rfc3339(),
            }
        }
    };

    // Return the response as JSON
    HttpResponse::Ok().json(response)
}
