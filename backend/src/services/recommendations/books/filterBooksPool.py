#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#

import json


def filterBooksPool(parameters: dict, booksPool: list) -> list:
    exploredBooksTitles = []
    for book in booksPool:
        id = book["id"]
        title = book["title"]
        if title in exploredBooksTitles:
            booksPool.remove(book)
        elif id in parameters["history"] or id in parameters["readBooks"]:
            booksPool.remove(book)
        exploredBooksTitles.append(title)
    return booksPool
