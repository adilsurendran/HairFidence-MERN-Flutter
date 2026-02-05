// import { useEffect, useState } from "react";
// import Table from "react-bootstrap/Table";
// import Button from "react-bootstrap/Button";
// import NgoSidebar from "./NgoSidebar";
// import api from "../apiInterceptor";
// import "./ngoHairRequests.css";

// function NgoHairRequests() {
//   const ngoId = localStorage.getItem("profileId");
//   const [requests, setRequests] = useState([]);

//   const fetchRequests = async () => {
//     const res = await api.get(`/hair-posts/ngo/${ngoId}`);
//     console.log(res);
    
//     setRequests(res.data);
//   };

//   useEffect(() => {
//     fetchRequests();
//   }, []);

//   const approveRequest = async (id) => {
//     if (!window.confirm("Approve this request?")) return;
//     await api.put(`/hair-posts/approve/${id}`);
//     fetchRequests();
//   };

//   const rejectRequest = async (id) => {
//     if (!window.confirm("Reject this request?")) return;
//     await api.put(`/hair-posts/reject/${id}`);
//     fetchRequests();
//   };

//   const statusBadge = (status) => {
//     const colors = {
//       pending: "#ffc107",
//       approved: "#28a745",
//       rejected: "#dc3545",
//       soldout: "#6c757d",
//     };
//     return (
//       <span style={{ color: colors[status], fontWeight: "600" }}>
//         {status.toUpperCase()}
//       </span>
//     );
//   };

//   return (
//     <div className="ngo-req-wrapper">
//       <NgoSidebar />

//       <div className="ngo-req-main">
//         <h1>Hair Requests</h1>

//         <div className="ngo-req-card">
//           <Table responsive hover variant="dark" className="ngo-req-table">
//             <thead>
//               <tr>
//                 <th>Patient</th>
//                 <th>Hair Details</th>
//                 <th>Location</th>
//                 <th>Quantity Left</th>
//                 <th>Status</th>
//                 <th>Action</th>
//               </tr>
//             </thead>

//             <tbody>
//               {requests.length === 0 && (
//                 <tr>
//                   <td colSpan="6" style={{ textAlign: "center", color: "#777" }}>
//                     No requests found
//                   </td>
//                 </tr>
//               )}

//               {requests.map((r) => (
//                 <tr key={r._id}>
//                   <td>
//                     {r.profileId.name}
//                     <br />
//                     <small>{r.profileId.phone}</small>
//                   </td>

//                   <td>
//                     {r.postId.hairType} | {r.postId.hairLength}cm
//                     <br />
//                     <small>{r.postId.hairColor}</small>
//                   </td>

//                   <td>{r.postId.location}</td>

//                   <td>{r.postId.quantity}</td>

//                   <td>{statusBadge(r.status)}</td>

//                   <td>
//                     {r.status === "pending" && r.postId.quantity > 0 && (
//                       <>
//                         <Button
//                           size="sm"
//                           onClick={() => approveRequest(r._id)}
//                         >
//                           Approve
//                         </Button>{" "}
//                         <Button
//                           size="sm"
//                           variant="danger"
//                           onClick={() => rejectRequest(r._id)}
//                         >
//                           Reject
//                         </Button>
//                       </>
//                     )}

//                     {r.status !== "pending" && (
//                       <span style={{ color: "#777" }}>—</span>
//                     )}
//                   </td>
//                 </tr>
//               ))}
//             </tbody>
//           </Table>
//         </div>
//       </div>
//     </div>
//   );
// }

// export default NgoHairRequests;


import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import Button from "react-bootstrap/Button";
import Modal from "react-bootstrap/Modal";
import NgoSidebar from "./NgoSidebar";
import api from "../apiInterceptor";
import "./ngoHairRequests.css";

function NgoHairRequests() {
  const ngoId = localStorage.getItem("profileId");

  const [requests, setRequests] = useState([]);
  const [showReports, setShowReports] = useState(false);
  const [selectedReports, setSelectedReports] = useState([]);

  /* =========================
     FETCH REQUESTS
  ========================== */
  const fetchRequests = async () => {
    const res = await api.get(`/hair-posts/ngo/${ngoId}`);
    setRequests(res.data);
  };

  useEffect(() => {
    fetchRequests();
  }, []);

  /* =========================
     APPROVE / REJECT
  ========================== */
  const approveRequest = async (id) => {
    if (!window.confirm("Approve this request?")) return;
    await api.put(`/hair-posts/approve/${id}`);
    fetchRequests();
  };

  const rejectRequest = async (id) => {
    if (!window.confirm("Reject this request?")) return;
    await api.put(`/hair-posts/reject/${id}`);
    fetchRequests();
  };

  /* =========================
     STATUS BADGE
  ========================== */
  const statusBadge = (status) => {
    const colors = {
      pending: "#ffc107",
      approved: "#28a745",
      rejected: "#dc3545",
      soldout: "#6c757d",
    };
    return (
      <span style={{ color: colors[status], fontWeight: 600 }}>
        {status.toUpperCase()}
      </span>
    );
  };

  /* =========================
     OPEN REPORT MODAL
  ========================== */
  const openReports = (reports) => {
    setSelectedReports(reports || []);
    setShowReports(true);
  };

  return (
    <div className="ngo-req-wrapper">
      <NgoSidebar />

      <div className="ngo-req-main">
        <h1>Hair Requests</h1>

        <div className="ngo-req-card">
          <Table responsive hover variant="dark" className="ngo-req-table">
            <thead>
              <tr>
                <th>Patient</th>
                <th>Hair Details</th>
                <th>Location</th>
                <th>Qty Left</th>
                <th>Status</th>
                <th>Reports</th>
                <th>Action</th>
              </tr>
            </thead>

            <tbody>
              {requests.length === 0 && (
                <tr>
                  <td colSpan="7" style={{ textAlign: "center", color: "#777" }}>
                    No requests found
                  </td>
                </tr>
              )}

              {requests.map((r) => (
                <tr key={r._id}>
                  <td>
                    {r.profileId.name}
                    <br />
                    <small>{r.profileId.phone}</small>
                  </td>

                  <td>
                    {r.postId.hairType} | {r.postId.hairLength} cm
                    <br />
                    <small>{r.postId.hairColor}</small>
                  </td>

                  <td>{r.postId.location}</td>
                  <td>{r.postId.quantity}</td>
                  <td>{statusBadge(r.status)}</td>

                  {/* ================= REPORT BUTTON ================= */}
                  <td>
                    {r.patientReports?.length > 0 ? (
                      <Button
                        size="sm"
                        onClick={() => openReports(r.patientReports)}
                      >
                        View Reports
                      </Button>
                    ) : (
                      <span style={{ color: "#777" }}>No Reports</span>
                    )}
                  </td>

                  {/* ================= ACTION ================= */}
                  <td>
                    {r.status === "pending" && r.postId.quantity > 0 ? (
                      <>
                        <Button
                          size="sm"
                          onClick={() => approveRequest(r._id)}
                        >
                          Approve
                        </Button>{" "}
                        <Button
                          size="sm"
                          variant="danger"
                          onClick={() => rejectRequest(r._id)}
                        >
                          Reject
                        </Button>
                      </>
                    ) : (
                      <span style={{ color: "#777" }}>—</span>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>
        </div>
      </div>

      {/* =========================
         REPORT MODAL
      ========================== */}
      <Modal
        show={showReports}
        onHide={() => setShowReports(false)}
        size="lg"
        centered
      >
        <Modal.Header closeButton>
          <Modal.Title style={{ color: "#ffc107" }}>
            Patient Reports
          </Modal.Title>
        </Modal.Header>

        <Modal.Body
          style={{
            maxHeight: "70vh",
            overflowY: "auto",
            background: "#000",
          }}
        >
          {selectedReports.length === 0 && (
            <p style={{ color: "#777" }}>No reports available</p>
          )}

          {selectedReports.map((r) => (
            <div
              key={r._id}
              style={{
                border: "1px solid #333",
                borderRadius: 12,
                padding: 12,
                marginBottom: 14,
              }}
            >
              <p style={{ color: "#ffc107", fontWeight: 600 }}>
                {r.title}
              </p>
              <p style={{ color: "#ccc" }}>
                {r.reportType} • {r.hospital}
              </p>
              <p style={{ color: "#777" }}>
                Date: {r.reportDate}
              </p>

              <img
                src={`http://localhost:8000/api/uploads/${r.image}`}
                alt="report"
                style={{
                  width: "100%",
                  borderRadius: 10,
                  border: "1px solid #222",
                }}
              />
            </div>
          ))}
        </Modal.Body>
      </Modal>
    </div>
  );
}

export default NgoHairRequests;
