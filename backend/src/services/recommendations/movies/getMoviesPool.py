#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import os
import json
from tmdbv3api import TMDb, Movie, Discover


def getRecommendationsFromLikedMovie(idMovie, movieApi: Movie):
    movies = []
    try:
        for page in range(1, 3):
            similarMovies = movieApi.recommendations(idMovie, page=page)
            movies += similarMovies['results']
        return movies
    except Exception as e:
        print(f"An error occurred while fetching recommendations for movie ID {idMovie}: {e}")
        raise


def addScoreToMovies(moviesPool: list, similarityScoresById: dict):
    for movie in moviesPool:
        movie["score"] = similarityScoresById[movie["id"]] if movie["id"] in similarityScoresById else 0
    return moviesPool


def getMoviesPoolByLikedMovies(parameters: dict, movieApi: Movie) -> list:
    try:
        moviesPool = []
        similarityScoresById = {}
        for likedMovieId in parameters["likedMovies"]:
            movies = getRecommendationsFromLikedMovie(likedMovieId, movieApi)
            for movie in movies:
                movie["id"]
                if movie["id"] in similarityScoresById:
                    similarityScoresById[movie["id"]] += 1
                else:
                    similarityScoresById[movie["id"]] = 0
            moviesPool += movies
        addScoreToMovies(moviesPool, similarityScoresById)
        return moviesPool
    except Exception as e:
        print(f"An error occurred while generating the movies pool by liked movies: {e}")
        raise


def getMoviesPoolByGenres(parameters: dict) -> list:
    discoverApi = Discover()
    moviesPool = []
    try:
        for genre in parameters["genres"]:
            for page in range(1, 10):
                try:
                    discoveredMovies = discoverApi.discover_movies({
                        'with_genres': str(genre),
                        'language': 'fr-FR',
                        page: page
                    })
                    moviesPool += discoveredMovies["results"]
                except Exception as e:
                    print(f"An error occurred while discovering movies for genre {genre} on page {page}: {e}")
            return [{**movie, "score": 0} for movie in moviesPool]
    except Exception as e:
        print(f"An error occurred while generating the movies pool by genres: {e}")
        raise


def getMoviesPool(parameters: dict) -> list:
    try:
        moviesPool = []
        tmdb = TMDb()
        tmdb.api_key = os.getenv("MOVIE_DB_KEY")
        movieApi = Movie()

        if len(parameters["likedMovies"]) >= 5:
            moviesPool = getMoviesPoolByLikedMovies(parameters, movieApi)
        else:
            moviesPool = getMoviesPoolByGenres(parameters)
        return moviesPool
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON from input: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
