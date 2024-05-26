/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { param } from 'express-validator'
import { getReasonPhrase, StatusCodes } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { accoutHasPermission } from '@models/permissions'

const router = Router()

const rules = [
  param('permissionName').isString()
]

/**
 * @swagger
 * /permission/{permissionName}:
 *   get:
 *     summary: Check permission
 *     description: Check if the logged-in user has a specific permission.
 *     parameters:
 *       - name: permissionName
 *         in: path
 *         description: Name of the permission to check
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       '200':
 *         description: Success. Returns true if the user has the permission, false otherwise.
 *         content:
 *           application/json:
 *             schema:
 *               type: boolean
 *       '400':
 *         description: Bad request. Invalid input data.
 *       '401':
 *         description: Unauthorized. User not authenticated.
 *       '500':
 *         description: Internal server error.
 */

router.get('/permission/:permissionName', rules, validate, logApiRequest, (req: Request, res: Response) => {
  console.log('PARAMS:', req.params)
  if (req.session.account != null) {
    accoutHasPermission(req.session.account.role.permissions, req.params.permissionName).then((hasPermission) => {
      return res.status(StatusCodes.OK).send(hasPermission)
    }).catch((err) => {
      logger.error(err.toString())
      return res.status(StatusCodes.BAD_REQUEST)
        .send(getReasonPhrase(StatusCodes.BAD_REQUEST))
    })
  }
  return res.status(StatusCodes.OK).send(false)
})

export default router
