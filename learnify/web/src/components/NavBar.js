import logo from '../images/logo-dblue.png' 
import bell from '../images/notification-icon.svg'
import React, {useState, useEffect } from 'react'
import './component_styles.css';
import axios from 'axios'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'	
import { solid } from '@fortawesome/fontawesome-svg-core/import.macro'

export default function NavBar(){

    const [searchDecision, setSearchDecision] = useState(false);

    const [searchLsResults, setSearchLsResults] = useState([])
    const [searchUserResults, setSearchUserResults] = useState([])

    const [searchLsInput, setSearchLsInput] = useState("");
    const [searchUserInput, setSearchUserInput] = useState("");
    
    const currentUser = localStorage.getItem('username')

    const handleSearchLsChange = (e) => {
        e.preventDefault();
        setSearchLsInput(e.target.value);
    };

    const handleKeyDown = (e) => {
        if (e.keyCode === 13) {
          const getSearchLsResults = async () => {
            const res = await axios.get(
              `${process.env.REACT_APP_BACKEND_BASE_URL}learningspace?query=${searchLsInput}`
            );
            setSearchLsResults(res.data.learning_spaces);
          };
          getSearchLsResults();
        }
      };

    const handleSearchUserChange = (e) => {
        e.preventDefault();
        setSearchUserInput(e.target.value);
    }

    const toggle = () => {
        setSearchDecision(!searchDecision);
      };

    useEffect(() => {
        const getSearchUserResults = async () => {
            const res = await axios.get(`${process.env.REACT_APP_BACKEND_BASE_URL}user/search/${searchUserInput}`)
            setSearchUserResults(res.data.users)
        }
        getSearchUserResults()
    }, [searchUserInput])

    console.log(searchLsResults)
    console.log(searchUserResults)

    return <nav className="nav" data-testid="navbar">
        <a href="/home"><img src={logo} alt="Learnify Logo Navbar" height={60} /></a>
        <ul>
                <div className="search-decider-container" onClick={toggle}>
                    <FontAwesomeIcon icon={solid('arrows-rotate')} size="2x" color="#1746A2"/>
                </div>
                {!searchDecision && <div className="ls-search">
                    <input
                        className='search-input-field'
                        type="text"
                        placeholder="Search learning spaces"
                        size={30}
                        onChange={handleSearchLsChange}
                        onKeyDown={handleKeyDown}
                        value={searchLsInput}
                    />

                    <div className="search-results-container">
                        {searchLsResults.map(result => (
                            <ul>
                                <li className='search-result-item'><a href={`/learningspace/${result.id}`}>{result.title}</a></li>
                            </ul>
                        ))}
                    </div>
                </div>}
                {searchDecision && <div className="user-search">
                    <input className='search-input-field' type="text" placeholder="Search users"  size={30} onChange={handleSearchUserChange} value={searchUserInput}/>

                    <div className="search-results-container">
                        {searchUserResults.map(result => (
                            <ul>
                                <li className='search-result-item'><a href={`/profile/${result}`}>{result}</a></li>
                            </ul>
                        ))}
                    </div>
                </div>}
            
            <li>
                <a href="/notifications" className='navBarText'><img src={bell} alt="Notifications Icon" height={20} /></a>
            </li>
            <li>
                <a href="/home" className='navBarText'>Home</a>
            </li>
            <li>
                <a href="/categories" className='navBarText'>Categories</a>
            </li>
            <li>
                <a href="/about" className='navBarText'>About</a>
            </li>
            <li>
                <a href="/contact" className='navBarText'>Contact</a>
            </li>
            <li>
                <a href={`/profile/${currentUser}`} className='navBarText'>Profile</a>
            </li>
        </ul>
    </nav>

}