import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import Button from "react-bootstrap/Button";
import Modal from "react-bootstrap/Modal";
import Form from "react-bootstrap/Form";
import AdminSidebar from "./AdminSidebar";
import api from "../apiInterceptor";
import "./sendNotification.css";

function SendNotification() {
  const [notifications, setNotifications] = useState([]);
  const [show, setShow] = useState(false);

  const [formData, setFormData] = useState({
    title: "",
    message: "",
    roles: [],
  });

  /* FETCH */
  const fetchNotifications = async () => {
    const res = await api.get("/notifications");
    setNotifications(res.data);
  };

  useEffect(() => {
    fetchNotifications();
  }, []);

  /* HANDLE CHANGE */
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  /* ROLE MULTI SELECT */
  const handleRoleChange = (e) => {
    const options = [...e.target.options];
    const selected = options
      .filter((o) => o.selected)
      .map((o) => o.value);

    setFormData({ ...formData, roles: selected });
  };

  /* SUBMIT */
  const handleSubmit = async (e) => {
    e.preventDefault();

    await api.post("/notifications", formData);

    setShow(false);
    setFormData({ title: "", message: "", roles: [] });
    fetchNotifications();
  };

  return (
    <div className="notify-wrapper">
      <AdminSidebar />

      <div className="notify-main">
        <div className="notify-header">
          <h1 className="notify-title">Send Notifications</h1>

          <Button className="notify-add-btn" onClick={() => setShow(true)}>
            + New
          </Button>
        </div>

        <div className="notify-card">
          <Table responsive hover variant="dark" className="notify-table">
            <thead>
              <tr>
                <th style={{color:"#ffc107"}}>Title</th>
                <th style={{color:"#ffc107"}}>Message</th>
                <th style={{color:"#ffc107"}}>Receivers</th>
                <th style={{color:"#ffc107"}}>Sent Date</th>
              </tr>
            </thead>

            <tbody>
              {notifications.map((n) => (
                <tr key={n._id}>
                  <td>{n.title}</td>
                  <td>{n.message}</td>
                  <td>{n.roles.join(", ")}</td>
                  <td>{new Date(n.createdAt).toDateString()}</td>
                </tr>
              ))}
            </tbody>
          </Table>
        </div>
      </div>

      {/* MODAL */}
      <Modal show={show} onHide={() => setShow(false)} centered>
        <Modal.Header closeButton>
          <Modal.Title>Send Notification</Modal.Title>
        </Modal.Header>

        <Form onSubmit={handleSubmit}>
          <Modal.Body>
            <Form.Group className="mb-2">
              <Form.Label>Title</Form.Label>
              <Form.Control
                name="title"
                value={formData.title}
                onChange={handleChange}
                required
              />
            </Form.Group>

            <Form.Group className="mb-2">
              <Form.Label>Message</Form.Label>
              <Form.Control
                as="textarea"
                rows={3}
                name="message"
                value={formData.message}
                onChange={handleChange}
                required
              />
            </Form.Group>

            <Form.Group className="mb-2">
              <Form.Label>Send To</Form.Label>
              <Form.Select multiple onChange={handleRoleChange}>
                <option value="donor">Donors</option>
                <option value="patient">Patients</option>
                <option value="ngo">NGOs</option>
                <option value="all">All Users</option>
              </Form.Select>
            </Form.Group>
          </Modal.Body>

          <Modal.Footer>
            <Button variant="secondary" onClick={() => setShow(false)}>
              Cancel
            </Button>
            <Button type="submit" variant="success">
              Send
            </Button>
          </Modal.Footer>
        </Form>
      </Modal>
    </div>
  );
}

export default SendNotification;
