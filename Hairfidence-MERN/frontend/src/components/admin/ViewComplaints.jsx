import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import Button from "react-bootstrap/Button";
import Modal from "react-bootstrap/Modal";
import Form from "react-bootstrap/Form";
import NgoSidebar from "../ngo/NgoSidebar";
import api from "../apiInterceptor";
import "./viewComplaints.css";
import AdminSidebar from "./AdminSidebar";

function ViewComplaints() {
  const [complaints, setComplaints] = useState([]);
  const [show, setShow] = useState(false);
  const [replyText, setReplyText] = useState("");
  const [selectedComplaint, setSelectedComplaint] = useState(null);

  /* ===============================
     FETCH COMPLAINTS
  =============================== */
  const fetchComplaints = async () => {
    const res = await api.get("/complaints");
    setComplaints(res.data);
  };

  useEffect(() => {
    fetchComplaints();
  }, []);

  /* ===============================
     OPEN REPLY MODAL
  =============================== */
  const openReply = (complaint) => {
    setSelectedComplaint(complaint);
    setReplyText(complaint.reply || "");
    setShow(true);
  };

  /* ===============================
     SEND REPLY
  =============================== */
  const sendReply = async (e) => {
    e.preventDefault();

    await api.put(`/complaints/reply/${selectedComplaint._id}`, {
      reply: replyText,
    });

    setShow(false);
    setReplyText("");
    fetchComplaints();
  };

  return (
    <div className="complaint-wrapper">
      <AdminSidebar />

      <div className="complaint-main">
        <h1>Complaints</h1>

        <div className="complaint-table-card">
          <Table responsive hover variant="dark" className="complaint-table">
            <thead>
              <tr>
                <th>SUBJECT</th>
                <th>MESSAGE</th>
                <th>STATUS</th>
                <th>DATE</th>
                <th>ACTION</th>
              </tr>
            </thead>

            <tbody>
              {complaints.length === 0 && (
                <tr>
                  <td colSpan="5" style={{ textAlign: "center", color: "#777" }}>
                    No complaints found
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
                      {c.status.toUpperCase()}
                    </span>
                  </td>
                  <td>
                    {new Date(c.createdAt).toLocaleDateString()}
                  </td>
                  <td>
                    <Button
                      size="sm"
                      className="btn-primary"
                      onClick={() => openReply(c)}
                    >
                      Reply
                    </Button>
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>
        </div>
      </div>

      {/* ===============================
         REPLY MODAL
      =============================== */}
      <Modal show={show} onHide={() => setShow(false)} centered>
        <Modal.Header closeButton>
          <Modal.Title>Reply to Complaint</Modal.Title>
        </Modal.Header>

        <Form onSubmit={sendReply}>
          <Modal.Body>
            <Form.Group>
              <Form.Label>Reply Message</Form.Label>
              <Form.Control
                as="textarea"
                rows={4}
                value={replyText}
                onChange={(e) => setReplyText(e.target.value)}
                required
              />
            </Form.Group>
          </Modal.Body>

          <Modal.Footer>
            <Button type="submit">Send Reply</Button>
            <Button
              variant="secondary"
              onClick={() => setShow(false)}
            >
              Cancel
            </Button>
          </Modal.Footer>
        </Form>
      </Modal>
    </div>
  );
}

export default ViewComplaints;
