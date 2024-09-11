#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

from tmdbv3api import Movie
from filterMoviesPool import filterMoviesPool
from .constants import MOVIES_POOL_BY_LIKED_GENRES_LENGTH


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


def getMoviesPoolByLikedMovies(parameters: dict, movieApi: Movie) -> list:
    # TODO : ALSO ADD MOVIES FROM LIKED GENRES
    try:
        moviesPool = []
        for likedMovieId in parameters["likedMovies"] and len(moviesPool) < MOVIES_POOL_BY_LIKED_GENRES_LENGTH:
            movies = getRecommendationsFromLikedMovie(likedMovieId, movieApi)
            moviesPool = moviesPool.append(movies)
            moviesPool = filterMoviesPool(parameters, moviesPool)
        return moviesPool if len(moviesPool) < MOVIES_POOL_BY_LIKED_GENRES_LENGTH else moviesPool[0: MOVIES_POOL_BY_LIKED_GENRES_LENGTH]
    except Exception as e:
        print(f"An error occurred while generating the movies pool by liked movies: {e}")
        raise
