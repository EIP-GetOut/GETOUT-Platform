/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Response } from 'node-fetch'

import logger from '@middlewares/logging'

const fetch = async (args: any): Promise<Response> => await import('node-fetch').then(async ({ default: fetch }) => await fetch(args))

const key = 'AIzaSyDDxf1nRkG6eMcufxYp2LHIWgA-2MEMlK8'

function encodeQueryData (data: any): any {
  const ret: any[] = []
  for (const d in data) { ret.push(encodeURIComponent(d) + ':' + encodeURIComponent(data[d])) }
  return ret.join('&')
}

function getBooks (params: any): any {
  const query = encodeQueryData(params)
  return (fetch(`https://www.googleapis.com/books/v1/volumes?q=${query}&key=${key}`)).then(async (res) => {
    if (!res.ok) {
      throw Error(res.statusText)
    }
    return await res.json()
  }).catch((err) => logger.error(err.toString))
}

export { getBooks }
