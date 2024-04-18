/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { OAuth2Client } from 'google-auth-library'

import { type oauthAccount } from '@routes/account/oauth/oauthAccount'

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

export { authentifyWithGoogle }
