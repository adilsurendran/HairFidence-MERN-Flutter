import React, { useState } from "react";
import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import api from "../apiInterceptor";
import NgoSidebar from "./NgoSidebar";
import "./addHairPost.css";



function AddHairPost() {
   const profileId = localStorage.getItem("profileId");

  const [formData, setFormData] = useState({
    title: "",
    hairLength: "",
    hairType: "",
    hairColor: "",
    chemicallyTreated: "no",
    greyHair: "no",
    quantity: "",
    condition: "",
    location: "",
    description: "",
  });

  const handleChange = (e) =>
    setFormData({ ...formData, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      await api.post("/hair-posts", {
        ...formData,
        profileId,
      });

      alert("Hair post added successfully");

      setFormData({
        title: "",
        hairLength: "",
        hairType: "",
        hairColor: "",
        chemicallyTreated: "no",
        greyHair: "no",
        quantity: "",
        condition: "",
        location: "",
        description: "",
      });
    } catch {
      alert("Failed to add post");
    }
  };

  return (
    <div className="ngo-container">
      <NgoSidebar />

      <div className="ngo-content">
        <h1 className="hairpost-title">Add Hair Availability Post</h1>

        <div className="hairpost-card">
          <Form onSubmit={handleSubmit}>
            {/* TITLE */}
            <Form.Group className="mb-3">
              <Form.Label>Post Title</Form.Label>
              <Form.Control
                type="text"
                name="title"
                placeholder="Eg: Natural long hair available"
                value={formData.title}
                onChange={handleChange}
                required
              />
            </Form.Group>

            {/* HAIR LENGTH */}
            <Form.Group className="mb-3">
              <Form.Label>Hair Length (cm)</Form.Label>
              <Form.Control
                type="number"
                name="hairLength"
                placeholder="Eg: 30"
                value={formData.hairLength}
                onChange={handleChange}
                required
              />
            </Form.Group>

            {/* HAIR TYPE */}
            <Form.Group className="mb-3">
              <Form.Label>Hair Type</Form.Label>
              <Form.Select
                name="hairType"
                value={formData.hairType}
                onChange={handleChange}
                required
              >
                <option value="">Select</option>
                <option value="Straight">Straight</option>
                <option value="Wavy">Wavy</option>
                <option value="Curly">Curly</option>
              </Form.Select>
            </Form.Group>

            {/* HAIR COLOR */}
            <Form.Group className="mb-3">
              <Form.Label>Hair Color</Form.Label>
              <Form.Select
                name="hairColor"
                value={formData.hairColor}
                onChange={handleChange}
                required
              >
                <option value="">Select</option>
                <option value="Black">Black</option>
                <option value="Brown">Brown</option>
                <option value="Dark Brown">Dark Brown</option>
                <option value="Mixed">Mixed</option>
              </Form.Select>
            </Form.Group>

            {/* CHEMICAL TREATMENT */}
            <Form.Group className="mb-3">
              <Form.Label>Chemically Treated?</Form.Label>
              <Form.Select
                name="chemicallyTreated"
                value={formData.chemicallyTreated}
                onChange={handleChange}
              >
                <option value="no">No</option>
                <option value="yes">Yes</option>
              </Form.Select>
            </Form.Group>

            {/* GREY HAIR */}
            <Form.Group className="mb-3">
              <Form.Label>Grey Hair Present?</Form.Label>
              <Form.Select
                name="greyHair"
                value={formData.greyHair}
                onChange={handleChange}
              >
                <option value="no">No</option>
                <option value="yes">Yes</option>
              </Form.Select>
            </Form.Group>

            {/* QUANTITY */}
            <Form.Group className="mb-3">
              <Form.Label>Quantity (Bundles / Donors)</Form.Label>
              <Form.Control
                type="number"
                name="quantity"
                placeholder="Eg: 3"
                value={formData.quantity}
                onChange={handleChange}
                required
              />
            </Form.Group>

            {/* CONDITION */}
            <Form.Group className="mb-3">
              <Form.Label>Hair Condition</Form.Label>
              <Form.Select
                name="condition"
                value={formData.condition}
                onChange={handleChange}
                required
              >
                <option value="">Select</option>
                <option value="Excellent">Excellent</option>
                <option value="Good">Good</option>
                <option value="Average">Average</option>
              </Form.Select>
            </Form.Group>

            {/* LOCATION */}
            <Form.Group className="mb-3">
              <Form.Label>Location</Form.Label>
              <Form.Control
                type="text"
                name="location"
                placeholder="City / District"
                value={formData.location}
                onChange={handleChange}
                required
              />
            </Form.Group>

            {/* DESCRIPTION */}
            <Form.Group className="mb-4">
              <Form.Label>Additional Description</Form.Label>
              <Form.Control
                as="textarea"
                rows={3}
                name="description"
                placeholder="Any extra details about the hair"
                value={formData.description}
                onChange={handleChange}
              />
            </Form.Group>

            <Button type="submit" className="hairpost-btn">
              Add Hair Post
            </Button>
          </Form>
        </div>
      </div>
    </div>
  );
}

export default AddHairPost;



