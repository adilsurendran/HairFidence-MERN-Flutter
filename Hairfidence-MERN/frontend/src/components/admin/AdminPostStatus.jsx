// import { useEffect, useState } from "react";
// import api from "../apiInterceptor";

// function AdminPostStatus() {
//   const [posts, setPosts] = useState([]);
//   const [from, setFrom] = useState("");
//   const [to, setTo] = useState("");

//   const loadData = async () => {
//     const query =
//       from && to ? `?from=${from}&to=${to}` : "";
//     const res = await api.get(`/admin/posts-report${query}`);
//     setPosts(res.data);
//   };

//   useEffect(() => {
//     loadData();
//   }, []);

//   const downloadPdf = () => {
//     const query =
//       from && to ? `?from=${from}&to=${to}` : "";
//     window.open(`/admin/posts-report/pdf${query}`, "_blank");
//   };

//   return (
//     <div style={{ padding: 30 }}>
//       <h2>Admin – All Post Status</h2>

//       <div style={{ marginBottom: 20 }}>
//         <input type="date" onChange={(e) => setFrom(e.target.value)} />
//         <input type="date" onChange={(e) => setTo(e.target.value)} />
//         <button onClick={loadData}>Filter</button>
//         <button onClick={downloadPdf}>Generate PDF</button>
//       </div>

//       <table border="1" width="100%" cellPadding="8">
//         <thead>
//           <tr>
//             <th>Type</th>
//             <th>Owner</th>
//             <th>Hair</th>
//             <th>Qty</th>
//             <th>Location</th>
//             <th>Status</th>
//             <th>Date</th>
//           </tr>
//         </thead>
//         <tbody>
//           {posts.map((p) => (
//             <tr key={p.postId}>
//               <td>{p.postType}</td>
//               <td>{p.ownerName}</td>
//               <td>
//                 {p.hairLength}cm / {p.hairType} / {p.hairColor}
//               </td>
//               <td>{p.quantity}</td>
//               <td>{p.location}</td>
//               <td>{p.status}</td>
//               <td>{new Date(p.createdAt).toLocaleDateString()}</td>
//             </tr>
//           ))}
//         </tbody>
//       </table>
//     </div>
//   );
// }

// export default AdminPostStatus;


import { useEffect, useState } from "react";
import api from "../apiInterceptor";

function AdminPostStatus() {
  const [posts, setPosts] = useState([]);
  const [from, setFrom] = useState("");
  const [to, setTo] = useState("");
  const [status, setStatus] = useState("all");

  const buildQuery = () => {
    const params = [];
    if (from && to) {
      params.push(`from=${from}`, `to=${to}`);
    }
    if (status && status !== "all") {
      params.push(`status=${status}`);
    }
    return params.length ? `?${params.join("&")}` : "";
  };

  const loadData = async () => {
    const res = await api.get(
      `/admin/posts-report${buildQuery()}`
    );
    setPosts(res.data);
  };

  const downloadPdf = () => {
    window.open(
      `http://localhost:8000/api/admin/posts-report/pdf${buildQuery()}`,
      "_blank"
    );
  };

  useEffect(() => {
    loadData();
  }, []);

  return (
    <div style={{ padding: 30 }}>
      <h2>Admin – All Post Status</h2>

      <div style={{ display: "flex", gap: 10, marginBottom: 20 }}>
        <input type="date" onChange={(e) => setFrom(e.target.value)} />
        <input type="date" onChange={(e) => setTo(e.target.value)} />

        <select onChange={(e) => setStatus(e.target.value)}>
          <option value="all">All Status</option>
          <option value="pending">Pending</option>
          <option value="approved">Approved</option>
          <option value="rejected">Rejected</option>
          <option value="collected">Collected</option>
          <option value="active">Active</option>
          <option value="closed">Closed</option>
        </select>

        <button onClick={loadData}>Filter</button>
        <button onClick={downloadPdf}>Generate PDF</button>
      </div>

      <table border="1" width="100%" cellPadding="8">
        <thead>
          <tr>
            <th>Type</th>
            <th>Owner</th>
            <th>Hair</th>
            <th>Qty</th>
            <th>Location</th>
            <th>Status</th>
            <th>Date</th>
          </tr>
        </thead>
        <tbody>
          {posts.map((p) => (
            <tr key={p.postId}>
              <td>{p.postType}</td>
              <td>{p.ownerName}</td>
              <td>
                {p.hairLength}cm / {p.hairType} / {p.hairColor}
              </td>
              <td>{p.quantity}</td>
              <td>{p.location}</td>
              <td>{p.status}</td>
              <td>{new Date(p.createdAt).toLocaleDateString()}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default AdminPostStatus;
