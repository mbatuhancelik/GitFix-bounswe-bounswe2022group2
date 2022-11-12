import { expect } from 'expect';
import mongoose from 'mongoose';
import request from 'supertest';
import { LearningSpace, User } from '../models/index.js';
import app from '../app.js';
import jwt from "jsonwebtoken";



describe('POST /learningspace', () => {
  const url = '/learningspace';



  it('should return 400 when title is missing', (done) => {
      const title = "title1";
      const description= "description1";
      const token = "token"        
      const username = "username"

    sinon.stub(jwt, "decode")
    .onFirstCall().resolves(
      {username}
    );
    request(app)
      .post(url)
      .send({description, token }) //title is missing
      .expect(400)
      .end(async (err) => {
        if (err) return done(err);
        });

        done();
      });


  it('should return 400 when description is missing', (done) => {
    const title = "title1";
    const description= "description1";
    const token = "token"        
    const username = "username"

  sinon.stub(jwt, "decode")
  .onFirstCall().resolves(
    {username}
  );
  request(app)
    .post(url)
    .send({title, token }) //title is missing
    .expect(400)
    .end(async (err) => {
      if (err) return done(err);
      });
      done();
    });


  it('should create the endpoint', (done) => {
      const title = "title1";
      const description= "description1";
      const token = "token"        
      const username = "username"

    sinon.stub(jwt, "decode")
    .onFirstCall().resolves(
      {username}
    );
    request(app)
      .post(url)
      .send({ title, description, token })
      .expect(200)
      .end(async (err) => {
        if (err) return done(err);
        });

      LearningSpace.findOne({ title }).then((ls) => {
        expect(ls.title).toBe(title);
        expect(ls.description).toBe(description);
        expect(ls.creator).toBe(username);
        done();
      });
  });
});