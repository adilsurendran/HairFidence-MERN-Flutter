// import React, { useEffect, useState } from "react";
// import Table from "react-bootstrap/Table";
// import Button from "react-bootstrap/Button";
// import Modal from "react-bootstrap/Modal";
// import Form from "react-bootstrap/Form";
// import NgoSidebar from "./NgoSidebar";
// import "./viewCampaigns.css"; // REUSE SAME CSS
// import api from "../apiInterceptor";

// function ViewPatientPosts() {
//   const ngoId = localStorage.getItem("profileId");

//   const [posts, setPosts] = useState([]);
//   const [show, setShow] = useState(false);
//   const [selectedPost, setSelectedPost] = useState(null);
//   const [message, setMessage] = useState("");

//   useEffect(() => {
//     fetchPosts();
//   }, []);

//   const fetchPosts = async () => {
//     try {
//           const res = await api.get("/ngos/patient-posts/active");
//     setPosts(res.data);
//     } catch (error) {
//       console.log(error);
      
//     }

//   };

//   const openRequestModal = (post) => {
//     setSelectedPost(post);
//     setShow(true);
//   };

//   const sendRequest = async (e) => {
//     e.preventDefault();

//     await api.post("/ngos/patient-post-requests", {
//       postId: selectedPost._id,
//       patientId: selectedPost.patientId._id,
//       ngoId,
//       message,
//     });

//     setShow(false);
//     setMessage("");
//     alert("Request sent successfully");
//   };

//   return (
//     <div className="campaign-wrapper">
//       <NgoSidebar />

//       <div className="campaign-main">
//         <h1>Patient Hair Request Posts</h1>

//         <div className="campaign-table-card">
//           <Table responsive hover variant="dark" className="campaign-table">
//             <thead>
//               <tr>
//                 <th>PATIENT</th>
//                 <th>HAIR</th>
//                 <th>COLOR</th>
//                 <th>QTY</th>
//                 <th>LOCATION</th>
//                 <th>ACTION</th>
//               </tr>
//             </thead>

//             <tbody>
//               {posts.map((p) => (
//                 <tr key={p._id}>
//                   <td>{p.patientId.name}</td>
//                   <td>
//                     {p.hairType} | {p.hairLength} cm
//                   </td>
//                   <td>{p.hairColor}</td>
//                   <td>{p.quantity} g</td>
//                   <td>{p.location}</td>
//                   <td>
//                     <Button
//                       size="sm"
//                       onClick={() => openRequestModal(p)}
//                     >
//                       Send Request
//                     </Button>
//                   </td>
//                 </tr>
//               ))}
//             </tbody>
//           </Table>
//         </div>
//       </div>

//       {/* REQUEST MODAL */}
//       <Modal show={show} onHide={() => setShow(false)}>
//         <Modal.Header closeButton>
//           <Modal.Title>Send Request</Modal.Title>
//         </Modal.Header>

//         <Form onSubmit={sendRequest}>
//           <Modal.Body>
//             <Form.Group>
//               <Form.Label>Message to Patient</Form.Label>
//               <Form.Control
//                 as="textarea"
//                 rows={4}
//                 value={message}
//                 onChange={(e) => setMessage(e.target.value)}
//                 required
//               />
//             </Form.Group>
//           </Modal.Body>

//           <Modal.Footer>
//             <Button type="submit">Send</Button>
//             <Button variant="secondary" onClick={() => setShow(false)}>
//               Cancel
//             </Button>
//           </Modal.Footer>
//         </Form>
//       </Modal>
//     </div>
//   );
// }

// export default ViewPatientPosts;


import React, { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import Button from "react-bootstrap/Button";
import Modal from "react-bootstrap/Modal";
import Form from "react-bootstrap/Form";
import NgoSidebar from "./NgoSidebar";
import "./viewCampaigns.css";
import api from "../apiInterceptor";

function ViewPatientPosts() {
  const ngoId = localStorage.getItem("profileId");

  const [posts, setPosts] = useState([]);
  const [showRequest, setShowRequest] = useState(false);
  const [showReports, setShowReports] = useState(false);
  const [selectedPost, setSelectedPost] = useState(null);
  const [reports, setReports] = useState([]);
  const [message, setMessage] = useState("");

  useEffect(() => {
    fetchPosts();
  }, []);

  /* ================= FETCH POSTS ================= */
  const fetchPosts = async () => {
    const res = await api.get("/ngos/patient-posts/active");
    setPosts(res.data);
  };

  /* ================= SEND REQUEST ================= */
  const openRequestModal = (post) => {
    setSelectedPost(post);
    setShowRequest(true);
  };

  const sendRequest = async (e) => {
    e.preventDefault();

    await api.post("/ngos/patient-post-requests", {
      postId: selectedPost._id,
      patientId: selectedPost.patientId._id,
      ngoId,
      message,
    });

    setShowRequest(false);
    setMessage("");
    alert("Request sent successfully");
  };

  /* ================= VIEW REPORTS ================= */
  const openReports = (reports) => {
    setReports(reports || []);
    setShowReports(true);
  };

  return (
    <div className="campaign-wrapper">
      <NgoSidebar />

      <div className="campaign-main">
        <h1>Patient Hair Request Posts</h1>

        <div className="campaign-table-card">
          <Table responsive hover variant="dark" className="campaign-table">
            <thead>
              <tr>
                <th>PATIENT</th>
                <th>HAIR</th>
                <th>COLOR</th>
                <th>QTY</th>
                <th>LOCATION</th>
                <th>REPORTS</th>
                <th>ACTION</th>
              </tr>
            </thead>

            <tbody>
              {posts.map((p) => (
                <tr key={p._id}>
                  <td>{p.patientId.name}</td>

                  <td>
                    {p.hairType} | {p.hairLength} cm
                  </td>

                  <td>{p.hairColor}</td>
                  <td>{p.quantity}</td>
                  <td>{p.location}</td>

                  {/* REPORT BUTTON */}
                  <td>
                    {p.patientReports?.length > 0 ? (
                      <Button
                        size="sm"
                        onClick={() => openReports(p.patientReports)}
                      >
                        View Reports
                      </Button>
                    ) : (
                      <span style={{ color: "#777" }}>No Reports</span>
                    )}
                  </td>

                  {/* REQUEST */}
                  <td>
                    <Button size="sm" onClick={() => openRequestModal(p)}>
                      Send Request
                    </Button>
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>
        </div>
      </div>

      {/* ================= REQUEST MODAL ================= */}
      <Modal show={showRequest} onHide={() => setShowRequest(false)}>
        <Modal.Header closeButton>
          <Modal.Title>Send Request</Modal.Title>
        </Modal.Header>

        <Form onSubmit={sendRequest}>
          <Modal.Body>
            <Form.Group>
              <Form.Label>Message to Patient</Form.Label>
              <Form.Control
                as="textarea"
                rows={4}
                value={message}
                onChange={(e) => setMessage(e.target.value)}
                required
              />
            </Form.Group>
          </Modal.Body>

          <Modal.Footer>
            <Button type="submit">Send</Button>
            <Button variant="secondary" onClick={() => setShowRequest(false)}>
              Cancel
            </Button>
          </Modal.Footer>
        </Form>
      </Modal>

      {/* ================= REPORT MODAL ================= */}
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
            background: "#000",
            maxHeight: "70vh",
            overflowY: "auto",
          }}
        >
          {reports.length === 0 && (
            <p style={{ color: "#777" }}>No reports found</p>
          )}

          {reports.map((r) => (
            <div
              key={r._id}
              style={{
                border: "1px solid #333",
                borderRadius: 14,
                padding: 14,
                marginBottom: 16,
              }}
            >
              <h6 style={{ color: "#ffc107" }}>{r.title}</h6>
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

export default ViewPatientPosts;
