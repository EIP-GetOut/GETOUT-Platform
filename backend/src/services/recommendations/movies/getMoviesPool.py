#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import os
import json
from tmdbv3api import TMDb, Movie

from moviesPool.getMoviesPoolByLikedMovies import getMoviesPoolByLikedMovies
from moviesPool.getMoviesPoolByFavouriteDirector import getMoviesPoolByFavouriteDirector
from moviesPool.getMoviesPoolByGenres import getMoviesPoolByGenres
from moviesPool.getPopularMovies import getPopularMovies


def getMoviesPool(parameters: dict) -> list:
    moviesPool = []
    tmdb = TMDb()
    tmdb.api_key = os.getenv("MOVIE_DB_KEY")
    movieApi = Movie()

    moviePoolByGenres = getMoviesPoolByGenres(parameters)
    # if len(parameters["likedMovies"]) >= 5:
    #     moviesPoolByLikedMovies = getMoviesPoolByLikedMovies(parameters, movieApi)
    # if parameters["favouriteMovieDirector"] is not None:
    #     moviePoolByFavouriteDirector = getMoviesPoolByFavouriteDirector(parameters, movieApi)
    # moviesPool = moviePoolByGenres + moviesPoolByLikedMovies + moviePoolByFavouriteDirector

    # if len(moviesPool) < 200:
    #     return getPopularMovies(parameters, movieApi, 200 - len(moviesPool))
    return moviePoolByGenres
    # return moviesPool TODO: return the full moviesPool
