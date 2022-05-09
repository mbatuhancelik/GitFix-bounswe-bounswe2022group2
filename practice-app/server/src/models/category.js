import mongoose from 'mongoose';
const { Schema, model } = mongoose;

// We can add additional fields if we enlarge the features of the app.
const categorySchema = new Schema({
    title: {
        type: String,
        minlength: [5, 'Please provide a longer name'],
        required: true,
    },
    description: String,
    lectures: [mongoose.ObjectId]
},
  {
    timestamps: true,
    toJSON: {
      transform: function (doc, ret, options) {
        ret.id = ret._id;
        delete ret._id;
        return ret;
      },
      virtuals: true,
    },
    versionKey: false,
  });

const Category = model('Category', categorySchema)
export default Category