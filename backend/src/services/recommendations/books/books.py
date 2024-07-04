#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Julien Letoux <julien.letoux@epitech.eu>
#

import sys
import json

from getParameters import getParameters
from getBooksPool import getBooksPool
from applyWeightsAndScore import applyWeightsAndScore
from filterBooksPool import filterBooksPool


def recommendBooks(account: dict) -> list:
    parameters = getParameters(account)
    booksPool = getBooksPool(parameters)
    booksPool = filterBooksPool(parameters, booksPool)
    recommendations = applyWeightsAndScore(parameters, booksPool)
    return recommendations


def main():
    try:
        # Ensure the JSON string is properly formatted with double quotes
        if len(sys.argv) > 1:
            externalSessionAccount = json.loads(sys.argv[1])
            result = recommendBooks(externalSessionAccount)
            print(json.dumps(result[0:5]))
        else:
            print("No input provided. Please pass a JSON string as the first argument.")
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON from input: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")


if __name__ == "__main__":
    main()
