/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Request, Response, Router } from "express";
import { body } from "express-validator";
import { StatusCodes, getReasonPhrase } from "http-status-codes";

import logger, { logApiRequest } from "@services/middlewares/logging";
import validate from "@services/middlewares/validator";

import registerAccount from "@models/account/registerAccount";

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
    return registerAccount(req.body).then((result: any) => {
        if (typeof result === 'object') {
            return res.status(StatusCodes.CREATED).json(result)
        }
        return res.status(result).send(getReasonPhrase(result))
    }).catch((err) => {
        logger.error(err)
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
    })
})

export default router