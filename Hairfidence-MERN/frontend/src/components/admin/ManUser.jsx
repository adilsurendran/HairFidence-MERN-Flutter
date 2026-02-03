import React from 'react'
import Table from 'react-bootstrap/Table';

function ManUser() {
  return (
    <div>
        <Table striped bordered hover>
      <thead>
        <tr>
       
          <th>Name</th>
          <th>Age</th>
          <th>Gender</th>
          <th>Phone</th>
          <th>Email</th>
          <th>Place</th>
          <th>District</th>

        </tr>
      </thead>
      <tbody>
        <tr>
          <td></td>
          <td></td>
          <td></td>
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
          <td></td>
          <td></td>
          <td></td>
        </tr>
        
        
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>  
          <td></td>
          <td></td>
          <td colSpan={2}></td>
          
        </tr>
      </tbody>
    </Table>
    </div>
  )
}

export default ManUser