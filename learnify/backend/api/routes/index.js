import { Router } from 'express';
import  auth from './auth.js';
import learning_space from './learning_space.js'
import categories from './categories.js';

import event from './event.js'

import user from './user.js'

import annotations from './annotations-service.js';



const router = Router();

router.use('/auth', auth);
router.use('/learningspace', learning_space);
router.use('/categories', categories);

router.use('/events', event);

router.use('/user', user);

router.use('/annotations-service', annotations);




export default router;