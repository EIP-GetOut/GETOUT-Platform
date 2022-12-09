/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { Application } from 'express'

import basicEndpoints from '@routes/basicEndpoints'

const useRoutes = (app: Application) => (
  app
    .use(basicEndpoints)
)

export default useRoutes
