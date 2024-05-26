import sys
import os
from dotenv import load_dotenv
import json

from movies import RecommandMovies
from books import RecommandBooks

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
        f = open("backend/src/services/recommendations/user.json")
        user = json.load(f).get("account")[0]
        print(user)
        print("movie recommendations")
        movie_recomandations = RecommandMovies(user)
        if movie_recomandations == None:
            print("no recommendations")
        else :
            for r in movie_recomandations["recommendations"]:
                print("----------------------")
                print(r)
        print("book recommendations")
        book_recomandations = RecommandBooks(user)
        if book_recomandations == None:
            print("no recommendations")
        else :
            for r in book_recomandations["recommendations"]:
                print("----------------------")
                print(r)

    except:
        print("Error", sys.exc_info()[0])