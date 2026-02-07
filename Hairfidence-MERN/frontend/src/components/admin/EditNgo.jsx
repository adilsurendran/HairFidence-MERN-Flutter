// import React, { useEffect, useState } from "react";
// import { useParams, useNavigate } from "react-router-dom";
// import Form from "react-bootstrap/Form";
// import Button from "react-bootstrap/Button";
// import api from "../apiInterceptor";

// function EditNgo() {
//   const { id } = useParams();
//   const navigate = useNavigate();

//   const [formData, setFormData] = useState({
//     name: "",
//     contactPerson: "",
//     phone: "",
//     email: "",
//     state: "",
//     city: "",
//     place: "",
//     pincode: "",
//   });

//   useEffect(() => {
//     api.get(`/ngos/${id}`).then((res) => setFormData(res.data));
//   }, [id]);

//   const handleChange = (e) =>
//     setFormData({ ...formData, [e.target.name]: e.target.value });

//   const handleSubmit = async (e) => {
//     e.preventDefault();
//     await api.put(`/ngos/${id}`, formData);
//     alert("NGO updated");
//     navigate("/ViewNgo");
//   };

//   return (
//     <Form onSubmit={handleSubmit}>
//       <h2>Edit NGO</h2>

//       {Object.keys(formData).map((key) => (
//         <Form.Group className="mb-3" key={key}>
//           <Form.Label>{key.toUpperCase()}</Form.Label>
//           <Form.Control
//             type="text"
//             name={key}
//             value={formData[key] || ""}
//             onChange={handleChange}
//           />
//         </Form.Group>
//       ))}

//       <Button type="submit">Update NGO</Button>
//     </Form>
//   );
// }

// export default EditNgo;


import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import api from "../apiInterceptor";
import AdminSidebar from "./AdminSidebar";
import "./addNgo.css";

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

  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);

  /* =========================
     LOAD NGO DATA
  ========================== */
  useEffect(() => {
    const res =  api.get(`/ngos/${id}`).then((res) => {
      setFormData({
        name: res.data.name || "",
        contactPerson: res.data.contactPerson || "",
        phone: res.data.phone || "",
        email: res.data.email || "",
        state: res.data.state || "",
        city: res.data.city || "",
        place: res.data.place || "",
        pincode: res.data.pincode || "",
      });
    });
  }, [id]);

  /* =========================
     HANDLE CHANGE
  ========================== */
  const handleChange = (e) => {
    const { name, value } = e.target;

    setFormData({ ...formData, [name]: value });

    if (value.trim()) {
      setErrors({ ...errors, [name]: "" });
    }
  };

  /* =========================
     VALIDATION
  ========================== */
  const validate = () => {
    let newErrors = {};

    // All fields required
    Object.keys(formData).forEach((field) => {
      if (!formData[field].trim()) {
        newErrors[field] = "This field is required";
      }
    });

    // Phone: exactly 10 digits
    if (formData.phone && !/^\d{10}$/.test(formData.phone)) {
      newErrors.phone = "Phone number must be exactly 10 digits";
    }

    // Email format
    if (
      formData.email &&
      !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email)
    ) {
      newErrors.email = "Enter a valid email address";
    }

    // Pincode: exactly 6 digits
    if (formData.pincode && !/^\d{6}$/.test(formData.pincode)) {
      newErrors.pincode = "Pincode must be exactly 6 digits";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  /* =========================
     SUBMIT
  ========================== */
  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!validate()) return;

    setLoading(true);
    try {
      await api.put(`/ngos/${id}`, formData);
      alert("NGO updated successfully");
      navigate("/ViewNgo");
    } catch (err) {
      alert(err.response?.data?.message || "Failed to update NGO");
    } finally {
      setLoading(false);
    }
  };
console.log(formData.email);

  return (
    <div className="admin-container">
      <AdminSidebar />

      <div className="admin-content">
        <h2 className="dashboard-title">Edit NGO</h2>

        <div className="addngo-card">
          <Form onSubmit={handleSubmit}>
            {/* NGO Name */}
            <Form.Group className="mb-3">
              <Form.Label>NGO Name</Form.Label>
              <Form.Control
                type="text"
                name="name"
                value={formData.name}
                onChange={handleChange}
              />
              {errors.name && <div className="error-text">{errors.name}</div>}
            </Form.Group>

            {/* Contact Person */}
            <Form.Group className="mb-3">
              <Form.Label>Contact Person</Form.Label>
              <Form.Control
                type="text"
                name="contactPerson"
                value={formData.contactPerson}
                onChange={handleChange}
              />
              {errors.contactPerson && (
                <div className="error-text">{errors.contactPerson}</div>
              )}
            </Form.Group>

            {/* Phone */}
            <Form.Group className="mb-3">
              <Form.Label>Phone</Form.Label>
              <Form.Control
                type="text"
                name="phone"
                value={formData.phone}
                onChange={handleChange}
              />
              {errors.phone && (
                <div className="error-text">{errors.phone}</div>
              )}
            </Form.Group>

            {/* Email */}
            <Form.Group className="mb-3">
              <Form.Label>Email(ReadOnly)</Form.Label>
              <Form.Control
                type="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                disabled
              />
              {errors.email && (
                <div className="error-text">{errors.email}</div>
              )}
            </Form.Group>

            {/* State */}
            <Form.Group className="mb-3">
              <Form.Label>State</Form.Label>
              <Form.Control
                type="text"
                name="state"
                value={formData.state}
                onChange={handleChange}
              />
              {errors.state && <div className="error-text">{errors.state}</div>}
            </Form.Group>

            {/* City */}
            <Form.Group className="mb-3">
              <Form.Label>City</Form.Label>
              <Form.Control
                type="text"
                name="city"
                value={formData.city}
                onChange={handleChange}
              />
              {errors.city && <div className="error-text">{errors.city}</div>}
            </Form.Group>

            {/* Place */}
            <Form.Group className="mb-3">
              <Form.Label>Place</Form.Label>
              <Form.Control
                type="text"
                name="place"
                value={formData.place}
                onChange={handleChange}
              />
              {errors.place && <div className="error-text">{errors.place}</div>}
            </Form.Group>

            {/* Pincode */}
            <Form.Group className="mb-4">
              <Form.Label>Pincode</Form.Label>
              <Form.Control
                type="text"
                name="pincode"
                value={formData.pincode}
                onChange={handleChange}
              />
              {errors.pincode && (
                <div className="error-text">{errors.pincode}</div>
              )}
            </Form.Group>

            <Button type="submit" disabled={loading} className="addngo-btn">
              {loading ? "Updating..." : "Update NGO"}
            </Button>
          </Form>
        </div>
      </div>
    </div>
  );
}

export default EditNgo;
