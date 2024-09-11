#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import sys

def filterMoviesPool(parameters: dict, moviesPool: list) -> list:
    exploredMoviesIds = set()
    uniqueMoviesPool = []

    for movie in moviesPool:
        id = movie["id"]
        if id not in exploredMoviesIds and id not in parameters["history"] and id not in parameters["seenMovies"]:
            exploredMoviesIds.add(id)
            uniqueMoviesPool.append(movie)
    return uniqueMoviesPool
