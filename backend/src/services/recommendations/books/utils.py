#
# Copyright GETOUT SAS - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Wrote by Julien Letoux <julien.letoux@epitech.eu>
#

import json

def formated_print(list: list):
    pretty_pool = json.dumps(list, indent=2)
    print(pretty_pool)
