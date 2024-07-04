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
            "history": account["recommendedBooksHistory"],
            "readBooks": account["readBooks"],
            "likedBooks": account["likedBooks"],
            "dislikedBooks": account["likedBooks"],
            "genres": account["preferences"]["booksGenres"]
        }
        # Add favourite genres / favourite epoch / favourite writer here from the liked books
        # in parameters.favouriteWriters or parameters.favouriteEpoch
        # Also add least favourite genres / epoch / writer from the disliked books in parameters
        return parameters
    except KeyError as e:
        print(f"Missing key in account data: {e}")
        return {}
    except TypeError as e:
        print(f"Type error: {e}")
        return {}
