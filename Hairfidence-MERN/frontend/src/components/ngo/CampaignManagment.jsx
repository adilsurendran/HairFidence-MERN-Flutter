import React, { useState } from "react";
import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import NgoSidebar from "./NgoSidebar";
import api from "../apiInterceptor";
import "./campaignManagement.css";

function CampaignManagment() {
  const [formData, setFormData] = useState({
    name: "",
    location: "",
    date: "",
    time: "",
    description: "",
  });

  const [image, setImage] = useState(null);
  const ngoId = localStorage.getItem("profileId");

  const handleChange = (e) =>
    setFormData({ ...formData, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();

    const data = new FormData();
    Object.entries(formData).forEach(([key, value]) =>
      data.append(key, value)
    );
    data.append("ngoId", ngoId);
    if (image) data.append("image", image);

    await api.post("/campaigns", data, {
      headers: { "Content-Type": "multipart/form-data" },
    });

    alert("Campaign added");
    setFormData({
      name: "",
      location: "",
      date: "",
      time: "",
      description: "",
    });
    setImage(null);
  };

  return (
    <div className="campaign-wrapper">
      <NgoSidebar />

      <div className="campaign-main">
        <h1 className="campaign-title">Campaign Management</h1>

        <div className="campaign-card">
          <Form onSubmit={handleSubmit}>
            <Form.Group className="mb-3">
              <Form.Label>Campaign Name</Form.Label>
              <Form.Control
                name="name"
                value={formData.name}
                onChange={handleChange}
                required
              />
            </Form.Group>

            <Form.Group className="mb-3">
              <Form.Label>Location</Form.Label>
              <Form.Control
                name="location"
                value={formData.location}
                onChange={handleChange}
                required
              />
            </Form.Group>

            <Form.Group className="mb-3">
              <Form.Label>Date</Form.Label>
              <Form.Control
                type="date"
                name="date"
                value={formData.date}
                onChange={handleChange}
                required
              />
            </Form.Group>

            <Form.Group className="mb-3">
              <Form.Label>Time</Form.Label>
              <Form.Control
                type="time"
                name="time"
                value={formData.time}
                onChange={handleChange}
                required
              />
            </Form.Group>

            <Form.Group className="mb-3">
              <Form.Label>Description</Form.Label>
              <Form.Control
                as="textarea"
                rows={3}
                name="description"
                value={formData.description}
                onChange={handleChange}
              />
            </Form.Group>

            <Form.Group className="mb-4">
              <Form.Label>Campaign Image</Form.Label>
              <Form.Control
                type="file"
                accept="image/*"
                onChange={(e) => setImage(e.target.files[0])}
              />
            </Form.Group>

            <Button className="campaign-btn" type="submit">
              Add Campaign
            </Button>
          </Form>
        </div>
      </div>
    </div>
  );
}

export default CampaignManagment;
