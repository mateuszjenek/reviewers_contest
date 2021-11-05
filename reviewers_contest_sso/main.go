package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

func getGithubToken(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Handling new token request")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	var body struct {
		Code string `json:"code"`
	}

	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	client_id := os.Getenv("CLINET_ID")
	client_secret := os.Getenv("CLIENT_SECRET")

	uri := fmt.Sprintf("https://github.com/login/oauth/access_token?client_id=%s&client_secret=%s&code=%s",
		client_id,
		client_secret,
		body.Code,
	)

	client := &http.Client{}
	req, err := http.NewRequest("GET", uri, nil)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	req.Header.Set("Accept", "application/vnd.github.v3+json")
	resp, err := client.Do(req)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	var response struct {
		AccessToken string `json:"access_token"`
	}

	if err = json.NewDecoder(resp.Body).Decode(&response); err != nil {
		println(err.Error())
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	responseJson, err := json.Marshal(response)
	if err != nil {
		print(err.Error())
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(responseJson)
	fmt.Println("New token request handled")
}

func getHealth(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Handling new health request")
	w.WriteHeader(http.StatusOK)
	w.Write(nil)
	fmt.Println("New health request handled")
}

func main() {
	fmt.Println("Reviewers contest SSO started")
	http.HandleFunc("/token", getGithubToken)
	http.HandleFunc("/", getHealth)

	http.ListenAndServe(":8090", nil)
}
