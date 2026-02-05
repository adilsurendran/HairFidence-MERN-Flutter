// import React from 'react'
// import Table from 'react-bootstrap/Table'
// import AdminSidebar from './AdminSidebar'
// import './viewFeedback.css'

// function ViewFeedback() {
//   return (
//     <div className="feedback-wrapper">
//       <AdminSidebar />

//       <div className="feedback-main">
//         <h1 className="feedback-title">User Feedback</h1>

//         <div className="feedback-card">
//           <Table responsive hover variant='dark' className="feedback-table">
//             <thead>
//               <tr>
//                 <th style={{color:"#ffc107"}}>Message</th>
//                 <th style={{color:"#ffc107"}}>Rating</th>
//                 <th style={{color:"#ffc107"}}>Date</th>
//               </tr>
//             </thead>

//             <tbody>
//               <tr>
//                 <td>Very helpful service</td>
//                 <td>⭐⭐⭐⭐⭐</td>
//                 <td>12-01-2026</td>
//               </tr>
//             </tbody>
//           </Table>
//         </div>
//       </div>
//     </div>
//   )
// }

// export default ViewFeedback


import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import AdminSidebar from "./AdminSidebar";
import api from "../apiInterceptor";
import "./viewFeedback.css";

function ViewFeedback() {
  const [feedbacks, setFeedbacks] = useState([]);

  /* ===============================
     FETCH FEEDBACKS
  =============================== */
  const fetchFeedbacks = async () => {
    try {
      const res = await api.get("/feedback");
      setFeedbacks(res.data);
    } catch (error) {
      alert("Failed to fetch feedback");
    }
  };

  useEffect(() => {
    fetchFeedbacks();
  }, []);

  return (
    <div className="feedback-wrapper">
      <AdminSidebar />

      <div className="feedback-main">
        <h1 className="feedback-title">User Feedback</h1>

        <div className="feedback-card">
          <Table
            responsive
            hover
            variant="dark"
            className="feedback-table"
          >
            <thead>
              <tr>
                <th>MESSAGE</th>
                <th>USER TYPE</th>
                <th>DATE</th>
              </tr>
            </thead>

            <tbody>
              {feedbacks.length === 0 && (
                <tr>
                  <td
                    colSpan="3"
                    style={{ textAlign: "center", color: "#777" }}
                  >
                    No feedback available
                  </td>
                </tr>
              )}

              {feedbacks.map((f) => (
                <tr key={f._id}>
                  <td>{f.message}</td>
                  <td>
                    <span
                      className={`role-badge role-${f.senderRole}`}
                    >
                      {f.senderRole.toUpperCase()}
                    </span>
                  </td>
                  <td>
                    {new Date(f.createdAt).toLocaleDateString()}
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

export default ViewFeedback;
