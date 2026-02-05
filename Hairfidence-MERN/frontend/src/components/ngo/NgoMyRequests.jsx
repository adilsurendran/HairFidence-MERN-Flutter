import React, { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import NgoSidebar from "./NgoSidebar";
import api from "../apiInterceptor";
import "./viewCampaigns.css";

function NgoMyRequests() {
  const ngoId = localStorage.getItem("profileId");
  const [requests, setRequests] = useState([]);

  useEffect(() => {
    fetchRequests();
  }, []);

  const fetchRequests = async () => {
    const res = await api.get(
      `/ngos/patient-post-requests/ngo/${ngoId}`
    );
    setRequests(res.data);
  };

  return (
    <div className="campaign-wrapper">
      <NgoSidebar />

      <div className="campaign-main">
        <h1>My Requests</h1>

        <div className="campaign-table-card">
          <Table responsive hover variant="dark" className="campaign-table">
            <thead>
              <tr>
                <th>PATIENT</th>
                <th>HAIR DETAILS</th>
                <th>LOCATION</th>
                <th>STATUS</th>
              </tr>
            </thead>

            <tbody>
              {requests.map((r) => (
                <tr key={r._id}>
                  <td>{r.patientId.name}</td>
                  <td>
                    {r.postId.hairType} | {r.postId.hairLength} cm
                  </td>
                  <td>{r.postId.location}</td>
                  <td>
                    <span
                      style={{
                        color:
                          r.status === "approved"
                            ? "#28a745"
                            : r.status === "rejected"
                            ? "#dc3545"
                            : "#ffc107",
                        fontWeight: 600,
                      }}
                    >
                      {r.status.toUpperCase()}
                    </span>
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

export default NgoMyRequests;
