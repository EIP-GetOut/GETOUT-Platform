#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import requests
import random
from utils import formated_print
from langdetect import detect

NB_BOOKS=200
BOOKS_BY_GENRES_WEIGHT=0.45
BOOKS_BY_GENRES_LIKED_WEIGHT=0.45
BOOKS_BY_AUTHORS_WEIGHT=0.1

def getBooksByGenres(bookread: list, genres: list, booksPool: list, weight: int) -> list:
    api_url = "https://www.googleapis.com/books/v1/volumes"
    booksPoolByGenres = []
    nb_books_by_genre = int(NB_BOOKS * weight)

    existing_book_ids = {book['id'] for book in booksPool}

    for genre in genres:
        genre_books = []
        start_index = 0
        while len(genre_books) < NB_BOOKS:
            params = {
                'q': f'subject:{genre}',
                'maxResults': 40,
                'startIndex': start_index,
                'langRestrict': 'fr',
                'printType': 'books'
            }
            try:
                response = requests.get(api_url, params=params)
                response.raise_for_status()
                books = response.json().get('items', [])
                if not books:
                    break
                for book in books:
                    book_info = book.get('volumeInfo', {})
                    book_id = book.get('id', 'Unknown ID')
                    book_title = book_info.get('title', 'Unknown Title')
                    if detect(book_title) == 'fr' and book_title not in bookread and book_id not in existing_book_ids:
                        book_authors = book_info.get('authors', ['Unknown Author'])
                        book_genres = book_info.get('categories', ['Unknown Genre'])
                        published_date = book_info.get('publishedDate', 'Unknown Date')
                        genre_books.append({
                            'id': book_id,
                            'title': book_title,
                            'genres': book_genres,
                            'author': book_authors,
                            'date': published_date
                        })
                        existing_book_ids.add(book_id)

                    if len(genre_books) >= nb_books_by_genre:
                        break
                start_index += 40
            except requests.exceptions.RequestException as e:
                print(f"Error fetching books for genre '{genre}': {e}")
                break
        booksPoolByGenres.extend(genre_books)
        random.shuffle(booksPoolByGenres)
        if len(booksPoolByGenres) > nb_books_by_genre:
            booksPoolByGenres = booksPoolByGenres[:nb_books_by_genre]
    return booksPoolByGenres

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
    booksPool.extend(getBooksByGenres(parameters["readBooks"], parameters["genres"], booksPool, BOOKS_BY_GENRES_WEIGHT))
    booksPool.extend(getBooksByGenres(parameters["readBooks"], parameters["likedGenres"], booksPool, BOOKS_BY_GENRES_LIKED_WEIGHT))
    # booksPool.extend(getBooksByAuthors())
    # if len(booksPool) < NB_BOOKS:
    #     booksPool.extend(getBooksRandom())
    return booksPool
