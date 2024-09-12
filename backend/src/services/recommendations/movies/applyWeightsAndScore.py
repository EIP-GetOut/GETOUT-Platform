#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json
import random


def recommend_movies_with_parameters(parameters, movies):
    history = parameters["history"]
    seen_movies = parameters["seenMovies"]
    excluded_movies = set(history + seen_movies)
    liked_genres = parameters.get("likedGenres", [])
    disliked_genres = parameters.get("dislikedGenres", [])
    favourite_epoch = parameters.get("favouriteEpoch")
    least_favourite_epoch = parameters.get("leastFavouriteEpoch")
    favourite_director = parameters.get("favouriteMovieDirector", [])
    if not isinstance(favourite_director, list):
           favourite_director = [favourite_director]
    if not isinstance(liked_genres, list):
           liked_genres = [liked_genres]
    if not isinstance(disliked_genres, list):
            disliked_genres = [disliked_genres]

    def is_in_decade(year, decade_str):
        try:
            decade_start = int(decade_str[:4])
            return decade_start <= year < decade_start + 10
        except (ValueError, TypeError):
            return False

    def extract_year_from_date(date_str):
        try:
            return int(date_str[:4])
        except (ValueError, TypeError):
            return None

    def normalize_score(x, min_val=-0.8, max_val=2.2):
        return ((x - min_val) / (max_val - min_val)) * 100

    def calculate_movie_score(movie):
        score = 0
        print("movie genre", movie["genres"])
        print("params genre : ", parameters["genres"])
        for i in range(len(movie["genres"])):
            if movie["genres"][i] in parameters["genres"]:
                score += 1.0
        for i in range(len(movie["genres"])):
            if liked_genres[0] and movie["genres"][i] in parameters["likedGenres"]:
                print("test genre liké")
                score += 0.5
        for i in range(len(movie["genres"])):
            if disliked_genres[0] and movie["genres"][i] in parameters["dislikedGenres"]:
                score -= 0.5
        movie_year = extract_year_from_date(movie["releaseDate"])
        if movie_year is not None:
            if favourite_epoch and is_in_decade(movie_year, favourite_epoch):
                score += 0.3
            elif least_favourite_epoch and is_in_decade(movie_year, least_favourite_epoch):
                score -= 0.3
        if favourite_director[0] and movie["director"] in parameters["favouriteMovieDirector"]:
            print("test director")
            score += 0.4
        return score
    scored_movies = []
    for movie in movies:
        if movie["title"] not in excluded_movies:
            score = calculate_movie_score(movie)
            scored_movies.append({
                "id": movie["id"],
                "title": movie["title"],
                "score": normalize_score(score)
            })

    scored_movies.sort(key=lambda x: x["score"], reverse=True)
    return scored_movies[:5]



def applyWeightsAndScore(parameters: json, moviesPool: list) -> json:
    recommendations = recommend_movies_with_parameters(parameters, moviesPool)
    recommendations = sorted(recommendations, key=lambda k: k["score"], reverse=True)
    return recommendations
