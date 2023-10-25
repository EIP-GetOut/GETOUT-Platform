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

  @Column('jsonb', { nullable: true, default: () => "'[]'" })
    preferences?: string[]

  @CreateDateColumn()
    createdDate!: Date

  @UpdateDateColumn()
    modifiedDate!: Date
}
