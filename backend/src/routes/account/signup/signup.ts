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

router.post('/account/signup', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
    return registerAccount(req.body).then((result: any) => {
        if (typeof result === 'object') {
            return res.status(StatusCodes.CREATED).json(result)
        }
        return res.status(result).send(getReasonPhrase(result))
    }).catch((err) => {
        console.log(err)
        logger.error(err)
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
    })
})

export default router