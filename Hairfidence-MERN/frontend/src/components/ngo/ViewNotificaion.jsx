import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import NgoSidebar from "./NgoSidebar";
import api from "../apiInterceptor";
import "./viewNotification.css";

function ViewNotification() {
  const ngoId = localStorage.getItem("profileId");
  const [notifications, setNotifications] = useState([]);

  const fetchNotifications = async () => {
    const res = await api.get(`/notifications/ngo/${ngoId}`);
    setNotifications(res.data);
  };

  useEffect(() => {
    fetchNotifications();
  }, []);

  return (
    <div className="notification-wrapper">
      <NgoSidebar />

      <div className="notification-main">
        <h1 className="notification-title">Notifications</h1>

        <div className="notification-card">
          <Table responsive hover variant="dark" className="notification-table">
            <thead>
              <tr>
                <th>Title</th>
                <th>Message</th>
                <th>Date</th>
              </tr>
            </thead>

            <tbody>
              {notifications.length === 0 && (
                <tr>
                  <td colSpan="3" style={{ textAlign: "center", color: "#777" }}>
                    No notifications available
                  </td>
                </tr>
              )}

              {notifications.map((n) => (
                <tr key={n._id}>
                  <td>{n.title}</td>
                  <td>{n.message}</td>
                  <td>{new Date(n.createdAt).toLocaleDateString()}</td>
                </tr>
              ))}
            </tbody>
          </Table>
        </div>
      </div>
    </div>
  );
}

export default ViewNotification;
