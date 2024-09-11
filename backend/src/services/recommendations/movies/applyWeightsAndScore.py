#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json


def calculate_movie_score(parameters: json, movie: json) -> float:
    score = 0
    if movie.genre in parameters.favorite_genres:
        score += 0.4
    elif movie.genre in [m.genre for m in parameters.disliked_movies]:
        score -= 0.2
    if movie.director in [m.director for m in parameters.liked_movies]:
        score += 0.2
    elif movie.director in [m.director for m in parameters.disliked_movies]:
        score -= 0.2
    if movie.era in parameters.favorite_eras:
        score += 0.2
    elif movie.era in [m.era for m in parameters.disliked_movies]:
        score -= 0.1

    return score


def applyWeightsAndScore(parameters: json, moviesPool: list) -> json:
    recommendations = []
    for i in range(len(moviesPool)):
        recommendations.append({
            "id": moviesPool[i]["id"],
            "title": moviesPool[i]["title"],
            "score": 0
        })

    recommendations = sorted(recommendations, key=lambda k: k["score"], reverse=True)
    return recommendations
