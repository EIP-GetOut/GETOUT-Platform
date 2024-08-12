/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type SendSmtpEmail, TransactionalEmailsApi } from '@getbrevo/brevo'

import { AccountDoesNotExistError, EmailSendError } from '@services/utils/customErrors'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

function handleTestEnvironment (): ReturnType<TransactionalEmailsApi['sendTransacEmail']> | null {
  if (process.env.NODE_ENV !== 'test') {
    return null
  }
  // eslint-disable-next-line @typescript-eslint/consistent-type-assertions
  const mockAnswer = {} as ReturnType<TransactionalEmailsApi['sendTransacEmail']>
  return mockAnswer
}

async function sendEmailWithBrevo (templateId: number, to: string, params: object): ReturnType<TransactionalEmailsApi['sendTransacEmail']> {
  const testEnvironment = handleTestEnvironment()
  if (testEnvironment !== null) { return await testEnvironment }

  const apiInstance = new TransactionalEmailsApi()
  apiInstance.setApiKey(0, process.env.BREVO_API_KEY)
  const sendSmtpEmail: SendSmtpEmail = {
    templateId,
    to: [{ email: to }],
    params
  }

  return await apiInstance.sendTransacEmail(sendSmtpEmail)
}

async function sendInactivityEmail (account: Account): Promise<ReturnType<TransactionalEmailsApi['sendTransacEmail']>> {
  const params = { fullName: `${account.firstName} ${account.lastName}` }

  return await sendEmailWithBrevo(15, account.email, params).catch((err: Error) => {
    throw new EmailSendError(`Error while sending inactivity email to ${account.email}: ${err.message}.`)
  })
}

async function sendResetPasswordEmail (email: string, passwordResetCode: number): ReturnType<TransactionalEmailsApi['sendTransacEmail']> {
  return await findEntity<Account>(Account, { email }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }
    const params = {
      fullName: `${account.firstName} ${account.lastName}`,
      code: passwordResetCode
    }

    return await sendEmailWithBrevo(17, account.email, params)
  }).catch((err: Error) => {
    throw new EmailSendError(`Error while sending reset password email to ${email}: ${err.message}.`)
  })
}

async function sendWelcomeEmail (account: Account): ReturnType<TransactionalEmailsApi['sendTransacEmail']> {
  const params = { fullName: `${account.firstName} ${account.lastName}` }

  return await sendEmailWithBrevo(18, account.email, params).catch((err: Error) => {
    throw new EmailSendError(`Error while sending welcome email to ${account.email}: ${err.message}.`)
  })
}

async function sendEmailVerificationEmail (account: Account, code: number): ReturnType<TransactionalEmailsApi['sendTransacEmail']> {
  const params = {
    fullName: `${account.firstName} ${account.lastName}`,
    code: code.toString()
  }
  return await sendEmailWithBrevo(12, account.email, params).catch((err: Error) => {
    throw new EmailSendError(`Error while sending email verification email to ${account.email}: ${err.message}.`)
  })
}

async function sendBetaInvitationEmail (account: Account, password: string): ReturnType<TransactionalEmailsApi['sendTransacEmail']> {
  const params = {
    fullName: `${account.firstName} ${account.lastName}`,
    email: account.email,
    password
  }
  return await sendEmailWithBrevo(10, account.email, params).catch((err: Error) => {
    throw new EmailSendError(`Error while sending beta invitation email to ${account.email}: ${err.message}.`)
  })
}

export {
  sendBetaInvitationEmail,
  sendEmailVerificationEmail,
  sendInactivityEmail,
  sendResetPasswordEmail,
  sendWelcomeEmail
}
