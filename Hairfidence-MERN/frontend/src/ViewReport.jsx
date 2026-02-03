import React from 'react'
import Table from 'react-bootstrap/Table'
import NgoSidebar from './components/ngo/NgoSidebar'
import './components/ngo/viewReport.css'

function ViewReport() {
  return (
    <div className="report-wrapper">
      <NgoSidebar />

      <div className="report-main">
        <h1 className="report-title">View Reports</h1>

        <div className="report-card">
          <Table responsive hover variant="dark" className="report-table">
            <thead>
              <tr>
                <th style={{ color: '#ffc107' }}>Report Type</th>
                <th style={{ color: '#ffc107' }}>Date</th>
                <th style={{ color: '#ffc107' }}>Description</th>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td>Monthly Donation</td>
                <td>01-02-2026</td>
                <td>Summary of monthly Hair donation activities</td>
              </tr>
            </tbody>
          </Table>
        </div>
      </div>
    </div>
  )
}

export default ViewReport

