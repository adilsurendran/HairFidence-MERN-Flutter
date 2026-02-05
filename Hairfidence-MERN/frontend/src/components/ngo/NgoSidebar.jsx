import React from 'react'
import { NavLink, useNavigate } from 'react-router-dom'
import './ngoSidebar.css'

function NgoSidebar() {
    const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.clear();
    navigate("/");
  };

  return (
    <div className="ngo-sidebar">
      <h2 className="ngo-sidebar-title">NGO PANEL</h2>

      <NavLink to="/NgoDashboard" className="ngo-link">
        Dashboard
      </NavLink>
      <NavLink to="/ngo/donorpost" className="ngo-link">
        Donor posts
      </NavLink>
      <NavLink to="/ViewPatientPost" className="ngo-link">
        View Patients Post
      </NavLink>
      <NavLink to="/Viewrequeststatus" className="ngo-link">
        My Request Status
      </NavLink>
      <NavLink to="/CampaignManagement" className="ngo-link">
        Add Campaign
      </NavLink>
      <NavLink to="/ngo/view-campaigns" className="ngo-link">
        Campaign Management
      </NavLink>
      <NavLink to="/ViewNotification" className="ngo-link">
        Notifications
      </NavLink>
      <NavLink to="/AddPost" className="ngo-link">
        Add post
      </NavLink>
      <NavLink to="/managePost" className="ngo-link">
        Manage post
      </NavLink>
      <NavLink to="/ViewReq" className="ngo-link">
        View Request
      </NavLink>
      <NavLink to="/ngo/complaits" className="ngo-link">
        Complaints
      </NavLink>
      <button className="logout-btn" onClick={handleLogout}>
            Logout
      </button>
    </div>
  )
}

export default NgoSidebar
