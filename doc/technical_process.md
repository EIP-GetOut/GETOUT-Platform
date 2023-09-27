I/ Commits

- Les commits devront respecter la norme "Conventional Commits" (https://www.conventionalcommits.org/en/v1.0.0/) soit en respectant scrupuleusement la norme lors du commit soit en s'aidant de l'extension vscode (https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits)
- Le titre du commit devra être le plus succinct possible
- Un body de description plus détaillé devra être fourni dans la mesure du possible, il y en aura toujours un sauf si le titre du commit se suffit à lui-même. (ajout d'un header dans un fichier par exemple)
- Un script passera en revue les commits à chaque nouvelle tentative et rejettera tout les commits non-conforme

```
	git pull
	git add fileToPush.js
	git commit -m "feat: :sparkles: my new super feature
		Description of my new feature"
```

II/ Créer et merge une branche

- Lors de la création d'une branche, s'il s'agit d'une branche de feature, la branche devra avoir le nom de cette dites feature
- La branche origin/Head est la branche de prod et a été renommé par conséquent en "prod", aucun code non vérifié ne sera push sur cette branche
- Toute nouvelle branche créé découlera donc de la branche "dev" qui est la branche sur laquelle tout le code est merge avant d'être envoyé en prod

Pour créer une branche :
```
 git checkout -b "nameOfTheFeature"
```

Pour update une branche avec une autre branche :
```
	git checkout "branchWhoseContentIWant"
	git pull
	git checkout "myFeature"
	git merge "branchWhoseContentIWant"
```

III/ Mettre du code en production

- Si la feature à mettre en production est sur une branche de feature, il faut d'abord la mettre sur la branche de dev grâce à une pull request
- Pour la pull request il faudra mettre au moins un reviewer et attendre que le code ait été passé en revue par cette/ces personne(s)
- Si la feature est déjà sur la branche dev, il faudra alors créer une pull request avec le chef de pôle en tant que reviewer, à défaut le chef de groupe devra être mis en tant que reviewer
- Une fois que la pull request est accepté, le chef du pôle en question ira rebase la prod pour nettoyer l'historique de commit ainsi que résoudre les merge conflicts, à défaut le chef de groupe s'en chargera