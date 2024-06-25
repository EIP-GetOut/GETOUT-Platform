#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json


def getParameters(account: json) -> json:
    try:
        parameters = {
            "history": account["recommendedMoviesHistory"],
            "seenMovies": account["seenMovies"],
            "likedMovies": account["likedMovies"],
            "dislikedMovies": account["likedMovies"],
            "genres": account["preferences"]["moviesGenres"]
        }
        # Add favourite genres / favourite epoch / favourite realisator here from the liked books
        # in parameters.favouriteRealisators or parameters.favouriteEpoch
        # Also add least favourite genres / epoch / realisator from the disliked movies in parameters
        return parameters
    except KeyError as e:
        print(f"Missing key in account data: {e}")
        return {}
    except TypeError as e:
        print(f"Type error: {e}")
        return {}
