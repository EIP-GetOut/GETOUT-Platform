/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { StatusCodes } from "http-status-codes"

import { findEntity } from "@models/getObjects"

import { Account } from "@entities/Account"

import { accountRepositoryRequest } from "./account"

function loginAccount(accountToLogin: accountRepositoryRequest) {
    return findEntity<Account>(Account, { email: accountToLogin.email }).then((foundAccount: Account | null): any => {
        if (!foundAccount) {
            return StatusCodes.FORBIDDEN
        }
        if (foundAccount.password === accountToLogin.password) {
            return StatusCodes.OK
        } else {
            return StatusCodes.FORBIDDEN
        }
    })
}

export default loginAccount