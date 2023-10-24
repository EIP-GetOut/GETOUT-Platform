/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import type SMTPTransport from 'nodemailer/lib/smtp-transport'

export const emailConfig: SMTPTransport.Options = {
  service: 'Gmail',
  auth: {
    user: 'test@examle.com',
    pass: 'password'
  }
}
