
// import React, { useState } from "react";
// import Form from "react-bootstrap/Form";
// import Button from "react-bootstrap/Button";
// import api from "../apiInterceptor";
// import AdminSidebar from "./AdminSidebar";
// import "./addNgo.css";

// function AddNgo() {
//   const [formData, setFormData] = useState({
//     name: "",
//     contactPerson: "",
//     phone: "",
//     email: "",
//     password: "",
//     state: "",
//     city: "",
//     place: "",
//     pincode: "",
//   });

//   const [errors, setErrors] = useState({});
//   const [loading, setLoading] = useState(false);

//   const handleChange = (e) => {
//     setFormData({ ...formData, [e.target.name]: e.target.value });
//     setErrors({ ...errors, [e.target.name]: "" });
//   };

// const validate = () => {
//   let newErrors = {};

//   // ALL fields required
//   Object.keys(formData).forEach((field) => {
//     if (!formData[field].trim()) {
//       newErrors[field] = "This field is required";
//     }
//   });

//   // Phone: exactly 10 digits
//   if (formData.phone && !/^\d{10}$/.test(formData.phone)) {
//     newErrors.phone = "Phone number must be exactly 10 digits";
//   }

//   // Email format
//   if (
//     formData.email &&
//     !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email)
//   ) {
//     newErrors.email = "Enter a valid email address";
//   }

//   // Password: min 6 characters
//   if (formData.password && formData.password.length < 6) {
//     newErrors.password = "Password must be at least 6 characters";
//   }

//   // Pincode: exactly 6 digits
//   if (formData.pincode && !/^\d{6}$/.test(formData.pincode)) {
//     newErrors.pincode = "Pincode must be exactly 6 digits";
//   }

//   setErrors(newErrors);
//   return Object.keys(newErrors).length === 0;
// };


//   const handleSubmit = async (e) => {
//     e.preventDefault();

//     if (!validate()) return;

//     setLoading(true);
//     try {
//       console.log("hiii");
      
//       await api.post("/ngos", formData);
//       alert("NGO added successfully");

//       setFormData({
//         name: "",
//         contactPerson: "",
//         phone: "",
//         email: "",
//         password: "",
//         state: "",
//         city: "",
//         place: "",
//         pincode: "",
//       });
//       setErrors({});
//     } catch (err) {
//       alert(err.response?.data?.message || "Failed to add NGO");
//     } finally {
//       setLoading(false);
//     }
//   };

//   return (
//     <div className="admin-container">
//       <AdminSidebar />

//       <div className="admin-content">
//         <h2 className="dashboard-title">Add NGO</h2>

//         <div className="addngo-card">
//           <Form onSubmit={handleSubmit}>
//             {/* NGO Name */}
//             <Form.Group className="mb-3">
//               <Form.Label>NGO Name</Form.Label>
//               <Form.Control
//                 type="text"
//                 name="name"
//                 value={formData.name}
//                 onChange={handleChange}
//               />
//               {errors.name && <div className="error-text">{errors.name}</div>}
//             </Form.Group>

//             {/* Contact Person */}
//             <Form.Group className="mb-3">
//               <Form.Label>Contact Person</Form.Label>
//               <Form.Control
//                 type="text"
//                 name="contactPerson"
//                 value={formData.contactPerson}
//                 onChange={handleChange}
//               />
//               {errors.contactPerson && (
//                 <div className="error-text">{errors.contactPerson}</div>
//               )}
//             </Form.Group>

//             {/* Phone */}
//             <Form.Group className="mb-3">
//               <Form.Label>Phone</Form.Label>
//               <Form.Control
//                 type="text"
//                 name="phone"
//                 value={formData.phone}
//                 onChange={handleChange}
//               />
//               {errors.phone && (
//                 <div className="error-text">{errors.phone}</div>
//               )}
//             </Form.Group>

//             {/* Email */}
//             <Form.Group className="mb-3">
//               <Form.Label>Email (Username)</Form.Label>
//               <Form.Control
//                 type="email"
//                 name="email"
//                 value={formData.email}
//                 onChange={handleChange}
//               />
//               {errors.email && (
//                 <div className="error-text">{errors.email}</div>
//               )}
//             </Form.Group>

//             {/* Password */}
//             <Form.Group className="mb-3">
//               <Form.Label>Password</Form.Label>
//               <Form.Control
//                 type="password"
//                 name="password"
//                 value={formData.password}
//                 onChange={handleChange}
//               />
//               {errors.password && (
//                 <div className="error-text">{errors.password}</div>
//               )}
//             </Form.Group>

//             {/* Optional Fields */}
//             <Form.Group className="mb-3">
//               <Form.Label>State</Form.Label>
//               <Form.Control
//                 type="text"
//                 name="state"
//                 value={formData.state}
//                 onChange={handleChange}
//               />
//             </Form.Group>

//             <Form.Group className="mb-3">
//               <Form.Label>City</Form.Label>
//               <Form.Control
//                 type="text"
//                 name="city"
//                 value={formData.city}
//                 onChange={handleChange}
//               />
//             </Form.Group>

//             <Form.Group className="mb-3">
//               <Form.Label>Place</Form.Label>
//               <Form.Control
//                 type="text"
//                 name="place"
//                 value={formData.place}
//                 onChange={handleChange}
//               />
//             </Form.Group>

//             {/* Pincode */}
//             <Form.Group className="mb-4">
//               <Form.Label>Pincode</Form.Label>
//               <Form.Control
//                 type="text"
//                 name="pincode"
//                 value={formData.pincode}
//                 onChange={handleChange}
//               />
//               {errors.pincode && (
//                 <div className="error-text">{errors.pincode}</div>
//               )}
//             </Form.Group>

//             <Button type="submit" disabled={loading} className="addngo-btn">
//               {loading ? "Adding..." : "Add NGO"}
//             </Button>
//           </Form>
//         </div>
//       </div>
//     </div>
//   );
// }

// export default AddNgo;

import React, { useState } from "react";
import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import api from "../apiInterceptor";
import AdminSidebar from "./AdminSidebar";
import "./addNgo.css";

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

  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);

  /* =========================
     HANDLE CHANGE
  ========================== */
  const handleChange = (e) => {
    const { name, value } = e.target;

    setFormData({ ...formData, [name]: value });

    // Clear error only if user types something
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

    // Password length
    if (formData.password && formData.password.length < 6) {
      newErrors.password = "Password must be at least 6 characters";
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
      setErrors({});
    } catch (err) {
      alert(err.response?.data?.message || "Failed to add NGO");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="admin-container">
      <AdminSidebar />

      <div className="admin-content">
        <h2 className="dashboard-title">Add NGO</h2>

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
              <Form.Label>Email (Username)</Form.Label>
              <Form.Control
                type="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
              />
              {errors.email && (
                <div className="error-text">{errors.email}</div>
              )}
            </Form.Group>

            {/* Password */}
            <Form.Group className="mb-3">
              <Form.Label>Password</Form.Label>
              <Form.Control
                type="password"
                name="password"
                value={formData.password}
                onChange={handleChange}
              />
              {errors.password && (
                <div className="error-text">{errors.password}</div>
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
              {loading ? "Adding..." : "Add NGO"}
            </Button>
          </Form>
        </div>
      </div>
    </div>
  );
}

export default AddNgo;
