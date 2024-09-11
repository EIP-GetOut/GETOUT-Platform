#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

from tmdbv3api import Movie
from .filterMoviesPool import filterMoviesPool
from .constants import MOVIES_POOL_BY_LIKED_GENRES_LENGTH
from .utils import formatMovieList


def getRecommendationsFromLikedMovie(idMovie: int, movieApi: Movie, iteration: int):
    movies = []
    try:
        for page in range(5 * iteration + 1, 5 * (iteration + 1)):
            similarMovies = movieApi.recommendations(idMovie, page=page)
            moviesObtained = similarMovies['results']
            if len(moviesObtained) > 0:
                movies.extend(formatMovieList(similarMovies['results']))
        return movies
    except Exception as e:
        print(f"An error occurred while fetching recommendations for movie ID {idMovie}: {e}")
        raise


def getMoviesPoolByLikedMovies(parameters: dict, movieApi: Movie) -> list:
    # TODO : ALSO ADD MOVIES FROM LIKED GENRES
    try:
        moviesPool = []
        iterations = 0
        while len(moviesPool) < MOVIES_POOL_BY_LIKED_GENRES_LENGTH:
            for likedMovieId in parameters["likedMovies"]:
                movies = getRecommendationsFromLikedMovie(likedMovieId, movieApi, iterations)
                moviesPool.extend(movies)
                moviesPool = filterMoviesPool(parameters, moviesPool)
            iterations += 1
        return moviesPool if len(moviesPool) < MOVIES_POOL_BY_LIKED_GENRES_LENGTH else moviesPool[0: MOVIES_POOL_BY_LIKED_GENRES_LENGTH]
    except Exception as e:
        print(f"An error occurred while generating the movies pool by liked movies: {e}")
        raise
