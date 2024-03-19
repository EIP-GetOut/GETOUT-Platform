/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import {
  Column,
  Entity,
  PrimaryGeneratedColumn
} from 'typeorm'

@Entity()
export class Permission {
  @PrimaryGeneratedColumn('uuid')
    id!: string

  @Column({ type: 'bigint' })
    bit!: bigint

  @Column()
    name!: string
}
