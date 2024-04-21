import sys
import os
import json
import random
import requests
from datetime import datetime, timedelta
from tmdbv3api import TMDb, Movie
from dotenv import load_dotenv

WEIGHTS = {
    "genres": 0.2,
    "plateform": 0.1,
    "critics": 0.35,
    "popularity": 0.35
}

def recommandMovies(account: json) -> json:
    load_dotenv()
    tmdb = TMDb()
    tmdb.api_key = os.getenv("MOVIE_DB_KEY")

    # give me a 500 popular movies
    movie = Movie()
    # popular = movie.popular({"language": "fr-FR", "page": 500})

    get_similar_movies('693134', movie)
    result = { "recommendations": [] }
    copy_list = []
    films_likes = [385687, 9615, 584, 168259]
    scores = {}
    for movie_id in films_likes:
        similar_movies = get_similar_movies(movie_id, movie)
        for similar_movie_id in similar_movies:
            if similar_movie_id in scores:
                scores[similar_movie_id] += 1
            else:
                scores[similar_movie_id] = 1
    print("Scores des films similaires :")
    for movie_id, score in scores.items():
        print(f"ID du film : {movie_id}, Score : {score}")
    # for p in popular:
    #     copy_list.append(p)
    # for p in range(len(copy_list)):
    #     result["recommendations"].append({
    #         "id": copy_list[p].id,
    #         "title": copy_list[p].title,
    #         "score": calculate_score(copy_list[p], account)
    #     })
    # result["recommendations"] = sorted(result["recommendations"], key=lambda k: k['score'], reverse=True)[:5]
    return result

def calculate_score(movie, account):
    # print("---------------------------------")
    # print("calculate score")
    # print(movie)
    score = 0
    score += calculate_genre_score(movie, account)
    # score += calculate_plateform_score(movie, account)
    score += calculate_critics_score(movie, account)
    # score += calculate_popularity_score(movie, account)
    # print("total score: " + str(score))
    # print("---------------------------------")
    return score

def calculate_genre_score(movie, account):
    score = 0
    nb_genre = len(movie.genre_ids)
    for g in movie.genre_ids:
        if g in account["preferences"]["moviesGenres"]:
            score += WEIGHTS["genres"] / nb_genre
    # print("genre score: " + str(score))
    return score

def get_similar_movies(idMovie, movie: Movie):
    data = movie.recommendations(idMovie)
    ids = [entry['id'] for entry in data['results']]
    return ids

def calculate_plateform_score(movie, account):
    #Note: TMDB need to call another route to get available platforms (and i am not able to find them yet on account)
    v = random.randint(1, 100) * WEIGHTS["plateform"]
    # print("plateform score (random): " + str(v))
    return v
    score = 0
    for p in movie.production_companies:
        if p["id"] in account["avalailablePlateform"]:
            score += WEIGHTS["plateform"]
    return score

def calculate_critics_score(movie, account):
    score = (movie.vote_average * 10) * WEIGHTS["critics"]
    # print("critics score: " + str(score))
    return score

def calculate_popularity_score(movie, account):
    score = (movie.popularity / 10) * WEIGHTS["popularity"]
    # print("popularity score: " + str(score))
    return score

def main():
    externalSessionAccount = json.loads(sys.argv[1])
    result = recommandMovies(externalSessionAccount)
    print(json.dumps(result))

main()
