/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/


import { OAuth2Client } from "google-auth-library";

const fetch = (...args: Parameters<typeof import('node-fetch')['default']>) => import('node-fetch').then(({ default: fetch }) => fetch(...args));

function authentifyWithGoogle(account): Promise<[boolean, any]> {
  const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

  return new Promise((resolve, reject) => {
    client.verifyIdToken({
        idToken: account.idToken,
        audience: process.env.GOOGLE_CLIENT_ID
    }, (err) => {
      if (err) { resolve([false, null]) }
      return resolve([true, {
        ...account
      }])
  })})
}

function getAccountInfoWithGithubCode(code) {
  if (!code) { return Promise.resolve(null) }

  const authorizeUrlGithub = new URL('https://github.com/login/oauth/access_token')
  authorizeUrlGithub.search = new URLSearchParams({
    client_id: process.env.GITHUB_CLIENT_ID ?? '',
    client_secret: process.env.GITHUB_CLIENT_SECRET ?? '',
    code: code
  }).toString()

  return fetch(authorizeUrlGithub.toString(), {
    method: 'POST',
    headers: {
      'Accept': 'application/json'
    }
  }).then((res) => {
    if (!res.ok) {
      throw Error(res.statusText)
    }
    return res.json()
  }).then((data) => {
    return fetch('https://api.github.com/user', {
      headers: { 'Authorization': `${data.token_type} ${data.access_token}` }
    })
  }).then((res) => {
    if (!res.ok) {
      throw Error(res.statusText)
    }
    return res.json()
  }).then((data) => {
    const [firstName, lastName] = data.name.split(' ');
    return { firstName, lastName, email: data.login, authentifiedWithGithub: true }
  }).catch((err) => {
    throw err
  })
}

export { authentifyWithGoogle, getAccountInfoWithGithubCode }