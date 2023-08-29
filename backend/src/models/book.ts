/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Response } from 'node-fetch'

import logger from '@middlewares/logging'

// eslint-disable-next-line @typescript-eslint/consistent-type-imports
const fetch = async (...args: Parameters<typeof import('node-fetch')['default']>): Promise<Response> => await import('node-fetch').then(async ({ default: fetch }) => await fetch(...args))

const key = 'AIzaSyDDxf1nRkG6eMcufxYp2LHIWgA-2MEMlK8'

function encodeQueryData (data: any): any {
  const ret: any[] = []
  for (const d in data) { ret.push(encodeURIComponent(data[d])) }
  return ret.join('&')
}

function getBook (params: any): any {
  const query = encodeQueryData(params)
  return (fetch(`https://www.googleapis.com/books/v1/volumes/${query}?key=${key}`)).then(async (res) => {
    if (!res.ok) {
      throw Error(res.statusText)
    }
    return await res.json()
  }).catch((err) => logger.error(err))
}

export { getBook }
