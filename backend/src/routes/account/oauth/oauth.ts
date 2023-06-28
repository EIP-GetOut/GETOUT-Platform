/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { Request, Response, Router } from "express";
import { body } from "express-validator";
import { StatusCodes, getReasonPhrase } from "http-status-codes";

import logger, { logApiRequest } from "@services/middlewares/logging";
import validate from "@services/middlewares/validator";

import { loginWithGoogle } from "@models/account/loginAccount"


const router = Router()

const rulesPost = [
    body('email').isEmail(),
    body('idToken').isString()
]

router.post('/account/oauth', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  return loginWithGoogle(req.body, req.session).then((code: StatusCodes) => {
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