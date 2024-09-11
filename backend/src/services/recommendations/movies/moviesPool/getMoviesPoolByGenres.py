#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

from filterMoviesPool import filterMoviesPool
from .constants import MOVIES_POOL_BY_GENRES_LENGTH, MOVIES_POOL_LENGTH
from tmdbv3api import Discover
import random


def formatMovieList(movieList: list[dict]) -> list[dict]:
    formatedMovieList = []

    for movie in movieList:
        # TODO : include director
        # director = next((crew for crew in movie.get("credits", {}).get("crew", []) if crew['job'] == 'Director'), None)

        filteredMovie = {
            "id": movie.get("id"),
            "title": movie.get("title"),
            "genres": movie.get("genre_ids", []),
            "releaseDate": movie.get("release_date"),
            "director": None
        }

        formatedMovieList.append(filteredMovie)

    return formatedMovieList


def getMoviesPoolByGenres(parameters: dict) -> list:
    discoverApi = Discover()
    moviesPool = []
    print(MOVIES_POOL_BY_GENRES_LENGTH)
    iterations = 0
    while len(moviesPool) < MOVIES_POOL_BY_GENRES_LENGTH * 5 and iterations < 10:
        for page in range(10 * iterations + 1, 10 * (iterations + 1)):
            discoveredMovies = discoverApi.discover_movies({
                'with_genres': '|'.join(map(str, parameters["genres"])),
                'language': 'fr-FR',
                'page': page
            })
            moviesObtained = discoveredMovies["results"]
            if len(moviesObtained) > 0:
                moviesPool.extend(formatMovieList(moviesObtained))
        moviesPool = filterMoviesPool(parameters, moviesPool)
        iterations += 1
    random.shuffle(moviesPool)
    ## TODO, SHOULD BE MOVIES_POOL_BY_GENRES_LENGTH BUT FOR DEBUG PURPOSES
    if len(moviesPool) < MOVIES_POOL_LENGTH:
        return moviesPool
    else:
        return moviesPool[0: MOVIES_POOL_LENGTH]
