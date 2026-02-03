import React from "react";
import { NavLink, useNavigate } from "react-router-dom";
import "./sidebar.css";

function AdminSidebar() {
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.clear();
    navigate("/");
  };

  return (
    <div className="sidebar">
      <h2 className="sidebar-title">ADMIN</h2>

      <NavLink to="/dashboardAdmin" className="sidebar-link">
        Dashboard
      </NavLink>
      <NavLink to="/ViewNgo" className="sidebar-link">
        Manage NGO
      </NavLink>
      <NavLink to="/viewdonor" className="sidebar-link">
        View Donor
      </NavLink>
      <NavLink to="/viewpatient" className="sidebar-link">
        View Patient
      </NavLink>
      <NavLink to="/ViewFeedback" className="sidebar-link">
        View Feedback
      </NavLink>
      <NavLink to="/SendNotification" className="sidebar-link">
        Send Notification
      </NavLink>
      <NavLink to="/Report" className="sidebar-link">
        Generate Report
      </NavLink>

      {/* LOGOUT */}
      <button className="sidebar-link logout-btn" onClick={handleLogout}>
        Logout
      </button>
    </div>
  );
}

export default AdminSidebar;
