/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response } from 'express'
import { Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import { logApiRequest } from '@services/middlewares/logging'

const router = Router()

interface DailyInfo {
  quote: string
  author: string | null
  sourceUrl: string | null
  sourceStr: string | null
}

const LIST_OF_DAILY_INFOS: DailyInfo[] = [
  { quote: 'Dans l\'ensemble, il est préférable d\'admettre que sur le réseau il n\'y a que des entités malveillantes dont le but est d\'envoyer des informations destinées à produire le pire effet.', author: 'Daniel Cohen', sourceUrl: null, sourceStr: null },
  { quote: '5,04 milliards d\'utilisateurs actifs peuplent les réseaux sociaux, soit 62,3 % de la population mondiale.', author: null, sourceUrl: 'https://www.blogdumoderateur.com/chiffres-reseaux-sociaux/', sourceStr: 'blogdumoderateur' },
  { quote: 'Les réseaux sociaux étaient censés remédier à la solitude sociale, ils l\'ont aggravée.', author: 'Laurent Ruquier', sourceUrl: null, sourceStr: null },
  { quote: 'On compte en 2024, pas moins de 50.7 millions d\'utilisateurs de médias sociaux, soit 78.22% de la population.', author: null, sourceUrl: 'https://www.ecommerce-nation.fr/infographie-utiliser-les-reseaux-sociaux-pour-votre-site-e-commerce/', sourceStr: 'ecommerce-nation' },
  { quote: 'Les réseaux sociaux ont donné le droit à la parole à des légions d\'imbéciles qui avant ne parlaient qu\'au bar et ne causaient aucun tort à la collectivité. On les faisait taire tout de suite. Aujourd\'hui ils ont le même droit de parole qu\'un prix Nobel.', author: 'Umberto Eco', sourceUrl: null, sourceStr: null },
  { quote: 'Près de 30 % des jeunes interrogées ont respectivement déclaré avoir déjà été insultés ou subi des moqueries sur les médias sociaux en 2019.', author: null, sourceUrl: 'https://fr.statista.com/statistiques/959915/situations-cyberviolence-subies-jeunes-reseaux-sociaux-france/', sourceStr: 'Statista' },
  { quote: 'Il faut prendre un peu de distance avec la polémique et les réseaux sociaux.', author: 'Emmanuel Macron', sourceUrl: null, sourceStr: null },
  { quote: 'Il y a plus de 4,2 milliards d\'utilisateurs de réseaux sociaux dans le monde.', author: null, sourceUrl: 'https://fr.statista.com/themes/9141/les-reseaux-sociaux/', sourceStr: 'Statista' },
  { quote: 'Soyez-vous même, tous les autres sont déjà pris.', author: 'Oscar Wilde', sourceUrl: null, sourceStr: null },
  { quote: 'En moyenne, les utilisateurs de réseaux sociaux possèdent 6,7 comptes sur les différentes plateformes.', author: null, sourceUrl: 'https://www.blogdumoderateur.com/chiffres-reseaux-sociaux/', sourceStr: 'blodumoderateur' },
  { quote: 'Il ne suffit pas de parler, il suffit de parler juste.', author: 'William Shakespeare', sourceUrl: null, sourceStr: null },
  { quote: '10 000 tweets sont publiés chaque seconde dans le monde.', author: null, sourceUrl: 'https://blog.hubspot.fr/marketing/chiffres-reseaux-sociaux', sourceStr: 'Blog Hubspot' },
  { quote: 'Dans le futur, tout le monde sera célèbre pour 15MB.', author: '@jojobickley', sourceUrl: null, sourceStr: null },
  { quote: 'Les gens plutôt que les pixels.', author: 'Ben Barry', sourceUrl: null, sourceStr: null },
  { quote: 'En 2020, les foyers français sont équipés de 6,4 écrans en moyenne, d\'après une étude Médiamétrie. Un chiffre en hausse considérable.', author: null, sourceUrl: 'https://www.matmut.fr/mutuelle/conseils/addiction-ecrans', sourceStr: 'Matmut' },
  { quote: 'C\'est mieux d\'avoir 100 personnes qui vous aiment énormément plutôt qu\'un million de personnes qui vous aiment un peu de loin.', author: '@BChesky', sourceUrl: null, sourceStr: null },
  { quote: '17% des adolescents de 17 ans déclarent avoir joué à un jeu d\'argent et de hasard sur Internet en 2017 (pourtant interdit aux mineurs).', author: null, sourceUrl: 'https://www.drogues.gouv.fr/lessentiel-sur-les-usages-problematiques-decrans', sourceStr: 'Gouvernement' },
  { quote: 'Je suis aussi fier de ce que nous ne faisons pas que de ce que nous faisons.', author: 'Steve Jobs', sourceUrl: null, sourceStr: null },
  { quote: 'Avec 17 milliards de visites mensuelles, Facebook est le 3e site le plus visité au monde, après Google et YouTube.', author: null, sourceUrl: 'https://blog.hubspot.fr/marketing/chiffres-reseaux-sociaux', sourceStr: 'Blog Hubspot' },
  { quote: 'Environ 1 Français sur 2 déclare passer plus de temps que prévu sur ses écrans, quel que soit le type d\'activité. Ce résultat est encore plus important chez les plus jeunes, notamment à l\'heure du coucher.', author: null, sourceUrl: 'https://www.drogues.gouv.fr/les-francais-addicts-leurs-ecrans', sourceStr: 'Gouvernement' },
  { quote: 'Tout le monde dit que les médias sociaux sont une sorte de licorne. Peut-être qu\'ils ne sont qu\'un simple cheval.', author: 'Jay Baer', sourceUrl: null, sourceStr: null },
  { quote: '4,5 milliards de likes sont enregistrés chaque jour sur Instagram.', author: null, sourceUrl: 'https://blog.hubspot.fr/marketing/chiffres-reseaux-sociaux', sourceStr: 'Blog Hubspot' },
  { quote: '"Créé en 1906" était important avant. Maintenant, c\'est un poids.', author: 'Seth Godin', sourceUrl: null, sourceStr: null },
  { quote: 'Plus de 14 millions de français addicts aux écrans.', author: null, sourceUrl: 'https://www.addictaide.fr/plus-de-14-millions-de-francais-addicts-aux-ecrans-une-etude-inquietante/', sourceStr: 'www.addictaire.fr' },
  { quote: 'C\'est triste que les esprits les plus brillants de notre génération réfléchissent à la manière de faire cliquer les gens le plus possible sur des publicités.', author: 'Jeremy Waite', sourceUrl: null, sourceStr: null },
  { quote: 'Jeunes et écrans : Pour le meilleur et pour le pire 72% des 15-25 ans entretiennent une relation toxique avec leur téléphone.', author: null, sourceUrl: 'https://presse.ramsaygds.fr/communique/212926/-Jeunes-ecrans-pour-meilleur-pour-pire-72-15-25-ans-entretiennent-relation-toxique-avec-leur-telephone', sourceStr: 'Ramsay Santé' },
  { quote: 'Si 50 millions de personnes disent quelque chose de stupide, c\'est tout de même stupide.', author: 'Rolf Dovelli', sourceUrl: null, sourceStr: null },
  { quote: '84 % des 17-34 ans déclarent par exemple aller au lit avec leur smartphone.', author: null, sourceUrl: 'https://www.jeunes.gouv.fr/smartphones-ecrans-tous-accros-1863', sourceStr: 'Gouvernement' },
  { quote: 'Les réseaux sociaux entament la part d\'intimité et de secret qui était encore notre bien jusqu\'à une époque récente - le secret qui donnait de la profondeur aux personnes et pouvait être un grand thème romanesque.', author: 'Patrick Modiano', sourceUrl: null, sourceStr: null },
  { quote: 'Selon le dernier baromètre des addictions réalisé par Ipsos/Macif, 41 % des jeunes de 16 à 30 ans, soit environ 2 jeunes sur 5, passent plus de 6 heures par jour devant un écran.', author: null, sourceUrl: 'https://www.senat.fr/questions/base/2022/qSEQ220628410.html', sourceStr: 'Senat' },
  { quote: 'Addictions : 97% des Français interrogés disent passer trop de temps devant les écrans', author: null, sourceUrl: 'https://www.rtl.fr/actu/debats-societe/addictions-97-des-francais-interroges-disent-passer-trop-de-temps-devant-les-ecrans-7900316030', sourceStr: 'RTL' },
  { quote: 'Entre janvier 2023 et janvier 2024, il y a eu 266 millions d\'utilisateurs de réseaux sociaux en plus dans le monde (+5,6 %).', author: null, sourceUrl: 'https://www.blogdumoderateur.com/chiffres-reseaux-sociaux/', sourceStr: 'blogdumoderateur' },
  { quote: 'Audra serra son portable avec aigreur. Si seulement elle arrivait à s\'en débarrasser, à oublier les réseaux sociaux qui, au lieu de créer des liens, isolaient les individus dans des bulles.', author: 'Franck Thilliez', sourceUrl: null, sourceStr: null },
  { quote: 'A l\'heure du numérique, il n\'a jamais été aussi facile de publier des informations mensongères qui sont immédiatement reprises et passent pour des vérités.', author: 'Katharine Viner', sourceUrl: null, sourceStr: null }
]

function getDaysIntoYear (date: Date): number {
  return (Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()) - Date.UTC(date.getFullYear(), 0, 0)) / 24 / 60 / 60 / 1000
}

function getDailyInfo (): DailyInfo {
  const daysIntoYear: number = getDaysIntoYear(new Date())
  return LIST_OF_DAILY_INFOS[daysIntoYear % LIST_OF_DAILY_INFOS.length]
}

router.get('/daily-info', logApiRequest, (req: Request, res: Response) => {
  const dailyInfo: DailyInfo = getDailyInfo()
  return res.status(StatusCodes.OK).send(dailyInfo)
})

export default router
