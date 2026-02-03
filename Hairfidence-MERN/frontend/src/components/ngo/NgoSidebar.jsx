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
      <NavLink to="/ViewAppointments" className="ngo-link">
        View Appointments
      </NavLink>
      <NavLink to="/CampaignManagement" className="ngo-link">
        Add Campaign
      </NavLink>
      <NavLink to="/ngo/view-campaigns" className="ngo-link">
        Campaign Management
      </NavLink>
      <NavLink to="/ViewReport" className="ngo-link">
        View Reports
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
      <button className="logout-btn" onClick={handleLogout}>
            Logout
      </button>
    </div>
  )
}

export default NgoSidebar
