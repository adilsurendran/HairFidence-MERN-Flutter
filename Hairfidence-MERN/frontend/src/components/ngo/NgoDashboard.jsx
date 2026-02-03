import React from "react";
import { useNavigate } from "react-router-dom";
import NgoSidebar from "./NgoSidebar";
import "./ngoDashboard.css";

function NgoDashboard() {
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.clear();
    navigate("/");
  };

  return (
    <div className="ngo-container">
      <NgoSidebar />

      <div className="ngo-content">
        <div style={{ display: "flex", justifyContent: "space-between" }}>
          <h1 className="ngo-title">NGO Dashboard</h1>
          <button className="logout-btn" onClick={handleLogout}>
            Logout
          </button>
        </div>

        <div className="ngo-card-grid">
          <div
            className="ngo-stat-card"
            onClick={() => navigate("/ngo/view-appointment")}
          >
            <h2>24</h2>
            <p>Appointments</p>
          </div>

          <div
            className="ngo-stat-card"
            onClick={() => navigate("/ngo/campaign-management")}
          >
            <h2>6</h2>
            <p>Campaigns</p>
          </div>

          <div
            className="ngo-stat-card"
            onClick={() => navigate("/ngo/view-report")}
          >
            <h2>12</h2>
            <p>Reports</p>
          </div>

          <div
            className="ngo-stat-card"
            onClick={() => navigate("/ngo/view-notification")}
          >
            <h2>8</h2>
            <p>Notifications</p>
          </div>

          <div
            className="ngo-stat-card"
            onClick={() => navigate("/ngo/add-update")}
          >
            <h2>+</h2>
            <p>Add Updates</p>
          </div>
        </div>
      </div>
    </div>
  );
}

export default NgoDashboard;
