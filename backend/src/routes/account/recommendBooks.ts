/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'
import { type Options, PythonShell } from 'python-shell'

import logger from '@middlewares/logging'

import { logApiRequest } from '@services/middlewares/logging'
import { NotLoggedInError, PreferencesDoesNotExistError, RecommandationsDetailsError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { getBook } from '@models/book'

const router = Router()

router.get('/account/:accountId/recommend-books', logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
  }
  if (req.session.account?.preferences == null) {
    handleErrorOnRoute(res)(new PreferencesDoesNotExistError())
  }

  const options: Options = {
    mode: 'json',
    pythonPath: '/usr/bin/python3',
    pythonOptions: [],
    scriptPath: 'src/services/recommandations/',
    args: [JSON.stringify(req.session.account)]
  }

  PythonShell.run('books.py', options).then(async ([output]: any) => {
    const recommandations = output.recommandations
    const promisesArray: Array<Promise<any>> = []

    recommandations.forEach((recommandation: any) => {
      promisesArray.push(getBook(recommandation.id))
    })

    await Promise.all(promisesArray).then((resolvedPromises) => {
      resolvedPromises.forEach((resolvedPromise: any, index) => {
        resolvedPromise.score = recommandations[index].score
      })
      logger.info(`Successfully retreived movie recommandations: ${JSON.stringify(recommandations, null, 2)}`)
      return res.status(StatusCodes.OK).json(resolvedPromises)
    }).catch(() => {
      throw new RecommandationsDetailsError()
    })
  }).catch(handleErrorOnRoute(res))
})

export default router
