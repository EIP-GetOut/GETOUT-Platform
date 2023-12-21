import sys
import os
import requests
from dotenv import load_dotenv
import json
from tmdbv3api import TMDb, Movie
import random
from datetime import datetime, timedelta
from google_books_api_wrapper.api import GoogleBooksAPI

def RecommandMovies(user: json) -> json:
    # if last refresh is less than 24h ago return null
    print("user")
    if user["lastRefresh"] != None:
        print("last refresh")
        last_refresh = datetime.strptime(user["lastRefresh"], "%Y-%m-%dT%H:%M:%S.%fZ")
        print(last_refresh)
        if last_refresh + timedelta(hours=24) > datetime.now():
            return None
    tmdb = TMDb()
    tmdb.api_key = os.getenv("MOVIE_DB_KEY")
    # give me a 100 popular movies
    movie = Movie()
    popular = movie.popular({"language": "fr-FR", "page": 5})
 
    result = { "recommands": [] }
    copy_list = []
    for p in popular:
        copy_list.append(p)
    random.shuffle(copy_list)
    for p in range(5):
        result["recommands"].append({
            "id": copy_list[p].id,
            "title": copy_list[p].title,
            "score": random.randint(1, 100)
        })
    sorted(result["recommands"], key=lambda k: k['score'], reverse=True)
    return result

def RecommandBooks(user: json) -> json:
    # if last refresh is less than 24h ago return null

    if user["lastRefresh"] != None:
        last_refresh = datetime.strptime(user["lastRefresh"], "%Y-%m-%dT%H:%M:%S.%fZ")
        if last_refresh + timedelta(hours=24) > datetime.now():
            return None
    api = GoogleBooksAPI()
    result = { "recommands": [] }
    copy_list = []
    for p in api.get_books_by_author("J.K. Rowling"):
        copy_list.append(p)
    random.shuffle(copy_list)
    print(copy_list[0])
    for p in range(5):
        result["recommands"].append({
            "title": copy_list[p].title,
            "score": random.randint(1, 100)
        })
    sorted(result["recommands"], key=lambda k: k['score'], reverse=True)
    return result

def getUsers():
    load_dotenv()
    print(os.getenv("API_URL"))
    url = os.getenv("API_URL") + "/random"
    text = requests.get(url)

    if text.status_code == 200:
        return text.json()
    else:
        return None

if __name__ == "__main__":
    try:
        load_dotenv()
        print("user")
        f = open("backend/src/services/recommandations/user.json")
        user = json.load(f).get("account")[0]
        print(user)
        print("movie recommandations")
        movie_recomandations = RecommandMovies(user)
        if movie_recomandations == None:
            print("no recommandations")
        else :
            for r in movie_recomandations["recommands"]:
                print("----------------------")
                print(r)
        print("book recommandations")
        book_recomandations = RecommandBooks(user)
        if book_recomandations == None:
            print("no recommandations")
        else :
            for r in book_recomandations["recommands"]:
                print("----------------------")
                print(r)

    except:
        print("Error", sys.exc_info()[0])