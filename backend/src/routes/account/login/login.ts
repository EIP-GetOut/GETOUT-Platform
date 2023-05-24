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

import loginAccount from "@models/account/loginAccount";

const router = Router()

const rulesPost = [
    body('email').isEmail(),
    body('password').isString()
]

router.post('/account/login', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  return loginAccount(req.body, req.session).then((code: StatusCodes) => {
    if (code === StatusCodes.OK) {
      logger.info(`Account successfully logged in${req.body.email ? `: ${req.body.email}` : ' !'}`)
    } else {
      logger.info(`Account's email or password is incorrect: ${req.body.email || req.body.githubCode}`)
    }
    return res.status(code).send(getReasonPhrase(code))
  }).catch((err: any) => {
    logger.error(err)
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR)
      .send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
  })
})

export default router