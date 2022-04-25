import { Router } from 'express';
import swaggerUi from 'swagger-ui-express';
import apiSpec from '../openapi.json';

import * as BookController from './controllers/book';

const swaggerUiOptions = {
  customCss: '.swagger-ui .topbar { display: none }'
};

const router: Router = Router();

// Book routes
router.post('/api/book/add', [BookController.add]);
router.get('/api/book/all', [BookController.all]);
router.get('/api/book/search', [BookController.search]);
router.get('/api/book/id/:bookId', BookController.get);
router.delete('/api/book/id/:bookId', [BookController.remove]);

// Dev routes
if (process.env.NODE_ENV === 'development') {
  router.use('/dev/api-docs', swaggerUi.serve);
  router.get('/dev/api-docs', swaggerUi.setup(apiSpec, swaggerUiOptions));
}

export default router;
