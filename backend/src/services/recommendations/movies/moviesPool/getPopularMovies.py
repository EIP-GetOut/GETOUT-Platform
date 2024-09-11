#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

from tmdbv3api import Movie
from .utils import formatMovieList
from .filterMoviesPool import filterMoviesPool
from .constants import MOVIES_POOL_LENGTH


def getPopularMovies(parameters: dict, moviesPool: list[int], movieApi: Movie) -> list:
    iteration = 1
    while len(moviesPool) < MOVIES_POOL_LENGTH and iteration < 20:
        movies = movieApi.popular('fr', page=iteration)
        moviesPool.extend(formatMovieList(movies))
        moviesPool = filterMoviesPool(parameters, moviesPool)
        iteration += 1
    return moviesPool[0: 200]
