import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import AdminSidebar from "./AdminSidebar";
import api from "../apiInterceptor";
import "./viewDonor.css";

function ViewDonor() {
  const [donors, setDonors] = useState([]);

  /* ===============================
     FETCH DONORS
  =============================== */
  const fetchDonors = async () => {
    const res = await api.get("/admin/donors");
    setDonors(res.data);
  };

  useEffect(() => {
    fetchDonors();
  }, []);

  /* ===============================
     BLOCK / UNBLOCK
  =============================== */
  const updateStatus = async (donorId, status) => {
    await api.put(`/admin/donors/status/${donorId}`, {
      status,
    });
    fetchDonors();
  };

  const calculateAge = (dob) => {
    const birth = new Date(dob);
    const today = new Date();
    let age = today.getFullYear() - birth.getFullYear();
    const m = today.getMonth() - birth.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birth.getDate())) {
      age--;
    }
    return age;
  };

  return (
    <div className="donor-wrapper">
      <AdminSidebar />

      <div className="donor-main">
        <h1 className="donor-title">Manage Donors</h1>

        <div className="donor-card">
          <Table responsive hover variant="dark" className="donor-table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Phone</th>
                <th>Email</th>
                <th>NGO</th>
                <th>District</th>
                <th>Action</th>
              </tr>
            </thead>

            <tbody>
              {donors.length === 0 && (
                <tr>
                  <td colSpan="8" style={{ textAlign: "center", color: "#777" }}>
                    No donors found
                  </td>
                </tr>
              )}

              {donors.map((d) => (
                <tr key={d._id}>
                  <td>{d.name}</td>
                  <td>{calculateAge(d.dob)}</td>
                  <td>{d.gender}</td>
                  <td>{d.phone}</td>
                  <td>{d.email}</td>
                  <td>{d.ngoId?.name}</td>
                  <td>{d.district}</td>
                  <td className="donor-actions">
                    {d.loginId?.verified ? (
                      <button
                        className="donor-block"
                        onClick={() => updateStatus(d._id, false)}
                      >
                        Block
                      </button>
                    ) : (
                      <button
                        className="donor-unblock"
                        onClick={() => updateStatus(d._id, true)}
                      >
                        Unblock
                      </button>
                    )}
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

export default ViewDonor;
