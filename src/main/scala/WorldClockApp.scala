import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.model.{HttpRequest, HttpResponse}
import akka.http.scaladsl.server.Directives._
import akka.stream.Materializer
import akka.http.scaladsl.marshallers.sprayjson.SprayJsonSupport._
import spray.json.DefaultJsonProtocol._

import java.time._
import java.time.format.DateTimeFormatter
import scala.concurrent.{ExecutionContextExecutor, Future}
import scala.io.StdIn

// Define a case class for the JSON response format
case class TimeResponse(timezone: String, currentTime: String)

// Implement the JSON format for the case class
object JsonFormats {
  import spray.json.DefaultJsonProtocol._
  implicit val timeFormat = jsonFormat2(TimeResponse)
}

object WorldClockApp {
  // Create an actor system and materializer for Akka HTTP
  implicit val system: ActorSystem = ActorSystem("world-clock-system")
  implicit val materializer: Materializer = Materializer(system)
  implicit val executionContext: ExecutionContextExecutor = system.dispatcher

  import JsonFormats._

  def main(args: Array[String]): Unit = {
    // Define the routes
    val route =
      pathPrefix("time") {
        // Base route /time/:timezone to get the time
        path(Segment) { timezone =>
          get {
            // Get the timezone and current time
            val timeResponse = getCurrentTimeForTimezone(timezone)
            complete(timeResponse)
          }
        }
      }

    // Start the HTTP server
    val bindingFuture = Http().newServerAt("localhost", 8080).bind(route)

    println("Server online at http://localhost:8080/\nPress RETURN to stop...")
    StdIn.readLine() // Wait for user to press Enter
    bindingFuture
      .flatMap(_.unbind())
      .onComplete(_ => system.terminate())
  }

  // Function to get the current time for a specific timezone
  def getCurrentTimeForTimezone(timezone: String): TimeResponse = {
    try {
      // Try to get the provided timezone
      val zoneId = ZoneId.of(timezone)
      val currentTime = ZonedDateTime.now(zoneId).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
      TimeResponse(timezone, currentTime)
    } catch {
      case _: Exception =>
        // On error, return default UTC time
        val utcTime = ZonedDateTime.now(ZoneId.of("UTC")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
        TimeResponse("Invalid Timezone. Defaulting to UTC", utcTime)
    }
  }
}
