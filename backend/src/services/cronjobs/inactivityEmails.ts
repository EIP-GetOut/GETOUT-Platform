/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { sendInactivityEmail } from '@services/brevo/emails'
import logger from '@services/middlewares/logging'
import { EmailSendError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

async function sendInactivityEmails (): Promise<void> {
  const accountRepository = appDataSource.getRepository(Account)

  const oneWeekAgo = new Date()
  oneWeekAgo.setDate(oneWeekAgo.getDate() - 7)

  const inactiveAccounts = await accountRepository
    .createQueryBuilder('account')
    .where('account.modifiedDate < :oneWeekAgo', { oneWeekAgo })
    .andWhere('account.isVerified = :isVerified', { isVerified: true })
    .getMany()

  inactiveAccounts.forEach((account) => {
    sendInactivityEmail(account).then(async () => {
      logger.info(`Inactivity email sent to: ${account.email}`)
      account.inactivityEmailSent = true
      return await accountRepository.save(account)
    }).catch((error: Error) => {
      throw new EmailSendError(`Failed to send email to ${account.email}: ${error.message}`)
    })
  })
}

export { sendInactivityEmails }
