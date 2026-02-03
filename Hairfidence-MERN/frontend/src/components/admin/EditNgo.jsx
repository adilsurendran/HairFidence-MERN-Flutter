import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import api from "../apiInterceptor";

function EditNgo() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    name: "",
    contactPerson: "",
    phone: "",
    email: "",
    state: "",
    city: "",
    place: "",
    pincode: "",
  });

  useEffect(() => {
    api.get(`/ngos/${id}`).then((res) => setFormData(res.data));
  }, [id]);

  const handleChange = (e) =>
    setFormData({ ...formData, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    await api.put(`/ngos/${id}`, formData);
    alert("NGO updated");
    navigate("/ViewNgo");
  };

  return (
    <Form onSubmit={handleSubmit}>
      <h2>Edit NGO</h2>

      {Object.keys(formData).map((key) => (
        <Form.Group className="mb-3" key={key}>
          <Form.Label>{key.toUpperCase()}</Form.Label>
          <Form.Control
            type="text"
            name={key}
            value={formData[key] || ""}
            onChange={handleChange}
          />
        </Form.Group>
      ))}

      <Button type="submit">Update NGO</Button>
    </Form>
  );
}

export default EditNgo;
