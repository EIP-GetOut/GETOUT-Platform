#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json

def recommend_books_with_parameters(parameters, books):
    history = parameters["history"]
    read_books = parameters["readBooks"]
    excluded_books = set(history + read_books)
    liked_genres = parameters.get("likedGenres", [])
    disliked_genres = parameters.get("dislikedGenres", [])
    favourite_epoch = parameters.get("favouriteEpoch")
    least_favourite_epoch = parameters.get("leastFavouriteEpoch")
    favourite_author = parameters.get("favouriteWriters", [])
    if not isinstance(favourite_author, list):
           favourite_author = [favourite_author]
    if not isinstance(liked_genres, list):
           liked_genres = [liked_genres]
    if not isinstance(disliked_genres, list):
            disliked_genres = [disliked_genres]

    def is_in_decade(year, decade_str):
        try:
            decade_start = int(decade_str[:4])
            return decade_start <= year < decade_start + 10
        except (ValueError, TypeError):
            return False

    def extract_year_from_date(date_str):
        try:
            return int(date_str[:4])
        except (ValueError, TypeError):
            return None

    def normalize_score(x, min_val=-0.8, max_val=2.2):
        return ((x - min_val) / (max_val - min_val)) * 100

    def calculate_book_score(book):
        score = 0
        for i in range(len(book["genres"])):
            if book["genres"][i] in parameters["genres"]:
                score += 1.0
        for i in range(len(book["genres"])):
            if liked_genres[0] and book["genres"][i] in parameters["likedGenres"]:
                score += 0.5
        for i in range(len(book["genres"])):
            if disliked_genres[0] and book["genres"][i] in parameters["dislikedGenres"]:
                score -= 0.5
        book_year = extract_year_from_date(book["date"])
        if book_year is not None:
            if favourite_epoch and is_in_decade(book_year, favourite_epoch):
                score += 0.3
            elif least_favourite_epoch and is_in_decade(book_year, least_favourite_epoch):
                score -= 0.3
        if favourite_author[0] and book["author"] in parameters["favouriteWriters"]:
            score += 0.4
        return score



    scored_books = []
    for book in books:
        if book["title"] not in excluded_books:
            score = calculate_book_score(book)
            scored_books.append({
                "id": book["id"],
                "title": book["title"],
                "score": int(normalize_score(score))
            })

    scored_books.sort(key=lambda x: x["score"], reverse=True)
    return scored_books[:5]


def applyWeightsAndScore(parameters: json, booksPool: list) -> json:
    recommendations = recommend_books_with_parameters(parameters, booksPool)
    recommendations = sorted(recommendations, key=lambda k: k["score"], reverse=True)
    return recommendations
