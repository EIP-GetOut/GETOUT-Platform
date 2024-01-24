import sys
import os
import json
import random
from datetime import datetime, timedelta
from googleapiclient.discovery import build
from google_books_api_wrapper.api import GoogleBooksAPI

from pynytimes import NYTAPI

WEIGHTS = {
    "genres": 0.3,
    "critics": 0.35,
    "popularity": 0.35
}

API_GOOGLE = GoogleBooksAPI()

def RecommandBooks(user: json) -> json:
    # if last refresh is less than 24h ago return null

    if user["lastRefresh"] != None:
        last_refresh = datetime.strptime(user["lastRefresh"], "%Y-%m-%dT%H:%M:%S.%fZ")
        if last_refresh + timedelta(hours=24) > datetime.now():
            return None

    nyt = NYTAPI("EWZh85CC8ZWDpC7eL2fi8zBnIu9Gtwp3", parse_dates=True)
    # get a 100 best sellers
    best_sellers = nyt.best_sellers_list()
    result = { "recommandations": [] }
    copy_list = []
    for p in best_sellers:
        copy_list.append(p)
    for p in range(len(copy_list)):
        result["recommandations"].append({
            "title": copy_list[p]["title"],
            "isbn13": copy_list[p]["primary_isbn13"],
            "score": calculate_score(copy_list[p], user)
        })
    result["recommandations"] = sorted(result["recommandations"], key=lambda k: k['score'], reverse=True)[:5]
    return result
    # get info from google api about the first book
    #print(best_sellers[0]["primary_isbn13"])
    #print(best_sellers[0]["title"])
    #service = build("books", "v1", developerKey=os.environ.get("GOOGLE_BOOKS_KEY"))
    ## search a book by isbn13
    #response = service.volumes().list(q="isbn:" +"9781781105542").execute()
#
    #if "items" in response:
    #    # print the book in json formatted string
    #    print(json.dumps(response["items"][0], indent=4, sort_keys=True))
    #return None

def calculate_score(book, user):
    print("---------------------------------")
    print("calculate score")
    print(book["title"])
    #book_google = API_GOOGLE.get_book_by_isbn13(book["primary_isbn13"])
    score = 0
    score += calculate_genre_score(book_google, user)
    score += calculate_critics_score(book_google, user)
    score += calculate_popularity_score(book_google, user)
    print("total score: " + str(score))
    print("---------------------------------")
    score = random.randint(1, 100)
    return score

def calculate_genre_score(book, user):
    score = 0

    return score

def calculate_critics_score(book, user):
    score = 0
    return score

def calculate_popularity_score(book, user):
    score = 0
    return score

    #api = GoogleBooksAPI()
    #result = { "recommandations": [] }
    #copy_list = []
    #
    #for p in api.get_books_by_author("J.K. Rowling"):
    #    copy_list.append(p)
    #random.shuffle(copy_list)
    #print(copy_list[0])
    #for p in range(5):
    #    result["recommandations"].append({
    #        "title": copy_list[p].title,
    #        "score": random.randint(1, 100)
    #    })
    #sorted(result["recommandations"], key=lambda k: k['score'], reverse=True)
    #return result

