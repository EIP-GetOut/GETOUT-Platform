import sys
import os
import json
import random
from datetime import datetime, timedelta
from googleapiclient.discovery import build
# from google_books_api_wrapper.api import GoogleBooksAPI

from pynytimes import NYTAPI

WEIGHTS = {
    "genres": 0.3,
    "critics": 0.35,
    "popularity": 0.35
}

# API_GOOGLE = GoogleBooksAPI()

def RecommandBooks(user: json) -> json:
    nyt = NYTAPI("EWZh85CC8ZWDpC7eL2fi8zBnIu9Gtwp3", parse_dates=True)
    # get a 100 best sellers
    best_sellers = nyt.best_sellers_list()
    result = { "recommendations": [] }
    copy_list = []
    for p in best_sellers:
        copy_list.append(p)
    for p in range(len(copy_list)):
        result["recommendations"].append({
            "title": copy_list[p]["title"],
            "isbn13": copy_list[p]["primary_isbn13"],
            "score": calculate_score(copy_list[p], user)
        })
    result["recommendations"] = sorted(result["recommendations"], key=lambda k: k['score'], reverse=True)[:5]
    google_books_api = build("books", "v1", developerKey=os.getenv("GOOGLE_BOOKS_API_KEY"))
    for r in result["recommendations"]:
        r["id"] = google_books_api.volumes().list(q="isbn:" + r["isbn13"]).execute()["items"][0]["id"]
    return result
    # get info from google api about the first book
    #print(best_sellers[0]["primary_isbn13"])
    #print(best_sellers[0]["title"])
    #service = build("books", "v1", developerKey=os.environ.get("GOOGLE_BOOKS_API_KEY"))
    ## search a book by isbn13
    #response = service.volumes().list(q="isbn:" +"9781781105542").execute()
#
    #if "items" in response:
    #    # print the book in json formatted string
    #    print(json.dumps(response["items"][0], indent=4, sort_keys=True))
    #return None

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
    #for p in range(5):
    #    result["recommendations"].append({
    #        "title": copy_list[p].title,
    #        "score": random.randint(1, 100)
    #    })
    #sorted(result["recommendations"], key=lambda k: k['score'], reverse=True)
    #return result

def main():
    externalSessionAccount = json.loads(sys.argv[1])
    result = RecommandBooks(externalSessionAccount)
    print(json.dumps(result))

main()