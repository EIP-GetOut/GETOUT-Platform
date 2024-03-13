/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { AlreadyLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import registerAccount from '@models/account/registerAccount'

import { type Account } from '@entities/Account'

const router = Router()

const rulesPost = [
  body('email').isEmail(),
  body('firstName').isString(),
  body('lastName').isString(),
  body('bornDate').isDate({ format: 'DD/MM/YYYY' }),
  body('password').isString()
]

/**
 * @swagger
 * /account/signup:
 *   post:
 *     summary: Create an account
 *     description: Create a new user account and store the provided information in the database.
 *     parameters:
 *       - in: body
 *         name: requestBody
 *         description: Account details
 *         required: true
 *         schema:
 *           type: object
 *           properties:
 *             email:
 *               type: string
 *               format: email
 *             firstName:
 *               type: string
 *             lastName:
 *               type: string
 *             bornDate:
 *               type: string
 *               format: date
 *             password:
 *               type: string
 *     responses:
 *       '201':
 *         description: Account created successfully.
 *       '400':
 *         description: Bad request. Invalid input data.
 *       '500':
 *         description: Internal server error.
 */

// {
//   "salt": "$2b$10$zqLRykXBQ7/mUgQKb0wYY.",
//   "email": "user162928@example.com",
//   "password": "$2b$10$WyrObiyVJ5cy/7EPScYBg.2dTM78dYkz.Yr7YE0bZ5A3XaCoPCjeK",
//   "firstName": "Ozella",
//   "lastName": "Kulas",
//   "bornDate": "2001-06-07T00:00:00.000Z",
//   "passwordResetToken": null,
//   "passwordResetExpiration": null,
//   "passwordResetPassword": null,
//   "preferences": null,
//   "id": "c90adeff-53f5-46a2-afcb-6cdb82373f36",
//   "watchlist": [],
//   "readingList": [],
//   "likedMovies": [],
//   "likedBooks": [],
//   "dislikedMovies": [],
//   "dislikedBooks": [],
//   "seenMovies": [],
//   "readBooks": [],
//   "createdDate": "2024-03-13T04:00:47.606Z",
//   "modifiedDate": "2024-03-13T04:00:47.606Z"
// }

router.post('/account/signup', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id != null) {
    handleErrorOnRoute(res)(new AlreadyLoggedInError())
    return
  }
  registerAccount(req.body).then((account: Account) => {
    return res.status(StatusCodes.CREATED).json({
      id: account.id,
      email: account.email,
      firstName: account.firstName,
      lastName: account.lastName,
      bornDate: account.bornDate,
      preferences: account.preferences,
      createdDate: account.createdDate
    })
  }).catch(handleErrorOnRoute(res))
})

export default router
