## BOOKS
GOOGLE_BOOKS_API_KEY=AIzaSyDDxf1nRkG6eMcufxYp2LHIWgA-2MEMlK8 python3 books.py '{"isVerified":false,"emailVerificationCode":null,"emailVerificationExpiration":null,"readBooks":[],"watchlist":[],"readingList":[],"likedMovies":[],"likedBooks":[],"dislikedMovies":[],"dislikedBooks":[],"seenMovies":[],"lastMovieRecommandation":null,"lastBookRecommandation":null,"recommendedBooksHistory":[],"recommendedMoviesHistory":[],"id":"1f6e4a8e-a336-4505-8534-702daae96751","email":"user882839@example.com","firstName":"Frank","lastName":"Parker","bornDate":"2001-06-07","preferences":{"platforms":["netflix","disney"],"booksGenres":["science"],"moviesGenres":[70,60,50]},"createdDate":"2024-05-26T14:20:38.497Z","modifiedDate":"2024-05-26T14:23:24.752Z","spentMinutesReadingAndWatching":null}' | python -m json.tool

GOOGLE_BOOKS_API_KEY=AIzaSyDDxf1nRkG6eMcufxYp2LHIWgA-2MEMlK8 python3 books.py '{"isVerified":false,"readBooks":[],"watchlist":[],"readingList":[],"likedMovies":[],"likedBooks":[],"dislikedMovies":[],"dislikedBooks":[],"seenMovies":[],"lastMovieRecommandation":"2024-06-25T16:36:32.288Z","lastBookRecommandation":null,"recommendedBooksHistory":[],"recommendedMoviesHistory":[],"id":"c45eae19-126f-44e5-a12e-d9a017f12d6b","email":"user790495@example.com","firstName":"Rossie","lastName":"Stoltenberg","bornDate":"2001-06-07","preferences":{"platforms":["PrimeVideo"],"booksGenres":["philosophy","romance"],"moviesGenres":[28,12,16]},"createdDate":"2024-06-25T16:31:31.011Z","modifiedDate":"2024-06-25T16:36:32.294Z","spentMinutesReadingAndWatching":null}'

# MOVIES
MOVIE_DB_KEY=1eec31e851e9ad1b8f3de3ccf39953b7 python3 movies.py '{"isVerified":false,"emailVerificationCode":null,"emailVerificationExpiration":null,"readBooks":[],"watchlist":[],"readingList":[],"likedMovies":[],"likedBooks":[],"dislikedMovies":[],"dislikedBooks":[],"seenMovies":[],"lastMovieRecommandation":"2024-05-26T17:11:35.850Z","lastBookRecommandation":"2024-05-26T17:11:36.403Z","recommendedBooksHistory":["vlWwEAAAQBAJ","yITdywEACAAJ","KNiwEAAAQBAJ","XsoMCwAAQBAJ","0ui1kEiqAswC","KQqVEAAAQBAJ","tR0LAwAAQBAJ","WLDkzygwH50C","Raw-AAAAcAAJ","dolWAQAAQBAJ"],"recommendedMoviesHistory":[],"id":"c57f3894-a31e-4933-abbe-3b851b163c41","email":"jacques.roux@gmail.com","firstName":"Jacques","lastName":"Roux","bornDate":"1989-05-10","preferences":{"platforms":["Cinéma","DVD","VOD","Netflix","Prime Video"],"booksGenres":["history","biography"],"moviesGenres":[12]},"createdDate":"2024-05-26T17:08:55.619Z","modifiedDate":"2024-05-26T17:11:36.407Z","spentMinutesReadingAndWatching":null}' | python -m json.tool

# MOVIES BASIC
MOVIE_DB_KEY=1eec31e851e9ad1b8f3de3ccf39953b7 python3 movies.py '{"isVerified":false,"readBooks":[],"watchlist":[],"readingList":[],"likedMovies":[],"likedBooks":[],"dislikedMovies":[],"dislikedBooks":[],"seenMovies":[],"lastMovieRecommandation":null,"lastBookRecommandation":null,"recommendedBooksHistory":[],"recommendedMoviesHistory":[],"id":"c45eae19-126f-44e5-a12e-d9a017f12d6b","email":"user790495@example.com","firstName":"Rossie","lastName":"Stoltenberg","bornDate":"2001-06-07","preferences":{"platforms":["PrimeVideo"],"booksGenres":["philosophy","romance"],"moviesGenres":[28,12,16]},"createdDate":"2024-06-25T16:31:31.011Z","modifiedDate":"2024-06-25T16:33:15.339Z","spentMinutesReadingAndWatching":null}'

# MOVIES WITH LIKED
MOVIE_DB_KEY=1eec31e851e9ad1b8f3de3ccf39953b7 python3 movies.py '{"isVerified":false,"emailVerificationCode":null,"emailVerificationExpiration":null,"readBooks":[],"watchlist":[],"readingList":[],"likedMovies":[601796,284053,1022789,693134,1022789],"likedBooks":[],"dislikedMovies":[],"dislikedBooks":[],"seenMovies":[],"lastMovieRecommandation":"2024-05-26T17:11:35.850Z","lastBookRecommandation":"2024-05-26T17:11:36.403Z","recommendedBooksHistory":["vlWwEAAAQBAJ","yITdywEACAAJ","KNiwEAAAQBAJ","XsoMCwAAQBAJ","0ui1kEiqAswC","KQqVEAAAQBAJ","tR0LAwAAQBAJ","WLDkzygwH50C","Raw-AAAAcAAJ","dolWAQAAQBAJ"],"recommendedMoviesHistory":[],"id":"c57f3894-a31e-4933-abbe-3b851b163c41","email":"jacques.roux@gmail.com","firstName":"Jacques","lastName":"Roux","bornDate":"1989-05-10","preferences":{"platforms":["Cinéma","DVD","VOD","Netflix","Prime Video"],"booksGenres":["history","biography"],"moviesGenres":[12]},"createdDate":"2024-05-26T17:08:55.619Z","modifiedDate":"2024-05-26T17:11:36.407Z","spentMinutesReadingAndWatching":null}'