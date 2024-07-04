#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

def filterMoviesPool(parameters: dict, moviesPool: list) -> list:
    exploredMoviesTitles = set()
    uniqueMoviesPool = []

    for movie in moviesPool:
        id = movie["id"]
        title = movie["original_title"]
        if title not in exploredMoviesTitles and id not in parameters["history"] and id not in parameters["seenMovies"]:
            exploredMoviesTitles.add(title)
            uniqueMoviesPool.append(movie)
    return uniqueMoviesPool
