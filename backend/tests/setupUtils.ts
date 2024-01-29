/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

function extractConnectSidCookie (str: string): string | null {
  const startIndex = str.indexOf('connect.sid=')

  if (startIndex !== -1) {
    const endIndex = str.indexOf(';', startIndex)

    if (endIndex !== -1) {
      return str.substring(startIndex, endIndex)
    } else {
      console.log('Semicolon not found after connect.sid=')
    }
  } else {
    console.log('connect.sid= not found in the string')
  }

  return null
}

export { extractConnectSidCookie }
