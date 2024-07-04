import sys
import json

from getParameters import getParameters
from getMoviesPool import getMoviesPool
from applyWeightsAndScore import applyWeightsAndScore
from filterMoviesPool import filterMoviesPool


def recommendMovies(account: dict) -> list:
    try:
        parameters = getParameters(account)
        moviesPool = getMoviesPool(parameters)
        moviesPool = filterMoviesPool(parameters, moviesPool)
        recommendations = applyWeightsAndScore(parameters, moviesPool)
        return recommendations
    except Exception as e:
        print(f"An error occurred in recommendMovies: {e}")
        raise


def main():
    try:
        if len(sys.argv) > 1:
            externalSessionAccount = json.loads(sys.argv[1])
            result = recommendMovies(externalSessionAccount)
            print(json.dumps(result[0:5]))
        else:
            print("No input provided. Please pass a JSON string as the first argument.")
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON from input: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")


if __name__ == "__main__":
    main()
