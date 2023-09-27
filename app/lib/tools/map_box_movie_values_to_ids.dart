/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

List<int> mapBoxMovieValuesToIds(List<bool> boxMovieValue) {
  List<int> ids = [];

  if (boxMovieValue.isNotEmpty && boxMovieValue[0]) {
    ids.add(28);
  }
  if (boxMovieValue.length >= 2 && boxMovieValue[1]) {
    ids.add(53);
  }
  if (boxMovieValue.length >= 3 && boxMovieValue[2]) {
    ids.add(37);
  }
  if (boxMovieValue.length >= 4 && boxMovieValue[3]) {
    ids.add(27);
  }
  if (boxMovieValue.length >= 5 && boxMovieValue[4]) {
    ids.add(35);
  }
  if (boxMovieValue.every((value) => value == false)) {
    ids.add(35);
  }
  return ids;
}
