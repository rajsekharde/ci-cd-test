package main

import (
	"fmt"
	"log"
	"net/http"
	"strconv"
)

var PORT int = 8000
var PORT_STR = ":" + strconv.Itoa(PORT)

func HandleRoot(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprintln(w, "Hello")
	log.Printf("%s %s %d\n", r.Method, r.URL.Path, http.StatusOK)
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("GET /", HandleRoot)

	log.Printf("Server running on port %d\n", PORT)
	log.Fatal(http.ListenAndServe(PORT_STR, mux))
}