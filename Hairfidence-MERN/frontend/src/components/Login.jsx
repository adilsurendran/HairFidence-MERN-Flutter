import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import "./login.css";
import api from "./apiInterceptor";

function Login() {
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    username: "",
    password: "",
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
      const res = await api.post("/auth/login", formData);
      console.log(res);
      

      const { role, profileId, loginId } = res.data;

      // store minimal data
      localStorage.setItem("role", role);
      localStorage.setItem("loginId", loginId);
      localStorage.setItem("profileId", profileId);

      alert("Login successful");

      // role-based navigation (React way)
      switch (role) {
        case "admin":
          navigate("/dashboardAdmin");
          break;
        case "ngo":
          navigate("/NgoDashboard");
          break;
        default:
          alert("Invalid role");
      }
    } catch (err) {
      alert(err.response?.data?.message || "Login failed");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-page">
      <div className="login-card">
        <h2 className="login-title">Welcome Back</h2>
        <p className="login-subtitle">Login to your account</p>

        <Form onSubmit={handleSubmit}>
          <Form.Group className="mb-3">
            <Form.Label className="form-label">Username</Form.Label>
            <Form.Control
              type="text"
              name="username"
              placeholder="Enter username"
              className="custom-input"
              value={formData.username}
              onChange={handleChange}
              required
            />
          </Form.Group>

          <Form.Group className="mb-4">
            <Form.Label className="form-label">Password</Form.Label>
            <Form.Control
              type="password"
              name="password"
              placeholder="Enter password"
              className="custom-input"
              value={formData.password}
              onChange={handleChange}
              required
            />
          </Form.Group>

          <Button className="login-btn" type="submit" disabled={loading}>
            {loading ? "Logging in..." : "Login"}
          </Button>
        </Form>
      </div>
    </div>
  );
}

export default Login;
