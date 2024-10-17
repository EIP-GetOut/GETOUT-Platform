#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

def formatMovieList(movieList: list[dict]) -> list[dict]:
    formatedMovieList = []

    for movie in movieList:
        # TODO : include director
        # director = next((crew for crew in movie.get("credits", {}).get("crew", []) if crew['job'] == 'Director'), None)

        if movie.get("backdrop_path") is None:
            continue
        filteredMovie = {
            "id": movie.get("id"),
            "title": movie.get("title"),
            "genres": movie.get("genre_ids", []),
            "releaseDate": movie.get("release_date"),
            "director": movie.get("director", None)
        }

        formatedMovieList.append(filteredMovie)

    return formatedMovieList