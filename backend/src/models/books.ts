/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import logger from '@middlewares/logging'

const fetch = (args: any) => import('node-fetch').then(({ default: fetch }) => fetch(args));

const key = 'AIzaSyDDxf1nRkG6eMcufxYp2LHIWgA-2MEMlK8'

function encodeQueryData(data: any): any {
    const ret = [];
    for (const d in data)
      ret.push(encodeURIComponent(d) + ':' + encodeURIComponent(data[d]));
    return ret.join('&');
 }

function getBooks(params: any): any {
    const query = encodeQueryData(params)
    return (fetch(`https://www.googleapis.com/books/v1/volumes?q=${query}&key=${key}`)).then((res) => {
        if (!res.ok) {
            throw Error(res.statusText)
        }
        return res.json()
    }).catch((err) => logger.error(err.toString))
}

export { getBooks }