import { Router } from 'express';
import { signup } from '../controllers/user/index.js';
import { dropLesson } from "../controllers/user/index.js";

const router = Router();

// Auth
router.post('/signup', signup);
router.post("/enrolled/drop", dropLesson);

export default router