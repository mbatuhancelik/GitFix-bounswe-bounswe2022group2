import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import './App.css';
import EmailVerificationPage from './pages/EmailVerificationPage';
import ForgetPassword from './pages/ForgetPassword';
import LoginForm from './pages/LoginForm';
import HomePage from './pages/HomePage';
import SignUpForm from './pages/SignUpForm';
import PrivateRoutes from './pages/PrivateRoutes';
import PrivateRoutesVerify from './pages/PrivateRoutesVerify';
import ChangePassword from './pages/ChangePassword';
import NotFoundPage from './pages/NotFoundPage';

import CreateLS from './pages/CreateLS';
import LearningSpace from './pages/LearningSpace';

import CategoriesPage from './pages/CategoriesPage';
import LSbyCategoryPage from './pages/LSbyCategoryPage';
import ProfilePage from './pages/ProfilePage';
import AboutPage from './pages/AboutPage';
import MyLearningSpacesPage from './pages/MyLearningSpacesPage';
import PopularLearningSpacesPage from './pages/PopularLearningSpacesPage';
import ContactPage from './pages/ContactPage';
import RecommendedLearningSpacesPage from './pages/RecommendedLearningSpacesPage';


function App() {

  return (
    
    <div className="App">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<SignUpForm/>}/>
          <Route path="/login" element={<LoginForm/>}/>
          <Route path="/verify-email" element={<PrivateRoutesVerify> <EmailVerificationPage /> </PrivateRoutesVerify>}/>
          <Route path="/home" element={<PrivateRoutes> <HomePage /> </PrivateRoutes>}/>
          <Route path="/about" element={<AboutPage/>}/>
          <Route path="/contact" element={<ContactPage/>}/>
          <Route path="/forget-password" element={<ForgetPassword/>}/>
          <Route path="/change-password" element={<ChangePassword/>}/>
          <Route path="/create-ls" element={<PrivateRoutes> <CreateLS /> </PrivateRoutes>}/>
          <Route path="/categories" element={<PrivateRoutes> <CategoriesPage /> </PrivateRoutes>}/>
          <Route path="/categories/:category" element={<PrivateRoutes> <LSbyCategoryPage /> </PrivateRoutes>}/>
          <Route path="/learningspace/:lsid" element={<PrivateRoutes> <LearningSpace /> </PrivateRoutes>}/>
          <Route path="/profile/:username" element={<PrivateRoutes> <ProfilePage /> </PrivateRoutes>}/>
          <Route path="/:username/learningspaces" element={<PrivateRoutes> <MyLearningSpacesPage /> </PrivateRoutes>}/>
          <Route path="/popular" element={<PrivateRoutes> <PopularLearningSpacesPage /> </PrivateRoutes>}/>
          <Route path="/recommended" element={<PrivateRoutes> <RecommendedLearningSpacesPage /> </PrivateRoutes>}/>
          <Route path='*' element={<NotFoundPage/>} />
        </Routes>
      </BrowserRouter>

    </div>

    
  );
}

export default App;
