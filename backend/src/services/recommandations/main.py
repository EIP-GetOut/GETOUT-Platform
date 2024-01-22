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