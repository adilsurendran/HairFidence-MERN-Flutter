// import React from 'react'
// import Table from 'react-bootstrap/Table'
// import AdminSidebar from './AdminSidebar'
// import './viewPatient.css'

// function Viewpatient() {
//   return (
//     <div className="patient-wrapper">
//       <AdminSidebar />

//       <div className="patient-main">
//         <h1 className="patient-title">Manage Patients</h1>

//         <div className="patient-card">
//           <Table responsive hover variant='dark'  className="patient-table">
//             <thead>
              
//               <tr>
//                 <th style={{color:"#ffc107"}}>Name</th>
//                 <th style={{color:"#ffc107"}} >Age</th>
//                 <th style={{color:"#ffc107"}}>Gender</th>
//                 <th style={{color:"#ffc107"}}>Phone</th>
//                 <th style={{color:"#ffc107"}}>Email</th>
//                 <th style={{color:"#ffc107"}}>Place</th>
//                 <th style={{color:"#ffc107"}}>District</th>
//                 <th style={{color:"#ffc107"}}>Action</th>
//               </tr>
//             </thead>

//             <tbody>
//               <tr>
//                 <td>John Doe</td>
//                 <td>35</td>
//                 <td>Male</td>
//                 <td>9876543210</td>
//                 <td>john@gmail.com</td>
//                 <td>Kochi</td>
//                 <td>Ernakulam</td>
//                 <td className="patient-actions">
//                   <button className="btn-block">Block</button>
//                   <button className="btn-unblock">Unblock</button>
//                 </td>
//               </tr>
//             </tbody>
//           </Table>
//         </div>
//       </div>
//     </div>
//   )
// }

// export default Viewpatient

import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import AdminSidebar from "./AdminSidebar";
import api from "../apiInterceptor";
import "./viewPatient.css";

function ViewPatient() {
  const [patients, setPatients] = useState([]);

  /* ===============================
     FETCH PATIENTS
  =============================== */
  const fetchPatients = async () => {
    const res = await api.get("/admin/patients");
    setPatients(res.data);
  };

  useEffect(() => {
    fetchPatients();
  }, []);

  /* ===============================
     BLOCK / UNBLOCK
  =============================== */
  const updateStatus = async (patientId, status) => {
    await api.put(`/admin/patients/status/${patientId}`, {
      status,
    });
    fetchPatients();
  };

  const calculateAge = (dob) => {
    const birth = new Date(dob);
    const today = new Date();
    let age = today.getFullYear() - birth.getFullYear();
    const m = today.getMonth() - birth.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birth.getDate())) {
      age--;
    }
    return age;
  };

  return (
    <div className="patient-wrapper">
      <AdminSidebar />

      <div className="patient-main">
        <h1 className="patient-title">Manage Patients</h1>

        <div className="patient-card">
          <Table responsive hover variant="dark" className="patient-table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Place</th>
                <th>District</th>
                <th>Action</th>
              </tr>
            </thead>

            <tbody>
              {patients.length === 0 && (
                <tr>
                  <td colSpan="8" style={{ textAlign: "center", color: "#777" }}>
                    No patients found
                  </td>
                </tr>
              )}

              {patients.map((p) => (
                <tr key={p._id}>
                  <td>{p.name}</td>
                  <td>{calculateAge(p.dob)}</td>
                  <td>{p.gender}</td>
                  <td>{p.phone}</td>
                  <td>{p.email}</td>
                  <td>{p.address}</td>
                  <td>{p.district}</td>
                  <td className="patient-actions">
                    {p.loginId?.verified ? (
                      <button
                        className="btn-block"
                        onClick={() => updateStatus(p._id, false)}
                      >
                        Block
                      </button>
                    ) : (
                      <button
                        className="btn-unblock"
                        onClick={() => updateStatus(p._id, true)}
                      >
                        Unblock
                      </button>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>
        </div>
      </div>
    </div>
  );
}

export default ViewPatient;
