/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { OAuth2Client } from 'google-auth-library'
import { type Response } from 'node-fetch'

import { type oauthAccount } from '@routes/account/oauth/oauthAccount'

// eslint-disable-next-line @typescript-eslint/consistent-type-imports
const fetch = async (...args: Parameters<typeof import('node-fetch')['default']>): Promise<Response> => await import('node-fetch').then(async ({ default: fetch }) => await fetch(...args))

async function authentifyWithGoogle (account: oauthAccount): Promise<[boolean, any]> {
  const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID)

  return await new Promise((resolve, reject) => {
    client.verifyIdToken({
      idToken: account.idToken,
      audience: process.env.GOOGLE_CLIENT_ID
    }, (err) => {
      if (err != null) { resolve([false, null]) }
      resolve([true, {
        ...account
      }])
    })
  })
}

async function getAccountInfoWithGithubCode (code: string): Promise< any | null> {
  if (code == null) { return await Promise.resolve(null) }

  const authorizeUrlGithub = new URL('https://github.com/login/oauth/access_token')
  authorizeUrlGithub.search = new URLSearchParams({
    client_id: process.env.GITHUB_CLIENT_ID ?? '',
    client_secret: process.env.GITHUB_CLIENT_SECRET ?? '',
    code
  }).toString()

  return await fetch(authorizeUrlGithub.toString(), {
    method: 'POST',
    headers: {
      Accept: 'application/json'
    }
  }).then(async (res) => {
    if (!res.ok) {
      throw Error(res.statusText)
    }
    return await res.json()
  }).then(async (data: any) => {
    return await fetch('https://api.github.com/user', {
      headers: { Authorization: `${data.token_type} ${data.access_token}` }
    })
  }).then(async (res) => {
    if (!res.ok) {
      throw Error(res.statusText)
    }
    return await res.json()
  }).then((data: any) => {
    const [firstName, lastName] = data.name.split(' ')
    return { firstName, lastName, email: data.login, authentifiedWithGithub: true }
  }).catch((err) => {
    throw err
  })
}

export { authentifyWithGoogle, getAccountInfoWithGithubCode }
