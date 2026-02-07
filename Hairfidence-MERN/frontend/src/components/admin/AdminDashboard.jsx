// import React from 'react'
// import { useNavigate } from 'react-router-dom'
// import AdminSidebar from './AdminSidebar'
// import './admin.css'

// function AdminDashboard() {
//   const navigate = useNavigate()

//   return (
//     <div className="admin-container">
//       <AdminSidebar />

//       <div className="admin-content">
//         <h1 className="dashboard-title">Dashboard</h1>

//         <div className="card-grid">
//           <div className="stat-card" onClick={() => navigate('/admin/manage-ngo')}>
//             <h2>12</h2>
//             <p>NGOs</p>
//           </div>

//           <div className="stat-card" onClick={() => navigate('/admin/view-donor')}>
//             <h2>340</h2>
//             <p>Donors</p>
//           </div>

//           <div className="stat-card" onClick={() => navigate('/admin/view-patient')}>
//             <h2>98</h2>
//             <p>Patients</p>
//           </div>

//           <div className="stat-card" onClick={() => navigate('/admin/view-feedback')}>
//             <h2>27</h2>
//             <p>Feedbacks</p>
//           </div>
//         </div>
//       </div>
//     </div>
//   )
// }

// export default AdminDashboard


import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import AdminSidebar from "./AdminSidebar";
import api from "../apiInterceptor";
import "./admin.css";

function AdminDashboard() {
  const navigate = useNavigate();

  const [counts, setCounts] = useState({
    ngos: 0,
    donors: 0,
    patients: 0,
    pendingComplaints: 0,
  });

  const [loading, setLoading] = useState(true);

  const loadDashboard = async () => {
    try {
      const res = await api.get("/admin/dashboard");
      setCounts(res.data);
    } catch (err) {
      console.error("Admin dashboard load error", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadDashboard();
  }, []);

  return (
    <div className="admin-container">
      <AdminSidebar />

      <div className="admin-content">
        <h1 className="dashboard-title">Admin Dashboard</h1>

        {loading ? (
          <div className="dashboard-center">
            <p className="loading-text">Loading dashboard...</p>
          </div>
        ) : (
          <>
            {/* =====================
                STATS (NO NAVIGATION)
            ====================== */}
            <h3 className="section-title">Overview</h3>

            <div className="admin-stats-grid">
              <div className="admin-stat-box">
                <h2>{counts.ngos}</h2>
                <p>NGOs</p>
              </div>

              <div className="admin-stat-box">
                <h2>{counts.donors}</h2>
                <p>Donors</p>
              </div>

              <div className="admin-stat-box">
                <h2>{counts.patients}</h2>
                <p>Patients</p>
              </div>

              <div className="admin-stat-box">
                <h2>{counts.pendingComplaints}</h2>
                <p>Pending Complaints</p>
              </div>
            </div>

            {/* =====================
                NAVIGATION CARDS
            ====================== */}
            <h3 className="section-title">Quick Actions</h3>

            <div className="admin-nav-grid">
              <div
                className="admin-nav-card"
                onClick={() => navigate("/ViewNgo")}
              >
                Manage NGOs
              </div>

              <div
                className="admin-nav-card"
                onClick={() => navigate("/viewdonor")}
              >
                View Donors
              </div>

              <div
                className="admin-nav-card"
                onClick={() => navigate("/viewpatient")}
              >
                View Patients
              </div>

              <div
                className="admin-nav-card"
                onClick={() => navigate("/managecomplaints")}
              >
                Complaints
              </div>

              <div
                className="admin-nav-card"
                onClick={() => navigate("/adminviewpoststatus")}
              >
                Post Status Report
              </div>

              <div
                className="admin-nav-card"
                onClick={() => navigate("/SendNotification")}
              >
                Send Notification
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

export default AdminDashboard;
