#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json
import random

WEIGHTS = {
    "genres": 0.3,
    "critics": 0.35,
    "popularity": 0.35
}

# def calculate_genre_score(book, user):
#     score = 0
#     google_books_api = build("books", "v1", developerKey=os.getenv("GOOGLE_BOOKS_API_KEY"))
#     response = google_books_api.volumes().list(q="isbn:" + book["primary_isbn13"]).execute()
#     if "items" in response:
#         for g in response["items"][0]["volumeInfo"]["categories"]:
#             if g in user["preferences"]["booksGenres"]:
#                 score += (WEIGHTS["genres"] * 100) / len(response["items"][0]["volumeInfo"]["categories"])
#     print("genre score: " + str(score))
#     return score

# def calculate_critics_score(book, user):
#     score = 0
#     google_books_api = build("books", "v1", developerKey=os.getenv("GOOGLE_BOOKS_API_KEY"))
#     response = google_books_api.volumes().list(q="isbn:" + book["primary_isbn13"]).execute()
#     if "items" in response:
#         try:
#             score = (response["items"][0]["volumeInfo"]["averageRating"] * 20) * WEIGHTS["critics"]
#         except:
#             print("no rating")
#     print("critics score: " + str(score))
#     return score

# def calculate_popularity_score(book, user):
#     score = 0
#     google_books_api = build("books", "v1", developerKey=os.getenv("GOOGLE_BOOKS_API_KEY"))
#     response = google_books_api.volumes().list(q="isbn:" + book["primary_isbn13"]).execute()
#     if "items" in response:
#         try:
#             score = (response["items"][0]["volumeInfo"]["ratingsCount"] / 100000) * WEIGHTS["popularity"]
#         except:
#             print("no rating")
#     print("popularity score: " + str(score))
#     return score


def applyWeightsAndScore(parameters: json, booksPool: list) -> json:
    recommendations = []
    for i in range(len(booksPool)):
        recommendations.append({
            "title": booksPool[i]["title"],
            "score": random.randint(1, 100),
            "id": booksPool[i]["id"]
        })

    recommendations = sorted(recommendations, key=lambda k: k["score"], reverse=True)
    return recommendations
