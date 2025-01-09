# Tests unitaires

Le projet utilise **Jest** et **Supertest** pour réaliser des tests unitaires. Ces tests permettent de vérifier des parties spécifiques du code, comme les routes ou des fonctions isolées.

## Emplacement des tests

Les tests unitaires sont situés dans le dossier suivant :
`/backend/tests`

## Comment exécuter les tests

1. Installez les dépendances nécessaires avec la commande suivante :
   ```bash
   npm install
   ```

2. Exécutez les tests unitaires en lançant le script Bash :
   ```bash
   ./run-unit-tests
   ```

## Exemple de fichier de test

Voici un exemple de fichier de test pour tester les routes utilisateur :

```typescript
import { expect, it } from '@jest/globals';
import { describe } from 'node:test';
import request from 'supertest';

import { app } from '@config/jestSetup';

void describe('User Routes', () => {
  it('should respond with 200 OK for GET /', async () => {
    await request(app).get('/').then((response) => {
      expect(response.status).toBe(200);
    });
  });

  it('should respond with 404 Not Found for invalid route', async () => {
    await request(app).get('/nonexistent').then((response) => {
      expect(response.status).toBe(404);
    });
  });
});
```

### Structure d'un test unitaire

1. **Importer les modules nécessaires** :
   Utilisez `@jest/globals` pour les assertions et `supertest` pour simuler des requêtes HTTP.

2. **Créer une suite de tests** :
   Utilisez `describe` pour regrouper plusieurs tests relatifs à une même fonctionnalité.

3. **Définir les cas de test individuels** :
   Utilisez `it` pour décrire chaque cas de test et définir le comportement attendu, par exemple :
   - Vérifier que la route `/` retourne un code `200`.
   - Vérifier qu'une route inexistante retourne un code `404`.

4. **Exécuter les requêtes HTTP** :
   Utilisez `request(app)` pour simuler une requête et validez les résultats avec `expect`.

En suivant cet exemple, vous pouvez écrire vos propres tests pour d'autres fonctionnalités.
