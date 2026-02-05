import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import Button from "react-bootstrap/Button";
import Modal from "react-bootstrap/Modal";
import Form from "react-bootstrap/Form";
import NgoSidebar from "./NgoSidebar";
import api from "../apiInterceptor";
import "./ngoComplaint.css";

function NgoComplaints() {
  const senderId = localStorage.getItem("profileId");

  const [complaints, setComplaints] = useState([]);
  const [show, setShow] = useState(false);

  const [subject, setSubject] = useState("");
  const [message, setMessage] = useState("");

  /* ===============================
     FETCH NGO COMPLAINTS
  =============================== */
  const fetchComplaints = async () => {
    const res = await api.get(`/complaints/user/${senderId}`);
    setComplaints(res.data);
  };

  useEffect(() => {
    fetchComplaints();
  }, []);

  /* ===============================
     SEND COMPLAINT
  =============================== */
  const sendComplaint = async (e) => {
    e.preventDefault();

    await api.post("/complaints", {
      senderId,
      senderRole: "ngo",
      subject,
      message,
    });

    setSubject("");
    setMessage("");
    setShow(false);
    fetchComplaints();
  };

  return (
    <div className="complaint-wrapper">
      <NgoSidebar />

      <div className="complaint-main">
        <div className="complaint-header">
          <h1>My Complaints</h1>
          <Button onClick={() => setShow(true)}>+ Add Complaint</Button>
        </div>

        <div className="complaint-card">
          <Table responsive hover variant="dark" className="complaint-table">
            <thead>
              <tr>
                <th>Subject</th>
                <th>Message</th>
                <th>Status</th>
                <th>Admin Reply</th>
                <th>Date</th>
              </tr>
            </thead>

            <tbody>
              {complaints.length === 0 && (
                <tr>
                  <td colSpan="5" style={{ textAlign: "center", color: "#777" }}>
                    No complaints submitted
                  </td>
                </tr>
              )}

              {complaints.map((c) => (
                <tr key={c._id}>
                  <td>{c.subject}</td>
                  <td>{c.message}</td>
                  <td>
                    <span
                      className={
                        c.status === "replied"
                          ? "status-replied"
                          : "status-pending"
                      }
                    >
                      {c.status}
                    </span>
                  </td>
                  <td>{c.reply || "—"}</td>
                  <td>
                    {new Date(c.createdAt).toLocaleDateString()}
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>
        </div>
      </div>

      {/* ===============================
         ADD COMPLAINT MODAL
      =============================== */}
      <Modal show={show} onHide={() => setShow(false)} centered>
        <Modal.Header closeButton>
          <Modal.Title>Send Complaint</Modal.Title>
        </Modal.Header>

        <Form onSubmit={sendComplaint}>
          <Modal.Body>
            <Form.Group className="mb-3">
              <Form.Label>Subject</Form.Label>
              <Form.Control
                value={subject}
                onChange={(e) => setSubject(e.target.value)}
                required
              />
            </Form.Group>

            <Form.Group>
              <Form.Label>Message</Form.Label>
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
            <Button type="submit">Submit</Button>
            <Button variant="secondary" onClick={() => setShow(false)}>
              Cancel
            </Button>
          </Modal.Footer>
        </Form>
      </Modal>
    </div>
  );
}

export default NgoComplaints;
