#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json
import requests
import urllib.parse


def getBooksPool(parameters: dict) -> list:
    booksPool = []
    for genre in parameters['genres']:
        for page in range(int(10 / len(parameters['genres']))):
            url = f'https://www.googleapis.com/books/v1/volumes?q=subject:{urllib.parse.quote_plus(genre)}&printType=books&maxResults=40&startIndex={page * 40}&orderBy=relevance&langRestrict=fr'
            try:
                response = requests.get(url)
                response.raise_for_status()
                data = response.json()
                items = data.get('items', [])
                for item in items:
                    volumeInfo = item.get('volumeInfo', {})
                    if 'imageLinks' not in volumeInfo or 'categories' not in volumeInfo:
                        continue
                    filteredItem = {
                        'id': item.get('id', None),
                        'title': volumeInfo.get('title', None),
                        'authors': volumeInfo.get('authors', None),
                        'publishedDate': volumeInfo.get('publishedDate', None),
                        'pageCount': volumeInfo.get('pageCount', None),
                        'categories': volumeInfo.get('categories', None),
                        'language': volumeInfo.get('language', None)
                    }
                    if not all(filteredItem.values()):
                        continue
                    booksPool.append(filteredItem)
            except requests.exceptions.RequestException as e:
                print(f'HTTP request error: {e}')
            except json.JSONDecodeError as e:
                print(f'Error decoding JSON from response: {e}')
                print(f'Response content: {response.content}')
    return booksPool
