#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json
import requests


def getBooksPool(parameters: dict) -> list:
    booksPool = []
    for genre in parameters["genres"]:
        for page in range(int(10 / len(parameters["genres"]))):
            url = f"https://www.googleapis.com/books/v1/volumes?q=subject:{genre}&printType=books&maxResults=40&startIndex={page * 40}&orderBy=relevance&langRestrict=fr"
            try:
                response = requests.get(url)
                response.raise_for_status()
                data = response.json()
                items = data.get("items", [])
                for item in items:
                    volumeInfo = item.get("volumeInfo", {})
                    filteredItem = {
                        "id": item.get("id", ""),
                        "title": volumeInfo.get("title", ""),
                        "authors": volumeInfo.get("authors", []),
                        "publishedDate": volumeInfo.get("publishedDate", ""),
                        "pageCount": volumeInfo.get("pageCount", 0),
                        "categories": volumeInfo.get("categories", []),
                        "language": volumeInfo.get("language", "")
                    }
                    booksPool.append(filteredItem)
            except requests.exceptions.RequestException as e:
                print(f"HTTP request error: {e}")
            except json.JSONDecodeError as e:
                print(f"Error decoding JSON from response: {e}")
                print(f"Response content: {response.content}")
    return booksPool
