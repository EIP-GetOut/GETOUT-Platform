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
  Column,
  ManyToOne
} from 'typeorm'

import { Preferences } from '@models/account/preferences.intefaces'

import { Role } from './Role'

@Entity()
export class Account {
  @PrimaryGeneratedColumn('uuid')
    id!: UUID

  @Column({ length: 64 })
    email!: string

  @Column({ length: 32, nullable: true })
    salt!: string

  @Column({ length: 64, nullable: true })
    password!: string

  @Column('integer', { nullable: true, default: null })
    passwordResetCode: number | null = null

  @Column('timestamp', { nullable: true, default: null })
    passwordResetExpiration: Date | null = null

  @Column('boolean', { default: false })
    isVerified: boolean = false

  @Column('integer', { nullable: true, default: null })
    emailVerificationCode: number | null = null

  @Column('timestamp', { nullable: true, default: null })
    emailVerificationExpiration: Date | null = null

  @Column({ length: 32, nullable: true })
    firstName?: string

  @Column({ length: 32, nullable: true })
    lastName?: string

  @Column('date', { nullable: true })
    bornDate?: Date

  @Column('jsonb', { nullable: true, default: null })
    preferences?: Preferences

  @Column('jsonb', { array: true, default: [] })
    readBooks: string [] = []

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

  @Column('timestamp', {
    nullable: true,
    default: null
  })
    lastMovieRecommandation: Date | null = null

  @Column('timestamp', {
    nullable: true,
    default: null
  })
    lastBookRecommandation: Date | null = null

  @Column('text', { array: true, default: [] })
    recommendedBooksHistory: string [] = []

  @Column('integer', { array: true, default: [] })
    recommendedMoviesHistory: number [] = []

  @ManyToOne(() => Role, role => role.owners)
    role!: Role

  @CreateDateColumn()
    createdDate!: Date

  @UpdateDateColumn()
    modifiedDate!: Date
}
