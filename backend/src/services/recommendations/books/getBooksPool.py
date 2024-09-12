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
API_URL = "https://www.googleapis.com/books/v1/volumes"

def getBooksByGenres(bookread: list, genres: list, booksPool: list, weight: int) -> list:
    booksPoolByGenres = []

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
                response = requests.get(API_URL, params=params)
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
                    if len(genre_books) >= NB_BOOKS:
                        break
                start_index += 40
            except requests.exceptions.RequestException as e:
                print(f"Error fetching books for genre '{genre}': {e}")
                break
        booksPoolByGenres.extend(genre_books)
        random.shuffle(booksPoolByGenres)
        if len(booksPoolByGenres) > int(NB_BOOKS * weight):
            booksPoolByGenres = booksPoolByGenres[:int(NB_BOOKS * weight)]
    return booksPoolByGenres

def getBooksByAuthors(bookread: list, authors: list, booksPool: list) -> list:
    booksPoolByAuthors = []
    existing_book_ids = {book['id'] for book in booksPool}

    for author in authors:
        author_books = []
        start_index = 0
        while len(author_books) < NB_BOOKS:
            params = {
                'q': f'inauthor:{author}',
                'maxResults': 40,
                'startIndex': start_index,
                'langRestrict': 'fr',
                'printType': 'books'
            }
            try:
                response = requests.get(API_URL, params=params)
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
                        author_books.append({
                            'id': book_id,
                            'title': book_title,
                            'genres': book_genres,
                            'author': book_authors,
                            'date': published_date
                        })
                        existing_book_ids.add(book_id)

                    if len(author_books) >= NB_BOOKS:
                        break
                start_index += 40
            except requests.exceptions.RequestException as e:
                print(f"Error fetching books for genre '{author}': {e}")
                break
        booksPoolByAuthors.extend(author_books)
        random.shuffle(booksPoolByAuthors)
        if len(booksPoolByAuthors) > int(NB_BOOKS * BOOKS_BY_AUTHORS_WEIGHT):
            booksPoolByAuthors = booksPoolByAuthors[:int(NB_BOOKS * BOOKS_BY_AUTHORS_WEIGHT)]
    return booksPoolByAuthors

def getBooksRandom(bookread: list, booksPool: list) -> list:
    booksPoolRandom = booksPool[:]
    existing_book_ids = {book['id'] for book in booksPool}
    books_needed = NB_BOOKS - len(booksPool)
    start_index = 0

    while len(booksPoolRandom) < NB_BOOKS:
        params = {
            'maxResults': 40,
            'startIndex': start_index,
            'langRestrict': 'fr',
            'printType': 'books'
        }
        try:
            response = requests.get(API_URL, params=params)
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
                    booksPoolRandom.append({
                        'id': book_id,
                        'title': book_title,
                        'genres': book_genres,
                        'author': book_authors,
                        'date': published_date
                    })
                    existing_book_ids.add(book_id)
                    if len(booksPoolRandom) >= NB_BOOKS:
                        break
            start_index += 40
        except requests.exceptions.RequestException as e:
            print(f"Error fetching books: {e}")
            break
    random.shuffle(booksPoolRandom)
    return booksPoolRandom[:books_needed]


def getBooksPool(parameters: dict) -> list:
    booksPool = []
    booksPool.extend(getBooksByGenres(parameters["readBooks"], parameters["genres"], booksPool, BOOKS_BY_GENRES_WEIGHT))
    booksPool.extend(getBooksByGenres(parameters["readBooks"], parameters["likedGenres"], booksPool, BOOKS_BY_GENRES_LIKED_WEIGHT))
    booksPool.extend(getBooksByAuthors(parameters["readBooks"], parameters["favouriteWriters"], booksPool))
    if len(booksPool) < NB_BOOKS:
        booksPool.extend(getBooksRandom(parameters["readBooks"], booksPool))
    print(len(booksPool))
    return booksPool
