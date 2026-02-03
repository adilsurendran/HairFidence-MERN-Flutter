// import React from 'react'
// import Table from 'react-bootstrap/Table'
// import AdminSidebar from './AdminSidebar'
// import './report.css'

// function Report() {
//   return (
//     <div className="report-wrapper">
//       <AdminSidebar />

//       <div className="report-main">
//         <h1 className="report-title">Reports</h1>

//         <div className="report-card">
//           <Table responsive hover className="report-table">
//             <thead>
//               <tr>
//                 <th>DESCRIPTION</th>
//                 <th>DATE</th>
//               </tr>
//             </thead>

//             <tbody>
//               <tr>
//                 <td>Monthly NGO activity summary</td>
//                 <td>15 Jan 2026</td>
//               </tr>

//               <tr>
//                 <td>Donor contribution report</td>
//                 <td>10 Jan 2026</td>
//               </tr>

//               <tr>
//                 <td>Patient assistance overview</td>
//                 <td>05 Jan 2026</td>
//               </tr>
//             </tbody>
//           </Table>
//         </div>
//       </div>
//     </div>
//   )
// }

// export default Report


import React from 'react'
import Table from 'react-bootstrap/Table'
import AdminSidebar from './AdminSidebar'
import './report.css'

function Report() {
  return (
    <div className="report-wrapper">
      <AdminSidebar />

      <div className="report-main">
        <h1 className="report-title">Reports</h1>

        <div className="report-card">
          <Table responsive variant='dark'className="report-table">
            <thead>
              <tr >
                <th style={{color:"#ffc107"}}>Description</th>
                <th style={{color:"#ffc107"}}>Date</th>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td>Monthly NGO activity summary</td>
                <td>15 Jan 2026</td>
              </tr>
              <tr>
                <td>Donor contribution report</td>
                <td>10 Jan 2026</td>
              </tr>
              <tr>
                <td>Patient assistance overview</td>
                <td>05 Jan 2026</td>
              </tr>
            </tbody>
          </Table>
        </div>
      </div>
    </div>
  )
}

export default Report
