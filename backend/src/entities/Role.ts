/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import {
  Column,
  Entity,
  OneToMany,
  PrimaryGeneratedColumn
} from 'typeorm'

import { Account } from './Account'

@Entity()
export class Role {
  @PrimaryGeneratedColumn('uuid')
    id!: string

  @Column({ type: 'bigint' })
    permissions!: bigint

  @OneToMany(() => Account, user => user.role, { nullable: true })
    owners?: Account[]

  @Column()
    name!: string

  @Column({ length: 200 })
    description!: string
}
