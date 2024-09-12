#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json
import requests
import urllib.parse

NB_BOOKS=200
BOOKS_BY_GENRES_WEIGHT=0.45
BOOKS_BY_GENRES_LIKED_WEIGHT=0.45
BOOKS_BY_AUTHORS_WEIGHT=0.1

def getBooksByGenres(bookread: list, genres: list) -> list:
    api_url = "https://www.googleapis.com/books/v1/volumes"
    full_pool = []

    for genre in genres:
        params = {
            'q': f'subject:{genre}',
            'maxResults': 40
        }
        try:
            response = requests.get(api_url, params=params)
            response.raise_for_status()
            books = response.json().get('items', [])
            for book in books:
                book_info = book.get('volumeInfo', {})
                book_id = book.get('id', 'Unknown ID')
                book_title = book_info.get('title', 'Unknown Title')
                if book_title not in bookread:
                    book_authors = book_info.get('authors', ['Unknown Author'])
                    book_genres = book_info.get('categories', ['Unknown Genre'])
                    published_date = book_info.get('publishedDate', 'Unknown Date')
                    full_pool.append({
                        'id': book_id,
                        'title': book_title,
                        'genres': book_genres,
                        'author': book_authors,
                        'date': published_date
                    })
        except requests.exceptions.RequestException as e:
            print(f"Error fetching books for genre '{genre}': {e}")
    pretty_pool = json.dumps(full_pool, indent=2)
    # print("full_pool : ", pretty_pool)
    # print(len(full_pool))
    booksPoolByGenres = []
    return full_pool

def getBooksByGenresLiked() -> list:
    booksPoolByGenresLiked = []
    return booksPoolByGenresLiked

def getBooksByAuthors() -> list:
    booksPoolByAuthors = []
    return booksPoolByAuthors

def getBooksRandom() -> list:
    booksPoolRandom = []
    return booksPoolRandom

def getBooksPool(parameters: dict) -> list:
    # booksPool = []
    # for genre in parameters['genres']:
    #     for page in range(int(10 / len(parameters['genres']))):
    #         url = f'https://www.googleapis.com/books/v1/volumes?q=subject:{urllib.parse.quote_plus(genre)}&printType=books&maxResults=40&startIndex={page * 40}&orderBy=relevance&langRestrict=fr'
    #         try:
    #             response = requests.get(url)
    #             response.raise_for_status()
    #             data = response.json()
    #             items = data.get('items', [])
    #             for item in items:
    #                 volumeInfo = item.get('volumeInfo', {})
    #                 if 'imageLinks' not in volumeInfo or 'categories' not in volumeInfo:
    #                     continue
    #                 filteredItem = {
    #                     'id': item.get('id', None),
    #                     'title': volumeInfo.get('title', None),
    #                     'authors': volumeInfo.get('authors', None),
    #                     'publishedDate': volumeInfo.get('publishedDate', None),
    #                     'pageCount': volumeInfo.get('pageCount', None),
    #                     'categories': volumeInfo.get('categories', None),
    #                     'language': volumeInfo.get('language', None)
    #                 }
    #                 if not all(filteredItem.values()):
    #                     continue
    #                 booksPool.append(filteredItem)
    #         except requests.exceptions.RequestException as e:
    #             print(f'HTTP request error: {e}')
    #         except json.JSONDecodeError as e:
    #             print(f'Error decoding JSON from response: {e}')
    #             print(f'Response content: {response.content}')
    booksPool = []
    booksPool.extend(getBooksByGenres(parameters["readBooks"], parameters["genres"]))
    # booksPool.extend(getBooksByGenresLiked())
    # booksPool.extend(getBooksByAuthors())
    # if len(booksPool) < NB_BOOKS:
    #     booksPool.extend(getBooksRandom())
    return booksPool
