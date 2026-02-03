

import React from 'react'
import Table from 'react-bootstrap/Table'
import Button from 'react-bootstrap/Button'
import NgoSidebar from './NgoSidebar'
import './viewAppointments.css'

function ViewAppointments() {
  return (
    <div className="appointment-wrapper">
      <NgoSidebar />

      <div className="appointment-main">
        <h1 className="appointment-title">View Appointments</h1>

        <div className="appointment-card">
          <Table responsive hover variant="dark" className="appointment-table">
            <thead>
              <tr>
                <th style={{ color: '#ffc107' }}>Patient Name</th>
                <th style={{ color: '#ffc107' }}>Blood Group</th>
                <th style={{ color: '#ffc107' }}>Date</th>
                <th style={{ color: '#ffc107' }}>Status</th>
                <th style={{ color: '#ffc107' }}>Action</th>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td>Sample</td>
                <td>O+</td>
                <td>12-02-2026</td>
                <td>
                  <span className="appointment-status pending">Pending</span>
                </td>
                <td className="appointment-actions">
                  <button className="btn-approve">Approve</button>
                  <button className="btn-reject">Reject</button>
                </td>
              </tr>
            </tbody>
          </Table>
        </div>
      </div>
    </div>
  )
}

export default ViewAppointments
