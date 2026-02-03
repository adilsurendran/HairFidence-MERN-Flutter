import React from 'react'
import { useNavigate } from 'react-router-dom'
import AdminSidebar from './AdminSidebar'
import './admin.css'

function AdminDashboard() {
  const navigate = useNavigate()

  return (
    <div className="admin-container">
      <AdminSidebar />

      <div className="admin-content">
        <h1 className="dashboard-title">Dashboard</h1>

        <div className="card-grid">
          <div className="stat-card" onClick={() => navigate('/admin/manage-ngo')}>
            <h2>12</h2>
            <p>NGOs</p>
          </div>

          <div className="stat-card" onClick={() => navigate('/admin/view-donor')}>
            <h2>340</h2>
            <p>Donors</p>
          </div>

          <div className="stat-card" onClick={() => navigate('/admin/view-patient')}>
            <h2>98</h2>
            <p>Patients</p>
          </div>

          <div className="stat-card" onClick={() => navigate('/admin/view-feedback')}>
            <h2>27</h2>
            <p>Feedbacks</p>
          </div>
        </div>
      </div>
    </div>
  )
}

export default AdminDashboard
