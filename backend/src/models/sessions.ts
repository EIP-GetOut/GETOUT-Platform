/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { ApiError } from '@services/utils/customErrors'

async function getSessions (sessionStore: Express.SessionStore): Promise<number> {
  return await new Promise<number>((resolve, reject) => {
    sessionStore.all?.((err: any, sessions?: any) => {
      if (err != null || sessions == null) {
        reject(new ApiError('Error while getting the sessions.'))
      }
      const differentSessions: string[] = []
      sessions.forEach((session: any) => {
        if (!differentSessions.includes(session.account?.id)) {
          differentSessions.push(session.account?.id)
        }
      })
      resolve(differentSessions.length)
    })
  })
}

export { getSessions }
