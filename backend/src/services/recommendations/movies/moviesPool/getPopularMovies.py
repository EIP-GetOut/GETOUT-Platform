#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

from tmdbv3api import Movie


def getPopularMovies(parameters: dict, movieApi: Movie, numberOfMoviesToGet: int) -> list:
    moviesPool = []
    iterations = 0
    while len(moviesPool) < numberOfMoviesToGet and iterations < 20:
        movies = movieApi.popular('fr', page=iteration)
        moviesPool.append(movies)
        iteration += 1
    return moviesPool
