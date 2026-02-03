import React, { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import Button from "react-bootstrap/Button";
import { useNavigate } from "react-router-dom";
import AdminSidebar from "./AdminSidebar";
import api from "../apiInterceptor";
import "./viewNgo.css";

function ViewNgo() {
  const [ngos, setNgos] = useState([]);
  const navigate = useNavigate();

  const fetchNgos = async () => {
    const res = await api.get("/ngos");
    setNgos(res.data);
  };

  useEffect(() => {
    fetchNgos();
  }, []);

  const handleDelete = async (id) => {
    if (!window.confirm("Delete this NGO?")) return;
    await api.delete(`/ngos/${id}`);
    fetchNgos();
  };

  return (
    <div className="viewngo-wrapper">
      <AdminSidebar />

      <div className="viewngo-main">
        <h1 className="viewngo-title">Manage NGOs</h1>

        <div className="viewngo-card">
          <Table responsive hover variant="dark">
            <thead>
              <tr>
                <th>NAME</th>
                <th>CONTACT</th>
                <th>PHONE</th>
                <th>EMAIL</th>
                <th>PINCODE</th>
                <th>ACTION</th>
              </tr>
            </thead>

            <tbody>
              {ngos.map((ngo) => (
                <tr key={ngo._id}>
                  <td>{ngo.name}</td>
                  <td>{ngo.contactPerson}</td>
                  <td>{ngo.phone}</td>
                  <td>{ngo.email}</td>
                  <td>{ngo.pincode}</td>
                  <td className="viewngo-actions">
                    <Button
                      size="sm"
                      className="btn-edit"
                      onClick={() => navigate(`/edit-ngo/${ngo._id}`)}
                    >
                      Edit
                    </Button>
                    <Button
                      size="sm"
                      className="btn-delete"
                      onClick={() => handleDelete(ngo._id)}
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
    </div>
  );
}

export default ViewNgo;
