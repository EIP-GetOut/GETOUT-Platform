import requests
import random
from utils import formated_print
from langdetect import detect
import asyncio

NB_BOOKS = 100
BOOKS_BY_GENRES_WEIGHT = 0.45
BOOKS_BY_GENRES_LIKED_WEIGHT = 0.45
BOOKS_BY_AUTHORS_WEIGHT = 0.1
API_URL = "https://www.googleapis.com/books/v1/volumes"


def fetchBook(params: dict) -> list:
    try:
        response = requests.get(API_URL, params=params)
        response.raise_for_status()
        return response.json().get('items', [])
    except requests.exceptions.RequestException as e:
        print(f"Error fetching books: {e}")
        return []


def extractBookInfo(book: dict, existing_book_ids: set, bookread: list) -> dict:
    book_info = book.get('volumeInfo', {})
    book_id = book.get('id', 'Unknown ID')
    book_title = book_info.get('title', 'Unknown Title')
    imageLinks = book_info.get('imageLinks', None)
    book_poster_path = None
    if imageLinks is not None:
        book_poster_path = imageLinks.get('thumbnail', None)

    if detect(book_title) == 'fr' and book_title not in bookread and book_id not in existing_book_ids and book_poster_path is not None:
        book_authors = book_info.get('authors', ['Unknown Author'])
        book_genres = book_info.get('categories', ['Unknown Genre'])
        published_date = book_info.get('publishedDate', 'Unknown Date')

        return {
            'id': book_id,
            'title': book_title,
            'genres': book_genres,
            'author': book_authors,
            'date': published_date
        }
    return None


async def fetchBooksConcurrently(paramsArray):
    tasks = [asyncio.to_thread(fetchBook, params) for params in paramsArray]
    resultsArray = await asyncio.gather(*tasks)
    return resultsArray

def getBooksByCriteria(bookread: list, search_key: str, genres: list, booksPool: list, weight: float) -> list:
    existing_book_ids = {book['id'] for book in booksPool}
    paramsArray = []
    booksPoolByCriteria = []
    booksPoolFiltered = []

    for genre in genres:
        start_index = 0

        for _ in range(3):
            params = {
                'q': f'{search_key}:{genre}',
                'maxResults': 40,
                'startIndex': start_index,
                'langRestrict': 'fr',
                'printType': 'books'
            }
            paramsArray.append(params)
            start_index += 40


    resultsArray = asyncio.run(fetchBooksConcurrently(paramsArray))
    for bookList in resultsArray:
        for book in bookList:
            book_data = extractBookInfo(book, existing_book_ids, bookread)
            if book_data:
                booksPoolFiltered.append(book_data)
                existing_book_ids.add(book_data['id'])
        booksPoolByCriteria.extend(booksPoolFiltered)

    random.shuffle(booksPoolByCriteria)
    if len(booksPoolByCriteria) > int(NB_BOOKS * weight):
        booksPoolByCriteria = booksPoolByCriteria[:int(NB_BOOKS * weight)]

    return booksPoolByCriteria


def getBooksByGenres(bookread: list, genres: list, booksPool: list, weight: float) -> list:
    return getBooksByCriteria(bookread, 'subject', genres, booksPool, weight)


def getBooksByAuthors(bookread: list, authors: list, booksPool: list) -> list:
    return getBooksByCriteria(bookread, 'inauthor', authors, booksPool, BOOKS_BY_AUTHORS_WEIGHT)


def getRandomBooks(bookread: list, booksPool: list) -> list:
    booksPoolRandom = booksPool[:]
    existing_book_ids = {book['id'] for book in booksPool}
    books_needed = NB_BOOKS - len(booksPool)
    start_index = 0

    while len(booksPoolRandom) < NB_BOOKS:
        params = {
            'q': '=',
            'maxResults': 40,
            'startIndex': start_index,
            'langRestrict': 'fr',
            'printType': 'books'
        }
        books = fetchBook(params)
        if not books:
            break

        for book in books:
            book_data = extractBookInfo(book, existing_book_ids, bookread)
            if book_data:
                booksPoolRandom.append(book_data)
                existing_book_ids.add(book_data['id'])

                if len(booksPoolRandom) >= NB_BOOKS:
                    break

        start_index += 40

    random.shuffle(booksPoolRandom)
    return booksPoolRandom[:books_needed]


def getBooksPool(parameters: dict) -> list:
    booksPool = []
    booksPool.extend(getBooksByGenres(parameters["readBooks"], parameters["genres"], booksPool, BOOKS_BY_GENRES_WEIGHT))
    if parameters["likedGenres"] is not None and len(parameters["likedGenres"]) > 5:
        booksPool.extend(getBooksByGenres(parameters["readBooks"], parameters["likedGenres"], booksPool, BOOKS_BY_GENRES_LIKED_WEIGHT))
    if parameters["favouriteWriters"] is not None:
        booksPool.extend(getBooksByAuthors(parameters["readBooks"], parameters["favouriteWriters"], booksPool))
    if len(booksPool) < NB_BOOKS:
        booksPool.extend(getRandomBooks(parameters["readBooks"], booksPool))
    return booksPool
