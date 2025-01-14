import React, { useEffect, useState } from 'react';
import './style.css'
import '../components/component_styles.css'
import Footer from '../components/Footer';
import NavBar from '../components/NavBar';
import illustration from '../images/categories-page-illustration.svg'
import pp from '../images/elipse.png'
import happy from '../images/happy.png'
import axios from 'axios'
import UserNameProfile from '../components/UserNameProfile';
import { useParams } from 'react-router-dom';
import ProfilePhoto from '../components/ProfilePhoto';
import AboutUser from '../components/AboutUser';
import LearningSpaceDetailsProfile from '../components/LearningSpaceDetailsProfile';


function ProfilePage() {
    const { username } = useParams();
    const [profilePicture, setProfilePicture] = useState('')
    const [bio, setBio] = useState('')
    const [learningspaces, setLearningSpaces] = useState([])


    useEffect(() => {
        const getProfile = async () => {
            const res = await axios.get(`${process.env.REACT_APP_BACKEND_BASE_URL}user/${username}`)
            setProfilePicture(res.data.profile_picture)
            setBio(res.data.bio)
            setLearningSpaces([...res.data.participated, ...res.data.created]);
            console.log(res.data)
            console.log(res.data.bio)
        }
        getProfile()
    }, [])

    
    return(
    <div className='profilepageLayout'>
        <NavBar />
        <div className='profilepage'>
            <div className='profile-page-left'>

                <div className='space-80'/>
            
                <AboutUser bio={bio} userviewed={username}/>
                

                <div className='space-80'/>

                <img src={illustration} alt="Categories Page Illustration" height={170} />
            </div>

            <div className='profile-page-middle'>

                <ProfilePhoto profilePicture={profilePicture} userviewed={username}/>
                <div>
                <UserNameProfile user = {username}/>
                </div>
                <div className='space-20'/>
                    <label className='user-profile-ls-text'> {username}'s learning spaces box </label>                    
                
                <div className='profile-page-ls-box'>
                    {learningspaces.map(ls => (
                     <LearningSpaceDetailsProfile
                        key={ls.id}
                        title={ls.title} 
                         description={ls.description} 
                        icon_id={ls.icon_id} 
                        num_participants={ls.num_participants} 
                        url={ls.id}
                         />
                        ))}
                </div>

            </div>

            <div className='profile-page-right'>
                <div className='space-50'/>
                <div className='profile-page-image'>
                    <img src={happy} alt="Profile photo" height={250}/>
                </div>
                <div className='space-12'/>
                <label className='profile-page-text'> "Meet with new people and learn together, that is what matters..."</label>
                <label className='profile-page-text-two'>  - Team LEARNIFY</label>
                <div className='space-20'/>
                <div className='profilepage-friends-box'>
                    <label className='feed-title'>
                        <label className='navBarText2'> Interest Areas</label>
                    </label>
                    <div className='space-3'/>
                    Knitting
                    <div className='space-3'/>
                    Cooking
                    <div className='space-3'/>
                    Coding
                    <div className='space-3'/>
                    Reading
                    <div className='space-3'/>
                    Writing
                </div>
                

            </div>
              
    
            
        </div>
        <Footer />
    </div>

            
        )       
    }
    
    export default ProfilePage;

