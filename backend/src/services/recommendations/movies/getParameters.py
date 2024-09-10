#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json


def getmoviesDetailsConcurrently(movies: list[int]):
    return []


def getLikedMoviesParameters(parameters: json) -> json:
    # TODO : add in parameters dislikedGenres, leastFavouriteEpoch
    # likedMoviesDetails = getmoviesDetailsConcurrently(parameters.likedMovies)
    # print(likedMoviesDetails)
    # parameters.likedMovied
    # return {
    #     ...parameters,
    #     "likedMoviesGenres": [421412, 41241, 4214]
    # }
    return parameters


def getDislikedMoviesParameters(parameters: json) -> json:
    # TODO : add in parameters likedGenres, favouriteEpoch, favouriteMovieDirector
    # dislikedMoviesDetails = getmoviesDetailsConcurrently(parameters.dislikedMovies)
    # print(dislikedMoviesDetails)
    # return {
    #     ...parameters,
    #     "likedMoviesGenres": [421412, 41241, 4214]
    # }
    return parameters


def getParameters(account: json) -> json:
    try:
        parameters = {
            "history": account["recommendedMoviesHistory"],
            "seenMovies": account["seenMovies"],
            "likedMovies": account["likedMovies"],
            "dislikedMovies": account["likedMovies"],
            "genres": account["preferences"]["moviesGenres"],
            "likedGenres": None,
            "favouriteEpoch": None,
            "favouriteMovieDirector": None,
            "dislikedGenres": None,
            "leastFavouriteEpoch": None
        }
        if parameters["likedMovies"] is not None:
            parameters = getLikedMoviesParameters(parameters)
        if parameters["dislikedMovies"] is not None:
            parameters = getDislikedMoviesParameters(parameters)
        return parameters
    except KeyError as e:
        print(f"Missing key in account data: {e}")
        return {}
    except TypeError as e:
        print(f"Type error: {e}")
        return {}
