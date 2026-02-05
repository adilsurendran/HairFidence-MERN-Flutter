import React, { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import Button from "react-bootstrap/Button";
import Modal from "react-bootstrap/Modal";
import Form from "react-bootstrap/Form";
import NgoSidebar from "./NgoSidebar";
import api from "../apiInterceptor";
import './viewCampaigns.css'

function ViewCampaigns() {
  const ngoId = localStorage.getItem("profileId");

  const [campaigns, setCampaigns] = useState([]);
  const [show, setShow] = useState(false);
  const [selectedCampaign, setSelectedCampaign] = useState(null);
  const [image, setImage] = useState(null);

  const fetchCampaigns = async () => {
    const res = await api.get(`/campaigns/${ngoId}`);
    setCampaigns(res.data);
  };

  useEffect(() => {
    fetchCampaigns();
  }, []);

  const handleEdit = (campaign) => {
    setSelectedCampaign(campaign);
    setShow(true);
  };

  const handleUpdate = async (e) => {
    e.preventDefault();

    const data = new FormData();
    Object.entries(selectedCampaign).forEach(([key, value]) => {
      if (key !== "_id" && key !== "image") data.append(key, value);
    });
    if (image) data.append("image", image);

    await api.put(`/campaigns/${selectedCampaign._id}`, data, {
      headers: { "Content-Type": "multipart/form-data" },
    });

    setShow(false);
    setImage(null);
    fetchCampaigns();
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Delete this campaign?")) return;
    await api.delete(`/campaigns/${id}`);
    fetchCampaigns();
  };

  return (
    <div className="campaign-wrapper">
      <NgoSidebar />

      <div className="campaign-main">
        <h1>My Campaigns</h1>
<div className="campaign-table-card">
  <Table responsive hover variant="dark" className="campaign-table">
          <thead>
            <tr>
              <th>NAME</th>
              <th>LOCATION</th>
              <th>DATE</th>
              <th>IMAGE</th>
              <th>ACTION</th>
            </tr>
          </thead>

          <tbody>
            {campaigns.map((c) => (
              <tr key={c._id}>
                <td>{c.name}</td>
                <td>{c.location}</td>
                <td>{c.date}</td>
                <td>
                  {c.image && (
                    <img
                      src={`http://localhost:8000/api/uploads/${c.image}`}
                      alt=""
                      width="60"
                    />
                  )}
                </td>
                <td>
                  <Button size="sm" onClick={() => handleEdit(c)}>
                    Edit
                  </Button>{" "}
                  <Button
                    size="sm"
                    variant="danger"
                    onClick={() => handleDelete(c._id)}
                  >
                    Delete
                  </Button>
                </td>
              </tr>
            ))}
          </tbody>
        </Table>
        </div>
      </div>

      {/* EDIT MODAL */}
      <Modal show={show} onHide={() => setShow(false)}>
        <Modal.Header closeButton>
          <Modal.Title>Edit Campaign</Modal.Title>
        </Modal.Header>

        <Form onSubmit={handleUpdate}>
          <Modal.Body>
            <Form.Group className="mb-2">
              <Form.Label>Name</Form.Label>
              <Form.Control
                value={selectedCampaign?.name || ""}
                onChange={(e) =>
                  setSelectedCampaign({
                    ...selectedCampaign,
                    name: e.target.value,
                  })
                }
              />
            </Form.Group>

            <Form.Group className="mb-2">
              <Form.Label>Location</Form.Label>
              <Form.Control
                value={selectedCampaign?.location || ""}
                onChange={(e) =>
                  setSelectedCampaign({
                    ...selectedCampaign,
                    location: e.target.value,
                  })
                }
              />
            </Form.Group>

            <Form.Group className="mb-2">
              <Form.Label>Date</Form.Label>
              <Form.Control
                type="date"
                value={selectedCampaign?.date || ""}
                onChange={(e) =>
                  setSelectedCampaign({
                    ...selectedCampaign,
                    date: e.target.value,
                  })
                }
              />
            </Form.Group>

            <Form.Group className="mb-2">
              <Form.Label>Time</Form.Label>
              <Form.Control
                type="time"
                value={selectedCampaign?.time || ""}
                onChange={(e) =>
                  setSelectedCampaign({
                    ...selectedCampaign,
                    time: e.target.value,
                  })
                }
              />
            </Form.Group>

            <Form.Group className="mb-2">
              <Form.Label>Description</Form.Label>
              <Form.Control
                as="textarea"
                rows={3}
                value={selectedCampaign?.description || ""}
                onChange={(e) =>
                  setSelectedCampaign({
                    ...selectedCampaign,
                    description: e.target.value,
                  })
                }
              />
            </Form.Group>

            <Form.Group className="mb-2">
              <Form.Label>Update Image</Form.Label>
              <Form.Control
                type="file"
                accept="image/*"
                onChange={(e) => setImage(e.target.files[0])}
              />
            </Form.Group>
          </Modal.Body>

          <Modal.Footer>
            <Button type="submit">Update</Button>
            <Button variant="secondary" onClick={() => setShow(false)}>
              Cancel
            </Button>
          </Modal.Footer>
        </Form>
      </Modal>
    </div>
  );
}

export default ViewCampaigns;
