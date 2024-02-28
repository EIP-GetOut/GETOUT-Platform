/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { UUID } from 'crypto'
import {
  Entity,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  Column
} from 'typeorm'

import { Preferences } from '@models/account/preferences.intefaces'

@Entity()
export class Account {
  @PrimaryGeneratedColumn('uuid')
    id!: UUID

  @Column({ length: 32 })
    email!: string

  @Column({ length: 32, nullable: true })
    salt!: string

  @Column({ length: 64, nullable: true })
    password!: string

  @Column('uuid', { nullable: true, default: null })
    passwordResetToken: string | null = null

  @Column('timestamp', { nullable: true, default: null })
    passwordResetExpiration: Date | null = null

  @Column('integer', { nullable: true, default: null })
    passwordResetPassword: number | null = null

  @Column({ length: 32, nullable: true })
    firstName?: string

  @Column({ length: 32, nullable: true })
    lastName?: string

  @Column('date', { nullable: true })
    bornDate?: Date

  @Column('jsonb', { nullable: true, default: null })
    preferences?: Preferences

  @Column('integer', { array: true, default: [] })
    watchlist: number [] = []

  @Column('text', { array: true, default: [] })
    readingList: string [] = []

  @Column('integer', { array: true, default: [] })
    likedMovies: number [] = []

  @Column('text', { array: true, default: [] })
    likedBooks: string [] = []

  @Column('integer', { array: true, default: [] })
    dislikedMovies: number [] = []

  @Column('text', { array: true, default: [] })
    dislikedBooks: string [] = []

  @Column('integer', { array: true, default: [] })
    seenMovies: number [] = []

  @Column('text', { array: true, default: [] })
    readBooks: string [] = []

  @CreateDateColumn()
    createdDate!: Date

  @UpdateDateColumn()
    modifiedDate!: Date
}
