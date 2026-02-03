import React, { useState } from "react";
import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import api from "../apiInterceptor";

function AddNgo() {
  const [formData, setFormData] = useState({
    name: "",
    contactPerson: "",
    phone: "",
    email: "",
    password: "",
    state: "",
    city: "",
    place: "",
    pincode: "",
  });

  const [loading, setLoading] = useState(false);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      await api.post("/ngos", formData);
      alert("NGO added successfully");

      setFormData({
        name: "",
        contactPerson: "",
        phone: "",
        email: "",
        password: "",
        state: "",
        city: "",
        place: "",
        pincode: "",
      });
    } catch (err) {
      alert(err.response?.data?.message || "Failed to add NGO");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="add-ngo-page">
      <Form onSubmit={handleSubmit}>
        <h2 className="mb-4">Add NGO</h2>

        <Form.Group className="mb-3">
          <Form.Label>NGO Name</Form.Label>
          <Form.Control
            type="text"
            name="name"
            placeholder="NGO NAME"
            value={formData.name}
            onChange={handleChange}
            required
          />
        </Form.Group>

        <Form.Group className="mb-3">
          <Form.Label>Contact Person</Form.Label>
          <Form.Control
            type="text"
            name="contactPerson"
            placeholder="CONTACT PERSON"
            value={formData.contactPerson}
            onChange={handleChange}
            required
          />
        </Form.Group>

        <Form.Group className="mb-3">
          <Form.Label>Phone</Form.Label>
          <Form.Control
            type="number"
            name="phone"
            placeholder="PHONE"
            value={formData.phone}
            onChange={handleChange}
            required
          />
        </Form.Group>

        <Form.Group className="mb-3">
          <Form.Label>Email (Username)</Form.Label>
          <Form.Control
            type="email"
            name="email"
            placeholder="EMAIL"
            value={formData.email}
            onChange={handleChange}
            required
          />
        </Form.Group>

        <Form.Group className="mb-3">
          <Form.Label>Password</Form.Label>
          <Form.Control
            type="password"
            name="password"
            placeholder="PASSWORD"
            value={formData.password}
            onChange={handleChange}
            required
          />
        </Form.Group>

        <Form.Group className="mb-3">
          <Form.Label>State</Form.Label>
          <Form.Control
            type="text"
            name="state"
            placeholder="STATE"
            value={formData.state}
            onChange={handleChange}
          />
        </Form.Group>

        <Form.Group className="mb-3">
          <Form.Label>City</Form.Label>
          <Form.Control
            type="text"
            name="city"
            placeholder="CITY"
            value={formData.city}
            onChange={handleChange}
          />
        </Form.Group>

        <Form.Group className="mb-3">
          <Form.Label>Place</Form.Label>
          <Form.Control
            type="text"
            name="place"
            placeholder="PLACE"
            value={formData.place}
            onChange={handleChange}
          />
        </Form.Group>

        <Form.Group className="mb-4">
          <Form.Label>Pincode</Form.Label>
          <Form.Control
            type="text"
            name="pincode"
            placeholder="PINCODE"
            value={formData.pincode}
            onChange={handleChange}
          />
        </Form.Group>

        <Button type="submit" disabled={loading}>
          {loading ? "Adding..." : "Add NGO"}
        </Button>
      </Form>
    </div>
  );
}

export default AddNgo;
