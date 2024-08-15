/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { param } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import validate from '@middlewares/validator'

import { logApiRequest } from '@services/middlewares/logging'
import { AuthenticationError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

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
 *         type: string
 *     responses:
 *       200:
 *         description: Success. Returns true if the user has the permission, false otherwise.
 *         schema:
 *           type: boolean
 *       400:
 *         description: Bad request. Invalid input data.
 *       401:
 *         description: Unauthorized. User not authenticated.
 *       500:
 *         description: Internal server error.
 */
router.get('/permission/:permissionName', rules, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  accoutHasPermission(req.session.account.role.permissions, req.params.permissionName).then((hasPermission) => {
    return res.status(StatusCodes.OK).send(hasPermission)
  }).catch(handleErrorOnRoute(res))
})

export default router
