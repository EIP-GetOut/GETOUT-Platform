/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { StatusCodes } from "http-status-codes"

import logger from "@middlewares/logging"

import { findEntity } from "@models/getObjects"


import { Account } from "@entities/Account"

import { appDataSource } from "@config/dataSource"

import { accountRepositoryRequest } from "./account"

function createNewAccountObject (account: accountRepositoryRequest) {
    let bornDate = account.bornDate || null

    if (bornDate) {
        const date = bornDate.toString().split('/')
        bornDate = new Date(parseInt(date[2]), parseInt(date[1]) - 1, parseInt(date[0]))
    }
    return ({
        salt: account.salt,
        email: account.email,
        password: account.password,
        firstName: account.firstName,
        lastName: account.lastName,
        bornDate,
    })
}

function registerAccount (account: accountRepositoryRequest) {
    const accountRepository = appDataSource.getRepository(Account)

    return findEntity<Account>(Account, { email: account.email }).then((foundAccount: Account | null): any => {
        if (foundAccount) {
            return StatusCodes.CONFLICT
        }
        const newAccount: accountRepositoryRequest = createNewAccountObject(account)
        if (!newAccount) { return undefined }
        return accountRepository.save(newAccount).then((savedAccount) => {
            if (!savedAccount) { return StatusCodes.BAD_REQUEST }
            logger.info(`Account has been created: ${JSON.stringify(savedAccount, null, 2)}`)
            return savedAccount
        })
    })
}

export default registerAccount