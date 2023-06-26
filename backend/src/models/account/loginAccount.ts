/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Session, SessionData } from "express-session"
import { StatusCodes } from "http-status-codes"

import { findEntity } from "@models/getObjects"

import { Account } from "@entities/Account"

import { accountRepositoryRequest } from "./account"

function createSession (sess: Session & Partial<SessionData>, account: Account) {
    const week = 3600000 * 24 * 7

    sess.cookie.expires = new Date(Date.now() + week)
    sess.cookie.maxAge = week
    sess.account = {
        id: account.id,
        email: account.email,
        firstName: account.firstName,
        lastName: account.lastName,
        bornDate: account.bornDate,
        createdDate: account.createdDate
    }
}

function loginAccount(accountToLogin: accountRepositoryRequest, sess: Session) {
    return findEntity<Account>(Account, { email: accountToLogin.email }).then((foundAccount: Account | null): any => {
        if (!foundAccount) {
            return StatusCodes.FORBIDDEN
        }
        if (foundAccount.password === accountToLogin.password) {
            createSession(sess, foundAccount)
            return StatusCodes.OK
        } else {
            return StatusCodes.FORBIDDEN
        }
    })
}

export default loginAccount