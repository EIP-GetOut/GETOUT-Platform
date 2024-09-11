#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
#


global MOVIES_POOL_LENGTH
global MOVIES_POOL_BY_GENRES_LENGTH
global MOVIES_POOL_BY_LIKED_GENRES_LENGTH

MOVIES_POOL_LENGTH = 200
MOVIES_POOL_BY_GENRES_LENGTH = int(0.45 * MOVIES_POOL_LENGTH)
MOVIES_POOL_BY_LIKED_GENRES_LENGTH = int(0.45 * MOVIES_POOL_LENGTH)
