# Unit Tests

The project uses **Jest** and **Supertest** to perform unit tests. These tests help verify specific parts of the code, such as routes or isolated functions.

## Test Location

Unit tests are located in the following directory:  
`/backend/tests`

## How to Run the Tests

1. Install the required dependencies with the following command:  
   ```bash
   npm install
   ```

2. Run the unit tests using the Bash script:  
   ```bash
   ./run-unit-tests
   ```

## Example Test File

Here is an example of a test file for testing user routes:

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

### Structure of a Unit Test

1. **Import the necessary modules**:  
   Use `@jest/globals` for assertions and `supertest` to simulate HTTP requests.

2. **Create a test suite**:  
   Use `describe` to group multiple tests related to the same feature.

3. **Define individual test cases**:  
   Use `it` to describe each test case and define the expected behavior, for example:
   - Verify that the `/` route returns a `200` status code.
   - Verify that a nonexistent route returns a `404` status code.

4. **Execute HTTP requests**:  
   Use `request(app)` to simulate a request and validate the results with `expect`.

By following this example, you can write your own tests for other features.
