package main

import (
	"html/template"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

// TimeResponse defines the structure for the JSON response
type TimeResponse struct {
	Timezone    string `json:"timezone"`
	CurrentTime string `json:"current_time"`
}

// Handler function to get the current time for a specified timezone
func getTime(c *gin.Context) {
	timezone := c.Param("timezone")

	// Parse the timezone
	location, err := time.LoadLocation(timezone)
	if err != nil {
		// If the timezone is invalid, default to UTC
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Invalid timezone. Please provide a valid IANA timezone, e.g., 'America/New_York'.",
		})
		return
	}

	// Get the current time in the specified timezone
	currentTime := time.Now().In(location)

	// Create the response
	response := TimeResponse{
		Timezone:    timezone,
		CurrentTime: currentTime.Format(time.RFC3339),
	}

	// Return the response as JSON
	c.JSON(http.StatusOK, response)
}

// Handler to render the HTML page
func renderHomePage(c *gin.Context) {
	tmpl, err := template.ParseFiles("templates/index.html")
	if err != nil {
		c.String(http.StatusInternalServerError, "Error loading template")
		return
	}
	tmpl.Execute(c.Writer, nil)
}

func main() {
	// Create a new Gin router
	router := gin.Default()

	// Serve static HTML page
	router.GET("/", renderHomePage)

	// Define the route to get time
	router.GET("/time/:timezone", getTime)

	// Start the server on port 8080
	router.Run(":8080")
}
