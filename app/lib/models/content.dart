/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

enum Type {
  movie,
  book
}

class Content {
   String? url;
   int? star;
   Type? type;
   String? description;
}