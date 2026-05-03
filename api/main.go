package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
)

func HandleRoot(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprintln(w, "Hello")
	log.Printf("%s %s %d\n", r.Method, r.URL.Path, http.StatusOK)
}

func ReturnLargest(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Println("Using system env")
	}
	PORT := os.Getenv("API_PORT")
	if PORT == "" {
		PORT = "8000"
	}
	PORT_STR := ":" + PORT

	mux := http.NewServeMux()
	mux.HandleFunc("GET /", HandleRoot)

	log.Printf("Server running on port %s\n", PORT)
	log.Fatal(http.ListenAndServe(PORT_STR, mux))
}