#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

from tmdbv3api import Movie, Discover, Person
from .utils import formatMovieList


def getMoviesPoolByFavouriteDirector(parameters: dict) -> list:
    personApi = Person()

    moviesPool = []

    for director in parameters["favouriteMovieDirector"]:
        response = personApi.movie_credits(director)
        moviesWithTheDirectorAsACrew = response['crew']

        for movie in moviesWithTheDirectorAsACrew:
            movie["director"] = director
        moviesPool.extend(formatMovieList(moviesWithTheDirectorAsACrew))
    return moviesPool
