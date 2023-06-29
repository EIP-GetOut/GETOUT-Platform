/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

export interface BookResult {
    kind?: string;
    id?: string;
    etag?: string;
    selfLink?: string;
    volumeInfo?: any;
    saleInfo?: any;
    accessInfo?: any;
    searchInfo?: any;
}