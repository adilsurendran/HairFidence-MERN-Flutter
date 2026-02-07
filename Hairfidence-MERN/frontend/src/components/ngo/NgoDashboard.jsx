import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import NgoSidebar from "./NgoSidebar";
import "./ngoDashboard.css";
import api from "../apiInterceptor";

function NgoDashboard() {
  const navigate = useNavigate();
  const ngoId = localStorage.getItem("profileId");

  const [counts, setCounts] = useState({
    campaigns: 0,
    notifications: 0,
    requests: 0,
    donorPosts: 0,
  });

  const [loading, setLoading] = useState(true);

  const loadDashboard = async () => {
    try {
      const res = await api.get(`/ngos/dashboard/${ngoId}`);
      setCounts(res.data);
    } catch (err) {
      console.error("Dashboard load error", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadDashboard();
  }, []);

  return (
    <div className="ngo-container">
      <NgoSidebar />

      <div className="ngo-content">
        {/* Header */}
        <div className="ngo-header">
          <h1 className="ngo-title">NGO Dashboard</h1>

          <div
            className="ngo-notification"
            onClick={() => navigate("/ViewNotification")}
          >
            🔔
            {counts.notifications > 0 && (
              <span className="notify-badge">{counts.notifications}</span>
            )}
          </div>
        </div>

        {loading ? (
          <div className="dashboard-center">
            <p className="loading-text">Loading dashboard...</p>
          </div>
        ) : (
          <>
            {/* ======================
                STATS (NO NAVIGATION)
            ======================= */}
            <h3 className="section-title">Overview</h3>

            <div className="ngo-stats-grid">
              <div className="ngo-stat-box">
                <h2>{counts.campaigns}</h2>
                <p>Campaigns</p>
              </div>

              <div className="ngo-stat-box">
                <h2>{counts.donorPosts}</h2>
                <p>Donor Posts</p>
              </div>

              <div className="ngo-stat-box">
                <h2>{counts.requests}</h2>
                <p>Requests</p>
              </div>

              <div className="ngo-stat-box">
                <h2>{counts.notifications}</h2>
                <p>Notifications</p>
              </div>
            </div>

            {/* ======================
                NAVIGATION CARDS
            ======================= */}
            <h3 className="section-title">Quick Actions</h3>

            <div className="ngo-nav-grid">
              <div
                className="ngo-nav-card"
                onClick={() => navigate("/ngo/view-campaigns")}
              >
                Campaign Management
              </div>

              <div
                className="ngo-nav-card"
                onClick={() => navigate("/ngo/donorpost")}
              >
                Donor Posts
              </div>

              <div
                className="ngo-nav-card"
                onClick={() => navigate("/ViewReq")}
              >
                View Requests
              </div>

              <div
                className="ngo-nav-card"
                onClick={() => navigate("/ViewNotification")}
              >
                Notifications
              </div>

              <div
                className="ngo-nav-card"
                onClick={() => navigate("/AddUpdates")}
              >
                Add Updates
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

export default NgoDashboard;
