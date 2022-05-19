import mongoose from 'mongoose';
import { Lesson } from '../../../models/index.js';

export default async (req, res) => {
  const lecturerId = req.query.lecturer;
  if (!lecturerId || !mongoose.isValidObjectId(lecturerId)) {
    return res.status(400).json({ "resultMessage": "Please provide a valid lecturer id." });
  }

  const lessons = await Lesson.find({ lecturer: lecturerId })
    .catch((err) => {
      return res.status(500).json({ "resultMessage": err.message });
    });

  return res.status(200).json({
    resultMessage: "Lessons are successfully fetched.",
    lessons: lessons,
  });
};
