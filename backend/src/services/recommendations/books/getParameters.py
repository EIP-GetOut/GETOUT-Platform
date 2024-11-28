#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json
from collections import Counter
import asyncio
import requests
import re

API_URL = "https://www.googleapis.com/books/v1/volumes/"


def fetchBookDetails(bookId):
    try:
        response = requests.get(API_URL + bookId)
        response.raise_for_status()

        fullVolume = response.json()
        book = fullVolume.get('volumeInfo')

        if book.get('categories') is None:
            genre = []
        else:
            genre = [re.search(r'\b[a-zA-Z0-9]+\b', book.get('categories')[0]).group()]
        filteredBook = {
            "id": fullVolume.get("id"),
            "title": book.get("title"),
            "genres": genre,
            "releaseDate": book.get("publishedDate"),
            "writer": book.get('authors')[0]
        }
        return filteredBook
    except requests.exceptions.RequestException as e:
        print(f"Error fetching books: {e}")
        return None



async def getBooksDetailsConcurrently(booksIds):
    tasks = [asyncio.to_thread(fetchBookDetails, id) for id in booksIds]
    booksDetails = await asyncio.gather(*tasks)
    result = [x for x in booksDetails if x is not None]
    return result

def getLikedBooksParameters(parameters: dict) -> dict:
    if not isinstance(parameters.get("likedBooks"), list) and len(parameters.get("likedBooks")) > 5:
        raise ValueError("Expected 'likedBooks' to be a list")
    data = asyncio.run(getBooksDetailsConcurrently(parameters["likedBooks"]))
    genres = []
    if not isinstance(data, list):
        raise ValueError("Expected data to be a list of dictionaries")
    for item in data:
        if isinstance(item, dict):
            genre_ids = item.get('genres', [])
            if isinstance(genre_ids, list):
                genres.extend(genre_ids)
            else:
                raise ValueError("Expected 'genres' to be a list")
        else:
            raise ValueError("Expected each item in data to be a dictionary")
    genre_ids = [genre['id'] for genre in genres if isinstance(genre, dict)]
    genre_counts = Counter(genres)
    filtered_genre_counts = {
        genre: count for genre, count in genre_counts.items()
        if genre not in parameters.get("genres", []) and count >= 2
    }
    top_genres = sorted(filtered_genre_counts.items(), key=lambda x: x[1], reverse=True)[:3]
    liked_genres = [genre for genre, count in top_genres]
    parameters["likedGenres"] = liked_genres if liked_genres else None
    return parameters



def getDislikedBooksParameters(parameters: dict) -> dict:
    if not isinstance(parameters.get("dislikedBooks"), list) and len(parameters.get("dislikedBooks")) > 5:
        raise ValueError("Expected 'dislikedBooks' to be a list")
    data = asyncio.run(getBooksDetailsConcurrently(parameters["dislikedBooks"]))
    genres = []
    if not isinstance(data, list):
        raise ValueError("Expected data to be a list of dictionaries")
    for item in data:
        if isinstance(item, dict):
            genre_ids = item.get('genres', [])
            if isinstance(genre_ids, list):
                genres.extend(genre_ids)
            else:
                raise ValueError("Expected 'genres' to be a list")
        else:
            raise ValueError("Expected each item in data to be a dictionary")
    genre_ids = [genre['id'] for genre in genres if isinstance(genre, dict)]
    genre_counts = Counter(genre_ids)
    filtered_genre_counts = {
        genre: count for genre, count in genre_counts.items()
        if genre not in parameters.get("genres", []) and count >= 2
    }
    top_genres = sorted(filtered_genre_counts.items(), key=lambda x: x[1], reverse=True)[:3]
    disliked_genres = [genre for genre, count in top_genres]
    parameters["dislikedGenres"] = disliked_genres if disliked_genres else None
    return parameters



def getLikedAutorsParameters(parameters: dict) -> dict:
    if not isinstance(parameters.get("likedBooks"), list) and len(parameters.get("likedBooks")) > 5:
        raise ValueError("Expected 'likedBooks' to be a list")
    data = asyncio.run(getBooksDetailsConcurrently(parameters["likedBooks"]))
    directors = []
    if not isinstance(data, list):
        raise ValueError("Expected data to be a list of dictionaries")
    for item in data:
        if isinstance(item, dict):
            director = item.get('writer')
            if isinstance(director, str):
                directors.append(director)
            else:
                raise ValueError("Expected 'director' to be a string")
        else:
            raise ValueError("Expected each item in data to be a dictionary")
    director_counts = Counter(directors)
    filtered_director_counts = {
        director: count for director, count in director_counts.items()
        if director not in parameters.get("directors", []) and count >= 2
    }
    top_directors = sorted(filtered_director_counts.items(), key=lambda x: x[1], reverse=True)[:3]
    liked_directors = [director for director, count in top_directors]
    parameters["favouriteWriters"] = liked_directors if liked_directors else None
    return parameters

def getLikedDecadesParameters(parameters: dict) -> dict:
    if not isinstance(parameters.get("likedBooks"), list) and len(parameters.get("likedBooks")) > 5:
        raise ValueError("Expected 'likedBooks' to be a list")
    data = asyncio.run(getBooksDetailsConcurrently(parameters["likedBooks"]))
    decades = []
    if not isinstance(data, list):
        raise ValueError("Expected data to be a list of dictionaries")
    for item in data:
        if isinstance(item, dict):
            releaseDate = item.get("releaseDate")
            if isinstance(releaseDate, str) and len(releaseDate) >= 4:
                year = int(releaseDate[:4])
                decade = (year // 10) * 10
                decades.append(decade)
            else:
                raise ValueError("Expected 'release_date' to be a valid string with a year")
        else:
            raise ValueError("Expected each item in data to be a dictionary")
    decade_counts = Counter(decades)
    filtered_decade_counts = {
        decade: count for decade, count in decade_counts.items()
        if decade not in parameters.get("decades", []) and count >= 2
    }
    top_decades = sorted(filtered_decade_counts.items(), key=lambda x: x[1], reverse=True)[:3]
    liked_decades = [decade for decade, count in top_decades]
    parameters["favouriteEpoch"] = liked_decades if liked_decades else None
    return parameters


def getDislikedDecadesParameters(parameters: dict) -> dict:
    if not isinstance(parameters.get("dislikedBooks"), list) and len(parameters.get("dislikedBooks")) > 5:
        raise ValueError("Expected 'dislikedBooks' to be a list")
    data = asyncio.run(getBooksDetailsConcurrently(parameters["dislikedBooks"]))
    decades = []
    if not isinstance(data, list):
        raise ValueError("Expected data to be a list of dictionaries")
    for item in data:
        if isinstance(item, dict):
            releaseDate = item.get('releaseDate')
            if isinstance(releaseDate, str) and len(releaseDate) >= 4:
                year = int(releaseDate[:4])
                decade = (year // 10) * 10
                decades.append(decade)
            else:
                raise ValueError("Expected 'release_date' to be a valid string with a year")
        else:
            raise ValueError("Expected each item in data to be a dictionary")
    decade_counts = Counter(decades)
    filtered_decade_counts = {
        decade: count for decade, count in decade_counts.items()
        if decade not in parameters.get("dislikedDecades", []) and count >= 2
    }
    bottom_decades = sorted(filtered_decade_counts.items(), key=lambda x: x[1], reverse=False)[:3]
    disliked_decades = [decade for decade, count in bottom_decades]
    parameters["leastFavouriteEpoch"] = disliked_decades if disliked_decades else None
    return parameters

def getParameters(account: json) -> json:
    try:
        parameters = {
            "history": account["recommendedBooksHistory"],
            "readBooks": account["readBooks"],
            "likedBooks": account["likedBooks"],
            "dislikedBooks": account["likedBooks"],
            "genres": account["preferences"]["booksGenres"],
            "likedGenres": None,
            "favouriteEpoch": None,
            "favouriteWriters": None,
            "dislikedGenres": None,
            "leastFavouriteEpoch": None
        }
        if parameters["likedBooks"] is not None:
            parameters = getLikedBooksParameters(parameters)
        if parameters["dislikedBooks"] is not None:
            parameters = getDislikedBooksParameters(parameters)
        if parameters["likedBooks"] is not None:
            parameters = getLikedAutorsParameters(parameters)
        if parameters["likedBooks"] is not None:
            parameters = getLikedDecadesParameters(parameters)
        if parameters["dislikedBooks"] is not None:
            parameters = getDislikedDecadesParameters(parameters)
        liked_epochs = parameters.get("favouriteEpoch", [])
        disliked_epochs = parameters.get("leastFavouriteEpoch", [])
        if liked_epochs and disliked_epochs:
            liked_epoch_counts = Counter(liked_epochs)
            disliked_epoch_counts = Counter(disliked_epochs)
            common_epochs = set(liked_epochs) & set(disliked_epochs)
            for epoch in common_epochs:
                liked_count = liked_epoch_counts.get(epoch, 0)
                disliked_count = disliked_epoch_counts.get(epoch, 0)
                if liked_count >= disliked_count:
                    disliked_epochs.remove(epoch)
                else:
                    liked_epochs.remove(epoch)
            parameters["favouriteEpoch"] = liked_epochs if liked_epochs else None
            parameters["leastFavouriteEpoch"] = disliked_epochs if disliked_epochs else None
        return parameters
    except KeyError as e:
        print(f"Missing key in account data: {e}")
        return {}
    except TypeError as e:
        print(f"Type error: {e}")
        return {}
