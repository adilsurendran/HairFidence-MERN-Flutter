import React from 'react'
import Table from 'react-bootstrap/Table'
import AdminSidebar from './AdminSidebar'
import './viewPatient.css'

function Viewpatient() {
  return (
    <div className="patient-wrapper">
      <AdminSidebar />

      <div className="patient-main">
        <h1 className="patient-title">Manage Patients</h1>

        <div className="patient-card">
          <Table responsive hover variant='dark'  className="patient-table">
            <thead>
              
              <tr>
                <th style={{color:"#ffc107"}}>Name</th>
                <th style={{color:"#ffc107"}} >Age</th>
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
                <td>John Doe</td>
                <td>35</td>
                <td>Male</td>
                <td>9876543210</td>
                <td>john@gmail.com</td>
                <td>Kochi</td>
                <td>Ernakulam</td>
                <td className="patient-actions">
                  <button className="btn-block">Block</button>
                  <button className="btn-unblock">Unblock</button>
                </td>
              </tr>
            </tbody>
          </Table>
        </div>
      </div>
    </div>
  )
}

export default Viewpatient
