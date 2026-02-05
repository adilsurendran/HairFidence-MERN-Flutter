// import { useEffect, useState } from "react";
// import Table from "react-bootstrap/Table";
// import Button from "react-bootstrap/Button";
// import Modal from "react-bootstrap/Modal";
// import Form from "react-bootstrap/Form";
// import NgoSidebar from "./NgoSidebar";
// import api from "../apiInterceptor";
// import "./ngoDonorHairPosts.css";

// function NgoDonorHairPosts() {
//   const ngoId = localStorage.getItem("profileId");

//   const [posts, setPosts] = useState([]);
//   const [show, setShow] = useState(false);
//   const [rejectNote, setRejectNote] = useState("");
//   const [selectedId, setSelectedId] = useState(null);

//   const fetchPosts = async () => {
//     const res = await api.get(`/donor-hair-posts/ngo/${ngoId}`);
//     setPosts(res.data);
//   };

//   useEffect(() => {
//     fetchPosts();
//   }, []);

//   const approvePost = async (id) => {
//     if (!window.confirm("Approve this donation post?")) return;
//     await api.put(`/donor-hair-posts/approve/${id}`);
//     fetchPosts();
//   };

//   const openRejectModal = (id) => {
//     setSelectedId(id);
//     setRejectNote("");
//     setShow(true);
//   };

//   const rejectPost = async () => {
//     await api.put(`/donor-hair-posts/reject/${selectedId}`, {
//       rejectNote,
//     });
//     setShow(false);
//     fetchPosts();
//   };

//   return (
//     <div className="ngo-donor-wrapper">
//       <NgoSidebar />

//       <div className="ngo-donor-main">
//         <h1>Donor Hair Donation Requests</h1>

//         <div className="ngo-donor-card">
//           <Table responsive hover variant="dark">
//             <thead>
//               <tr>
//                 <th>Donor</th>
//                 <th>Hair Details</th>
//                 <th>Donation Date</th>
//                 <th>Location</th>
//                 <th>Status</th>
//                 <th>Action</th>
//               </tr>
//             </thead>

//             <tbody>
//               {posts.length === 0 && (
//                 <tr>
//                   <td colSpan="6" style={{ textAlign: "center", color: "#777" }}>
//                     No donor posts
//                   </td>
//                 </tr>
//               )}

//               {posts.map((p) => (
//                 <tr key={p._id}>
//                   <td>
//                     {p.donorId.name}
//                     <br />
//                     <small>{p.donorId.phone}</small>
//                   </td>

//                   <td>
//                     {p.hairType} | {p.hairLength} cm
//                     <br />
//                     <small>{p.hairColor}</small>
//                   </td>

//                   <td>{p.donationDate}</td>
//                   <td>{p.location}</td>

//                   <td style={{ fontWeight: 600 }}>
//                     {p.status.toUpperCase()}
//                   </td>

//                   <td>
//                     {p.status === "pending" ? (
//                       <>
//                         <Button
//                           size="sm"
//                           onClick={() => approvePost(p._id)}
//                         >
//                           Approve
//                         </Button>{" "}
//                         <Button
//                           size="sm"
//                           variant="danger"
//                           onClick={() => openRejectModal(p._id)}
//                         >
//                           Reject
//                         </Button>
//                       </>
//                     ) : (
//                       <span style={{ color: "#777" }}>—</span>
//                     )}
//                   </td>
//                 </tr>
//               ))}
//             </tbody>
//           </Table>
//         </div>
//       </div>

//       {/* REJECT MODAL */}
//       <Modal show={show} onHide={() => setShow(false)}>
//         <Modal.Header closeButton>
//           <Modal.Title>Reject Donation</Modal.Title>
//         </Modal.Header>

//         <Modal.Body>
//           <Form.Group>
//             <Form.Label>Reject Reason</Form.Label>
//             <Form.Control
//               as="textarea"
//               rows={4}
//               value={rejectNote}
//               onChange={(e) => setRejectNote(e.target.value)}
//               required
//             />
//           </Form.Group>
//         </Modal.Body>

//         <Modal.Footer>
//           <Button variant="secondary" onClick={() => setShow(false)}>
//             Cancel
//           </Button>
//           <Button variant="danger" onClick={rejectPost}>
//             Reject
//           </Button>
//         </Modal.Footer>
//       </Modal>
//     </div>
//   );
// }

// export default NgoDonorHairPosts;


import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import Button from "react-bootstrap/Button";
import Modal from "react-bootstrap/Modal";
import Form from "react-bootstrap/Form";
import NgoSidebar from "./NgoSidebar";
import api from "../apiInterceptor";
import "./ngoDonorHairPosts.css";

function NgoDonorHairPosts() {
  const ngoId = localStorage.getItem("profileId");

  const [posts, setPosts] = useState([]);
  const [show, setShow] = useState(false);
  const [rejectNote, setRejectNote] = useState("");
  const [selectedId, setSelectedId] = useState(null);

  const fetchPosts = async () => {
    const res = await api.get(`/donor-hair-posts/ngo/${ngoId}`);
    setPosts(res.data);
  };

  useEffect(() => {
    fetchPosts();
  }, []);

  const approvePost = async (id) => {
    if (!window.confirm("Approve this donation post?")) return;
    await api.put(`/donor-hair-posts/approve/${id}`);
    fetchPosts();
  };

  const collectPost = async (id) => {
    if (!window.confirm("Mark this hair as collected?")) return;
    await api.put(`/donor-hair-posts/collect/${id}`);
    fetchPosts();
  };

  const openRejectModal = (id) => {
    setSelectedId(id);
    setRejectNote("");
    setShow(true);
  };

  const rejectPost = async () => {
    await api.put(`/donor-hair-posts/reject/${selectedId}`, {
      rejectNote,
    });
    setShow(false);
    fetchPosts();
  };

  const statusColor = (status) => {
    const map = {
      pending: "#ffc107",
      approved: "#28a745",
      rejected: "#dc3545",
      collected: "#6c757d",
    };
    return map[status];
  };

  return (
    <div className="ngo-donor-wrapper">
      <NgoSidebar />

      <div className="ngo-donor-main">
        <h1>Donor Hair Donation Requests</h1>

        <div className="ngo-donor-card">
          <Table responsive hover variant="dark">
            <thead>
              <tr>
                <th>Donor</th>
                <th>Hair</th>
                <th>Date</th>
                <th>Location</th>
                <th>Status</th>
                <th>Action</th>
              </tr>
            </thead>

            <tbody>
              {posts.length === 0 && (
                <tr>
                  <td colSpan="6" style={{ textAlign: "center", color: "#777" }}>
                    No donor posts
                  </td>
                </tr>
              )}

              {posts.map((p) => (
                <tr key={p._id}>
                  <td>
                    {p.donorId.name}
                    <br />
                    <small>{p.donorId.phone}</small>
                  </td>

                  <td>
                    {p.hairType} | {p.hairLength} cm
                    <br />
                    <small>{p.hairColor}</small>
                  </td>

                  <td>{p.donationDate}</td>
                  <td>{p.location}</td>

                  <td style={{ color: statusColor(p.status), fontWeight: 600 }}>
                    {p.status.toUpperCase()}
                  </td>

                  <td>
                    {p.status === "pending" && (
                      <>
                        <Button
                          size="sm"
                          onClick={() => approvePost(p._id)}
                        >
                          Approve
                        </Button>{" "}
                        <Button
                          size="sm"
                          variant="danger"
                          onClick={() => openRejectModal(p._id)}
                        >
                          Reject
                        </Button>
                      </>
                    )}

                    {p.status === "approved" && (
                      <Button
                        size="sm"
                        variant="success"
                        onClick={() => collectPost(p._id)}
                      >
                        Collected
                      </Button>
                    )}

                    {(p.status === "rejected" ||
                      p.status === "collected") && (
                      <span style={{ color: "#777" }}>—</span>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>
        </div>
      </div>

      {/* REJECT MODAL */}
      <Modal show={show} onHide={() => setShow(false)}>
        <Modal.Header closeButton>
          <Modal.Title>Reject Donation</Modal.Title>
        </Modal.Header>

        <Modal.Body>
          <Form.Group>
            <Form.Label>Reject Reason</Form.Label>
            <Form.Control
              as="textarea"
              rows={4}
              value={rejectNote}
              onChange={(e) => setRejectNote(e.target.value)}
              required
            />
          </Form.Group>
        </Modal.Body>

        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShow(false)}>
            Cancel
          </Button>
          <Button variant="danger" onClick={rejectPost}>
            Reject
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
}

export default NgoDonorHairPosts;
