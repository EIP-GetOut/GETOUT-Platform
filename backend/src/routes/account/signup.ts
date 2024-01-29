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
router.post('/account/signup', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id != null) {
    handleErrorOnRoute(res)(new AlreadyLoggedInError())
    return
  }
  registerAccount(req.body).then((account: Account) => {
    return res.status(StatusCodes.CREATED).json(account)
  }).catch(handleErrorOnRoute(res))
})

export default router
