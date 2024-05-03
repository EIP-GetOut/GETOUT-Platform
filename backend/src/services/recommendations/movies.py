import sys
import os
import json
import random
import requests
from datetime import datetime, timedelta
from tmdbv3api import TMDb, Movie
# from dotenv import load_dotenv

WEIGHTS = {
    "genres": 0.2,
    "plateform": 0.1,
    "critics": 0.35,
    "popularity": 0.35
}

def comparer_genre_ids(films, mes_genre_ids):
    films_correspondants = []
    for film in films:
        for genre_id in film['genre_ids']:
            if genre_id in mes_genre_ids:
                films_correspondants.append(film['id'])
                if len(films_correspondants) >= 5:
                    return films_correspondants
                break
    return films_correspondants

def recommendation_genre(account, movie: Movie):
    movie = Movie()
    popular = movie.popular({"language": "fr-FR", "page": 500})
    films_correspondants = comparer_genre_ids(popular, account["preferences"]["moviesGenres"])
    result = {}
    id_title_pairs = []
    result["recommendations"] = []
    for book_id in films_correspondants:
        title = movie.details(book_id)["original_title"]
        id_title_pairs.append([book_id, title])
    # print(id_title_pairs)
    for p in range(len(id_title_pairs)):
        result["recommendations"].append({
            "id": id_title_pairs[p][0],
            "title": id_title_pairs[p][1],
            "score": random.randint(0, 100)
        })
    result["recommendations"] = sorted(result["recommendations"], key=lambda k: k['score'], reverse=True)[:5]
    # print(result)
    return result


def give_recommendation(account, list):
    test = sorted(list.items(), key=lambda x: x[1], reverse=True)
    films_non_vus = []
    for film in test:
        if film[0] not in account["seenMovies"]:
            films_non_vus.append(film[0])
            if len(films_non_vus) == 5:
                break
    return films_non_vus

def test(account: json) -> json:
    tmdb = TMDb()
    tmdb.api_key = os.getenv("MOVIE_DB_KEY")

    movie = Movie()
    if (len(account["likedMovies"]) != 0):
        return recommandMovies(account)
    else:
        return recommendation_genre(account, movie)

def recommandMovies(account):
    # load_dotenv()
    tmdb = TMDb()
    tmdb.api_key = os.getenv("MOVIE_DB_KEY")

    movie = Movie()
    films_likes = account["likedMovies"]
    scores = {}
    result = {}
    for movie_id in films_likes:
        similar_movies = get_similar_movies(movie_id, movie)
        for similar_movie_id in similar_movies:
            if similar_movie_id in scores:
                scores[similar_movie_id] += 1
            else:
                scores[similar_movie_id] = 1
    result2 = give_recommendation(account, scores)
    id_title_pairs = []
    result["recommendations"] = []
    for book_id in result2:
        title = movie.details(book_id)["original_title"]
        id_title_pairs.append([book_id, title])
    for p in range(len(id_title_pairs)):
        result["recommendations"].append({
            "id": id_title_pairs[p][0],
            "title": id_title_pairs[p][1],
            "score": random.randint(0, 100)
        })
    result["recommendations"] = sorted(result["recommendations"], key=lambda k: k['score'], reverse=True)[:5]
    return result

def calculate_score(movie, account):
    score = 0
    score += calculate_genre_score(movie, account)
    score += calculate_critics_score(movie, account)
    return score

def calculate_genre_score(movie, account):
    score = 0
    nb_genre = len(movie.genre_ids)
    for g in movie.genre_ids:
        if g in account["preferences"]["moviesGenres"]:
            score += WEIGHTS["genres"] / nb_genre
    return score

def get_similar_movies(idMovie, movie: Movie):
    data = movie.recommendations(idMovie)
    ids = [entry['id'] for entry in data['results']]
    title = [entry['title'] for entry in data['results']]
    return ids

def calculate_critics_score(movie, account):
    score = (movie.vote_average * 10) * WEIGHTS["critics"]
    return score

def main():
    externalSessionAccount = json.loads(sys.argv[1])
    result = test(externalSessionAccount)
    print(json.dumps(result))
    return result

main()
