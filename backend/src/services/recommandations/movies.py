import sys
import os
import json
import random
from datetime import datetime, timedelta
from tmdbv3api import TMDb, Movie

WEIGHTS = {
    "genres": 0.2,
    "plateform": 0.1,
    "critics": 0.35,
    "popularity": 0.35
}

def RecommandMovies(user: json) -> json:
    # if last refresh is less than 24h ago return null
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
    popular = movie.popular({"language": "fr-FR", "page": 1000})
 
    result = { "recommands": [] }
    copy_list = []
    for p in popular:
        copy_list.append(p)
    random.shuffle(copy_list)
    for p in range(len(copy_list)):
        print(p)
        result["recommands"].append({
            "id": copy_list[p].id,
            "title": copy_list[p].title,
            "score": calculate_score(copy_list[p], user)
        })
    print("after")
    result["recommands"] = sorted(result["recommands"], key=lambda k: k['score'], reverse=True)[:5]
    return result

def calculate_score(movie, user):
    print("---------------------------------")
    print("calculate score")
    print(movie)
    score = 0
    score += calculate_genre_score(movie, user)
    score += calculate_plateform_score(movie, user)
    score += calculate_critics_score(movie, user)
    score += calculate_popularity_score(movie, user)
    print("total score: " + str(score))
    print("---------------------------------")
    return score

def calculate_genre_score(movie, user):
    score = 0
    nb_genre = len(movie.genre_ids)
    for g in movie.genre_ids:
        if g in user["preferences"]["movies"]:
            score += WEIGHTS["genres"] / nb_genre
    print("genre score: " + str(score))
    return score

def calculate_plateform_score(movie, user):
    v = random.randint(1, 100) * WEIGHTS["plateform"]
    print("plateform score (random): " + str(v))
    return v
    score = 0
    for p in movie.production_companies:
        if p["id"] in user["avalailablePlateform"]:
            score += WEIGHTS["plateform"]
    return score

def calculate_critics_score(movie, user):
    score = (movie.vote_average * 10) * WEIGHTS["critics"]
    print("critics score: " + str(score))
    return score

def calculate_popularity_score(movie, user):
    score = (movie.popularity / 10) * WEIGHTS["popularity"]
    print("popularity score: " + str(score))
    return score
