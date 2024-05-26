import sys
import os
import json
import random
import requests
from datetime import datetime, timedelta
from googleapiclient.discovery import build
# from google_books_api_wrapper.api import GoogleBooksAPI

# from pynytimes import NYTAPI

WEIGHTS = {
    "genres": 0.3,
    "critics": 0.35,
    "popularity": 0.35
}

# API_GOOGLE = GoogleBooksAPI()



def RecommandBooks(user: json) -> json:
    read_books = user["readBooks"]
    genres = user["preferences"]["booksGenres"]
    result = { "recommendations": [] }
    # print("READ BOOKS / GENRE :")
    # print(read_books)
    # print(genres)

    ids_titres_livres = []  # Liste de tuples (ID, titre)

    while len(ids_titres_livres) < 5:
        for genre in genres:
            # Appel à l'API Google Books pour récupérer les livres par genre
            url = f"https://www.googleapis.com/books/v1/volumes?q=subject:{genre}&maxResults=20&orderBy=relevance"
            response = requests.get(url)
            data = response.json()
            items = data.get("items", [])
            for item in items:
                book_id = item.get("id")
                book_title = item.get("volumeInfo", {}).get("title")
                if book_id not in read_books and book_id not in user["recommendedBooksHistory"] and book_id not in [id for id, _ in ids_titres_livres]:
                    ids_titres_livres.append((book_id, book_title))
                if len(ids_titres_livres) >= 5:
                    break
            if len(ids_titres_livres) >= 5:
                break

    # print("IDS ET TITRES DES LIVRES :")
    # print(ids_titres_livres)
    for p in range(5):
        result["recommendations"].append({
        "title": ids_titres_livres[p][1],
        "score": random.randint(1, 100),
        "id": ids_titres_livres[p][0]})
    sorted(result["recommendations"], key=lambda k: k['score'], reverse=True)
    return result


def calculate_score(book, user):
    # print("---------------------------------")
    # print("calculate score")
    # print(book["title"])
    #book_google = API_GOOGLE.get_book_by_isbn13(book["primary_isbn13"])
    score = 0
    # score += calculate_genre_score(book, user)
    # score += calculate_critics_score(book, user)
    # score += calculate_popularity_score(book, user)
    # print("total score: " + str(score))
    # print("---------------------------------")
    score = random.randint(1, 100)
    return score

def calculate_genre_score(book, user):
    score = 0
    google_books_api = build("books", "v1", developerKey=os.getenv("GOOGLE_BOOKS_API_KEY"))
    response = google_books_api.volumes().list(q="isbn:" + book["primary_isbn13"]).execute()
    if "items" in response:
        for g in response["items"][0]["volumeInfo"]["categories"]:
            if g in user["preferences"]["booksGenres"]:
                score += (WEIGHTS["genres"] * 100) / len(response["items"][0]["volumeInfo"]["categories"])
    print("genre score: " + str(score))
    return score

def calculate_critics_score(book, user):
    score = 0
    google_books_api = build("books", "v1", developerKey=os.getenv("GOOGLE_BOOKS_API_KEY"))
    response = google_books_api.volumes().list(q="isbn:" + book["primary_isbn13"]).execute()
    if "items" in response:
        try:
            score = (response["items"][0]["volumeInfo"]["averageRating"] * 20) * WEIGHTS["critics"]
        except:
            print("no rating")
    print("critics score: " + str(score))
    return score

def calculate_popularity_score(book, user):
    score = 0
    google_books_api = build("books", "v1", developerKey=os.getenv("GOOGLE_BOOKS_API_KEY"))
    response = google_books_api.volumes().list(q="isbn:" + book["primary_isbn13"]).execute()
    if "items" in response:
        try:
            score = (response["items"][0]["volumeInfo"]["ratingsCount"] / 100000) * WEIGHTS["popularity"]
        except:
            print("no rating")
    print("popularity score: " + str(score))
    return score

    #api = GoogleBooksAPI()
    #result = { "recommendations": [] }
    #copy_list = []
    #
    #for p in api.get_books_by_author("J.K. Rowling"):
    #    copy_list.append(p)
    #random.shuffle(copy_list)
    #print(copy_list[0])
    # for p in range(5):
    #    result["recommendations"].append({
    #        "title": copy_list[p].title,
    #        "score": random.randint(1, 100)
    #    })
    # sorted(result["recommendations"], key=lambda k: k['score'], reverse=True)
    # return result

def main():
    externalSessionAccount = json.loads(sys.argv[1])
    result = RecommandBooks(externalSessionAccount)
    print(json.dumps(result))

main()