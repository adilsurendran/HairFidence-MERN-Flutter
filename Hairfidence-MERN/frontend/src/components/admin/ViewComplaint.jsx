import React from 'react'
import Table from 'react-bootstrap/Table';

function ViewComplaint() {
  return (
    <div> <Table striped bordered hover>
      <thead>
        <tr>
          <th>Complaint</th>
          <th>Name</th>
          <th>Date</th>
          <th>Reply</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>

        <tr>
          <td></td>
          <td colSpan={2}></td>
          <td></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
      </tbody>
    </Table></div>
  )
}

export default ViewComplaint