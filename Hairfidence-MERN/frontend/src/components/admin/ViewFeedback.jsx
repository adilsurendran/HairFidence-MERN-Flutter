import React from 'react'
import Table from 'react-bootstrap/Table'
import AdminSidebar from './AdminSidebar'
import './viewFeedback.css'

function ViewFeedback() {
  return (
    <div className="feedback-wrapper">
      <AdminSidebar />

      <div className="feedback-main">
        <h1 className="feedback-title">User Feedback</h1>

        <div className="feedback-card">
          <Table responsive hover variant='dark' className="feedback-table">
            <thead>
              <tr>
                <th style={{color:"#ffc107"}}>Message</th>
                <th style={{color:"#ffc107"}}>Rating</th>
                <th style={{color:"#ffc107"}}>Date</th>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td>Very helpful service</td>
                <td>⭐⭐⭐⭐⭐</td>
                <td>12-01-2026</td>
              </tr>
            </tbody>
          </Table>
        </div>
      </div>
    </div>
  )
}

export default ViewFeedback
