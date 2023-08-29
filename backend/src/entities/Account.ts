/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

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
    id!: string

  @Column({ length: 32 })
    email!: string

  @Column({ length: 32, nullable: true })
    salt!: string

  @Column({ length: 64, nullable: true })
    password!: string

  @Column('uuid', { nullable: true, default: null })
    passwordResetToken?: string

  @Column({ nullable: true, default: null })
    passwordResetExpiration?: Date

  @Column('bigint', { nullable: true, default: null })
    passwordResetPassword?: bigint

  @Column({ length: 32, nullable: true })
    firstName?: string

  @Column({ length: 32, nullable: true })
    lastName?: string

  @Column('date', { nullable: true })
    bornDate?: Date

  @CreateDateColumn()
    createdDate!: Date

  @UpdateDateColumn()
    modifiedDate!: Date
}
