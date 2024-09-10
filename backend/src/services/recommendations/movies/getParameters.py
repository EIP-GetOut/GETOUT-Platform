#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json
from collections import Counter
import asyncio

import os
from tmdbv3api import TMDb, Movie


def fetchMovieDetails(movie_id):
    tmdb = TMDb()
    tmdb.api_key = os.getenv("MOVIE_DB_KEY")
    tmdb.language = 'fr'
    movieApi = Movie()
    movieApi.language = 'fr'

    movie = movieApi.details(movie_id)
    director = next((member for member in movie['casts'].get('crew', []) if member.get('job') == 'Director'), None)

    filteredMovie = {
        "id": movie.get("id"),
        "title": movie.get("title"),
        "genres": [genre['name'] for genre in movie.get("genres", [])],
        "releaseDate": movie.get("release_date"),
        "director": director['name']
    }

    return filteredMovie


async def getMoviesDetailsConcurrently(movies: list[int]):
    tasks = [asyncio.to_thread(fetchMovieDetails, id) for id in movies]
    movieDetails = await asyncio.gather(*tasks)
    return movieDetails


def getLikedMoviesParameters(parameters: dict) -> dict:
    data = asyncio.run(getMoviesDetailsConcurrently(parameters["likedMovies"]))
    genres = []
    if not isinstance(data, list):
        raise ValueError("Expected data to be a list containing another list")
    if len(data) > 0 and isinstance(data[0], list):
        nested_list = data[0]
        for item in nested_list:
            print(f"Type of item: {type(item)}")
            print(f"Item content: {item}")
            if isinstance(item, dict):
                genre_ids = item.get('genres', [])
                if isinstance(genre_ids, dict):
                    genre_ids = list(genre_ids.keys())
                genres.extend(genre_ids)
            else:
                raise ValueError("Expected each item in nested list to be a dictionary")
    else:
        raise ValueError("Expected data to contain a nested list")
    genre_counts = Counter(genres)
    filtered_genre_counts = {
        genre: count for genre, count in genre_counts.items()
        if genre not in parameters["genres"] and count >= 2
    }
    top_genres = sorted(filtered_genre_counts.items(), key=lambda x: x[1], reverse=True)[:3]
    liked_genres = [genre for genre, count in top_genres]
    parameters["likedGenres"] = liked_genres if liked_genres else None
    print(parameters)
    return parameters


def getDislikedMoviesParameters(parameters: json) -> json:
    data = asyncio.run(getMoviesDetailsConcurrently(parameters["dislikedMovies"]))
    genres = []
    if not isinstance(data, list):
        raise ValueError("Expected data to be a list containing another list")
    if len(data) > 0 and isinstance(data[0], list):
        nested_list = data[0]
        for item in nested_list:
            if isinstance(item, dict):
                genre_ids = item.get('genre_ids', [])
                if isinstance(genre_ids, dict):
                    genre_ids = list(genre_ids.keys())
                genres.extend(genre_ids)
            else:
                raise ValueError("Expected each item in nested list to be a dictionary")
    else:
        raise ValueError("Expected data to contain a nested list")

    genre_counts = Counter(genres)
    filtered_genre_counts = {
        genre: count for genre, count in genre_counts.items() if count >= 2
    }
    top_genres = sorted(filtered_genre_counts.items(), key=lambda x: x[1], reverse=True)[:3]
    liked_genres = [genre for genre, count in top_genres]
    parameters["dislikedGenres"] = liked_genres if liked_genres else None
    # print(parameters)
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
        # if parameters["likedMovies"] is not None:
        #     parameters = getLikedMoviesParameters(parameters)
        # if parameters["dislikedMovies"] is not None:
            # parameters = getDislikedMoviesParameters(parameters)
        return parameters
    except KeyError as e:
        print(f"Missing key in account data: {e}")
        return {}
    except TypeError as e:
        print(f"Type error: {e}")
        return {}
