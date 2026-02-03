import React from 'react'
import Table from 'react-bootstrap/Table'
import AdminSidebar from './AdminSidebar'
import './viewDonor.css'

function ViewDonor() {
  return (
    <div className="donor-wrapper">
      <AdminSidebar />

      <div className="donor-main">
        <h1 className="donor-title">Manage Donors</h1>

        <div className="donor-card">
          <Table responsive hover variant='dark' className="donor-table">
            <thead>
              <tr>
                <th style={{color:"#ffc107"}}>Name</th>
                <th style={{color:"#ffc107"}}>Age</th>
                <th style={{color:"#ffc107"}}>Gender</th>
                <th style={{color:"#ffc107"}}>Phone</th>
                <th style={{color:"#ffc107"}}>Email</th>
                <th style={{color:"#ffc107"}}>Place</th>
                <th style={{color:"#ffc107"}}>District</th>
                <th style={{color:"#ffc107"}}>Action</th>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td>Rahul Kumar</td>
                <td>29</td>
                <td>Male</td>
                <td>9876543210</td>
                <td>rahul@gmail.com</td>
                <td>Kochi</td>
                <td>Ernakulam</td>
                <td className="donor-actions">
                  <button className="donor-block">Block</button>
                  <button className="donor-unblock">Unblock</button>
                </td>
              </tr>
            </tbody>
          </Table>
        </div>
      </div>
    </div>
  )
}

export default ViewDonor
