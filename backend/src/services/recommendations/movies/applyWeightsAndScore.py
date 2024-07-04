#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json

WEIGHTS = {
    "genres": 0.2,
    "plateform": 0.1,
    "critics": 0.35,
    "popularity": 0.35
}

# def calculate_genre_score(movie, account):
#     score = 0
#     nb_genre = len(movie.genre_ids)
#     for g in movie.genre_ids:
#         if g in account["preferences"]["moviesGenres"]:
#             score += WEIGHTS["genres"] / nb_genre
#     return score

# def calculate_critics_score(movie, account):
#     score = (movie.vote_average * 10) * WEIGHTS["critics"]
#     return score

# def recommendMovies(account: dict) -> list:
#     parameters = {
#         "movieGenres": account["preferences"]["moviesGenres"]
#     }
#     moviesPool = getMoviesPool(parameters)
#     recommendations = applyWeightsAndScore(parameters, moviesPool)
#     return recommendations


# def calculate_score(movie, account):
#     score = 0
#     score += calculate_genre_score(movie, account)
#     score += calculate_critics_score(movie, account)
#     return score


def applyWeightsAndScore(parameters: json, moviesPool: list) -> json:
    recommendations = []
    for i in range(len(moviesPool)):
        recommendations.append({
            "id": moviesPool[i]["id"],
            "title": moviesPool[i]["title"],
            "score": moviesPool[i]["score"]
        })

    recommendations = sorted(recommendations, key=lambda k: k["score"], reverse=True)
    return recommendations
